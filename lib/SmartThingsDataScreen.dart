import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'DataAnalysis.dart';
import 'global.dart' as global;
class SmartThingsDataScreen extends StatefulWidget {
  const SmartThingsDataScreen({super.key});

  @override
  State<SmartThingsDataScreen> createState() => _SmartThingsDataScreenState();
}
//API 연결//
class _SmartThingsDataScreenState extends State<SmartThingsDataScreen> {
  final String apiKey = '30dd6a5d-deea-45db-b3f0-d071b145e539'; // API 키
  List<Map<String, dynamic>> _devices = [];
  double _totalPower = 0.0;
  List<double> _powerHistory = [];
  static const double co2EmissionFactor = 0.443; // CO2 배출계수 (kg/kWh)

  late Timer _timer;
  late Timer _resetTimer;

  Future<void> fetchSmartThingsData() async {
    const String endpoint = 'https://api.smartthings.com/v1/devices';

    try {
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {'Authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List devices = data['items'];

        double totalPower = 0.0;

        List<Map<String, dynamic>> updatedDevices = [];

        for (var device in devices) {
          final String deviceId = device['deviceId'];
          final String statusEndpoint =
              'https://api.smartthings.com/v1/devices/$deviceId/status';

          final statusResponse = await http.get(
            Uri.parse(statusEndpoint),
            headers: {'Authorization': 'Bearer $apiKey'},
          );

          if (statusResponse.statusCode == 200) {
            final statusData = jsonDecode(statusResponse.body);

            final powerValue = statusData['components']['main']['powerMeter']
                    ['power']['value'] ??
                0.0;
            final power = (powerValue is double)
                ? powerValue
                : double.tryParse(powerValue.toString()) ?? 0.0;

            updatedDevices.add({
              'deviceId': deviceId,
              'name': device['label'] ?? 'Unknown Device',
              'power': '$power W',
              'switchStatus': statusData['components']['main']['switch']
                      ['switch']['value'] ??
                  'off',
            });
          }
        }

        setState(() {
          for (var updatedDevice in updatedDevices) {
            final index = _devices.indexWhere(
                (device) => device['deviceId'] == updatedDevice['deviceId']);
            if (index != -1) {
              _devices[index]['power'] = updatedDevice['power'];
            } else {
              _devices.add(updatedDevice);
            }
          }
        });
      } else {
        print('Error fetching devices: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }
 // 현재 인덱스를 관리하는 변수
/* 
자정이 되었을 때 값 초기화
*/
void resetTotalPower() {
    print("인덱스 0 : ${ global.Global.totalCO2[0].value}");
    print("인덱스 1 : ${ global.Global.totalCO2[1].value}");
    print("인덱스 2 : ${ global.Global.totalCO2[2].value}");
    print("인덱스 3 : ${ global.Global.totalCO2[3].value}");
    print("인덱스 4 : ${ global.Global.totalCO2[4].value}");
  setState(() {
    // 유효한 인덱스 범위를 초과하지 않도록 설정
    if (global.Global.currentIndex >= 0 && global.Global.currentIndex < global.Global.totalCO2.length) {
      if (_powerHistory.isEmpty ||
          _powerHistory.last != _totalPower * co2EmissionFactor) {
        _powerHistory.add(_totalPower * co2EmissionFactor);
        // 글로벌 배열의 현재 인덱스에 값 저장
        global.Global.totalCO2[global.Global.currentIndex].value = _totalPower * co2EmissionFactor;
        _powerHistory.add(global.Global.totalCO2[global.Global.currentIndex].value);
        global.Global.currentIndex++; // 인덱스 증가
      }
     
    }

    // _totalPower 초기화
    _totalPower = 0.0;

    // 인덱스를 초과하면 다시 처음으로 순환 (선택 사항)
    if (global.Global.currentIndex >= global.Global.totalCO2.length) {
      global.Global.currentIndex = 0; // 또는 원하는 로직으로 처리
    }
  });
 
}

/*
  
*/
  void resetTotalPowerAtMidnight() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    _resetTimer = Timer(durationUntilMidnight, () {
      resetTotalPower();
      resetTotalPowerAtMidnight();
    });
  }

   Timer? _dataFetchTimer;
  Timer? _statusUpdateTimer;

  @override
  void initState() {
    super.initState();
    fetchSmartThingsData();

    // 5초마다 데이터 갱신
    _dataFetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchSmartThingsData();
    });

    // 1초마다 상태 및 가동 시간 갱신
    _statusUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (var device in _devices) {
          final now = DateTime.now();
          final lastUpdated = device['lastUpdated'] ?? now;

          final durationInSeconds = now.difference(lastUpdated).inSeconds;
          device['runningDuration'] =
              (device['runningDuration'] ?? 0) + durationInSeconds;
          device['lastUpdated'] = now;
        }
      });
    });

    resetTotalPowerAtMidnight();
  }

  @override
  void dispose() {
    // 타이머 정리
    _dataFetchTimer?.cancel();
    _statusUpdateTimer?.cancel();
    super.dispose();
  }

// 토글 : 온오프 변경
Future<void> toggleDeviceSwitch(String deviceId, String currentStatus) async {
  final String actionEndpoint =
      'https://api.smartthings.com/v1/devices/$deviceId/commands';
  final String newStatus = (currentStatus == 'on') ? 'off' : 'on';
  final String command = (newStatus == 'on') ? 'on' : 'off';

  final device = _devices.firstWhere((d) => d['deviceId'] == deviceId);

  // 상태 변경 전에 가동 시간과 총 전력량 업데이트
  updateStateDuration(device, newStatus);

  final response = await http.post(
    Uri.parse(actionEndpoint),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'commands': [
        {
          'component': 'main',
          'capability': 'switch',
          'command': command,
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    setState(() {
      final index =
          _devices.indexWhere((device) => device['deviceId'] == deviceId);
      if (index != -1) {
        _devices[index]['switchStatus'] = newStatus;
      }
    });
   
    // 상태 변경 후 전력량 업데이트
    final double power = double.tryParse(device['power'].replaceAll(' W', '')) ?? 0.0;
    _totalPower += power;
  } else {
    print('Error toggling device: ${response.statusCode}');
  }
  device['runningDuration'] = 0; //토글 이후 가동시간 초기화()
}


/*
 가동시간 및 전력량 계산
 */ 
  void updateStateDuration(Map<String, dynamic> device, String newState) {
    final now = DateTime.now();
    final lastUpdated = device['lastUpdated'] ?? now;

    // 상태 변화 전 가동 시간 계산
    final durationInSeconds = now.difference(lastUpdated).inSeconds;
    final durationInHours = durationInSeconds / 3600; // 시간 단위로 변환 ( 시간단위 작동 안하는중)
    final power = double.tryParse(device['power'].replaceAll(' W', '')) ?? 0.0;
      _totalPower += power * durationInHours;

    // 새로운 상태로 변경 후 초기화
    device['switchStatus'] = newState;
    device['lastUpdated'] = now;
    device['onDuration'] = (device['onDuration'] ?? 0) + durationInSeconds;
  }
//데이터 분석
void DataAnalysis() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DataAnalysisPage(index: global.Global.currentIndex),
    ),
  );
}


//빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SmartThings 데이터')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '전기의 사용에 따른 이산화탄소 배출량은 사용량(kWh)에 배출계수(0.443 CO2 kg/kWh)를 곱하여 계산합니다.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '총 사용 전력량: ${_totalPower.toStringAsFixed(2)} W\n'
              '총 이산화탄소 배출량: ${(co2EmissionFactor * _totalPower).toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              onPressed: resetTotalPower,
              child: const Text('테스트 : 자정이라고 가정'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(onPressed: DataAnalysis, 
              child: const Text('데이터 분석'))
          ),
          Expanded(
            child: _devices.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _devices.length,
                    itemBuilder: (context, index) {
                      final device = _devices[index];

                      // on과 off 시간 포맷
                      final onDuration =
                          Duration(seconds: device['onDuration'] ?? 0);
                      final offDuration =
                          Duration(seconds: device['offDuration'] ?? 0);

                      String formatDuration(Duration duration) {
                        return '${duration.inHours}:${duration.inMinutes % 60}:${duration.inSeconds % 60}';
                      }

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Icon(
                            device['switchStatus'] == 'on'
                                ? Icons.power
                                : Icons.power_off,
                            color: device['switchStatus'] == 'on'
                                ? Colors.green
                                : Colors.red,
                          ),
                          title: Text(device['name']),
                          subtitle: Text(
                            '전력량: ${device['power']} \n'
                            '가동 시간: ${formatDuration(Duration(seconds: device['runningDuration'] ?? 0))}',
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              device['switchStatus'] == 'on'
                                  ? Icons.power
                                  : Icons.power_off,
                              color: device['switchStatus'] == 'on'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            onPressed: () {
                              toggleDeviceSwitch(
                                  device['deviceId'], device['switchStatus']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // 그래프 부분 유지
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 22),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: 10,
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: _powerHistory.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    belowBarData: BarAreaData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 