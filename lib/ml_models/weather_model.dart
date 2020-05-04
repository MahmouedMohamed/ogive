import 'dart:io';

import 'package:stats/stats.dart';
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';
class Model {
  List<String> _days = [
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'D7',
    'D8',
    'D9',
    'D10',
    'D11',
    'D12',
    'D13',
    'D14',
    'D15',
    'D16',
    'D17',
  ];
  List<String> _outlook = [
    'sunny',
    'sunny',
    'clouds',
    'rain',
    'rain',
    'snow',
    'clouds',
    'sunny',
    'sunny',
    'rain',
    'sunny',
    'clouds',
    'clouds',
    'extreme',
    'clouds',
    'sunny',
    'clouds'
  ];
  List<double> _doubleTemperature = [
    27.3,
    30.1,
    25.2,
    19.3,
    18.5,
    10.4,
    21.7,
    29.5,
    23.1,
    17.3,
    27.8,
    20.1,
    19.8,
    7.1,
    17.85,
    20.0,
    32.0
  ];
  List<double> _doubleHumidity= [
    0.55,
    0.25,
    0.35,
    0.08,
    0.40,
    0.49,
    0.88,
    0.8,
    0.44,
    0.41,
    0.31,
    0.9,
    0.44,
    0.89,
    0.68,
    0.4,
    0.7
  ];
  List<double> _doubleWind = [
    5.7056,
    14.176,
    4.7056,
    5.7056,
    6.7056,
    13.176,
    12.176,
    3.7056,
    2.7056,
    6.7056,
    12.176,
    13.176,
    6.7056,
    14.176,
    2.6,
    5.0,
    4.0
  ];
  List<String> _decision = [
    'no',
    'no',
    'yes',
    'yes',
    'yes',
    'yes',
    'no',
    'no',
    'no',
    'yes',
    'no',
    'no',
    'yes',
    'yes',
    'yes',
    'yes',
    'no'
  ]; //wear white?
  _read() async {
    List<String> fileNames = ['outlook','temperature','humidity','windSpeed','decision'];
    try {
      final directory = await getApplicationDocumentsDirectory();
      for(int i=0;i<fileNames.length;i++){
        final file = File('${directory.path}/${fileNames.elementAt(i)}.txt');
        String text = await file.readAsString();
        List<String> _list = text.split(' ');
        _list.removeLast();
        print('thing $_list');
        switch(i){
          case 0:
            _list.forEach((element) {_outlook.add(element);});
            print('thing $_outlook');
            break;
          case 1:
            _list.forEach((element) {_doubleTemperature.add(double.parse(element));});
            print('thing $_doubleTemperature');
            break;
          case 2:
            _list.forEach((element) {_doubleHumidity.add(double.parse(element));});
            print('thing $_doubleHumidity');
            break;
          case 3:
            _list.forEach((element) {_doubleWind.add(double.parse(element));});
            print('thing $_doubleWind');
            break;
          case 4:
            _list.forEach((element) {_decision.add(element);});
            print('thing $_decision');
            break;
        }
      }
    } catch (e) {
      print("thing Couldn't read file");
    }
  }
  test(outlook, temperature, humidity, wind) async {
    await _read();
    List<List<double>> decisionYes = new List<List<double>>();
    List<List<double>> decisionNo = new List<List<double>>();
    List<List<double>> list = [
      _doubleTemperature,
      _doubleHumidity,
      _doubleWind
    ];
    List<double> testList = [temperature, humidity, wind];
    List<double> finalYes = new List<double>();
    List<double> finalNo = new List<double>();

    double totalYes = 0;
    double totalNo = 0;
    for (int i = 0; i < _decision.length; i++) {
      if (_decision.elementAt(i) == 'yes') {
        totalYes++;
      } else if (_decision.elementAt(i) == 'no') {
        totalNo++;
      }
    }
    double counter1 = 0;
    double counter2 = 0;
    for (int i = 0; i < _outlook.length; i++) {
      if (outlook == _outlook.elementAt(i) && _decision.elementAt(i) == 'yes') {
        counter1++;
      } else if (outlook == _outlook.elementAt(i) &&
          _decision.elementAt(i) == 'no') {
        counter2++;
      }
    }
    finalYes.add(counter1 / totalYes);
    finalNo.add(counter2 / totalNo);

    for (int i = 0; i < list.length; i++) {
      List<double> listoYES = new List<double>();
      List<double> listoNO = new List<double>();
      for (int j = 0; j < list.elementAt(i).length; j++) {
        if (_decision.elementAt(j) == 'yes') {
          listoYES.add(list.elementAt(i).elementAt(j));
        } else if (_decision.elementAt(j) == 'no') {
          listoNO.add(list.elementAt(i).elementAt(j));
        }
      }
      decisionYes.add(listoYES);
      decisionNo.add(listoNO);
    }
    for (int i = 0; i < list.length; i++) {
      finalYes
          .add(getProbability(decisionYes.elementAt(i), testList.elementAt(i)));
      finalNo
          .add(getProbability(decisionNo.elementAt(i), testList.elementAt(i)));
    }
    double resultYes = 1;
    double resultNo = 1;
    finalYes.forEach((element) {
      resultYes =
          resultYes * (element == 0 ? (1 / 4) / (totalYes + 1) : element);
    });
    finalNo.forEach((element) {
      resultNo = resultNo * (element == 0 ? (1 / 4) / (totalNo + 1) : element);
    });
    print('thing resultYes ${resultYes}');
    print('thing resultNo ${resultNo}');
    if(resultYes > resultNo)
      return 'yes';
    else
      return 'no';
  }

  getProbability(list, testValue) {
    final stats = Stats.fromData(list);
    return (1 / (math.sqrt(2 * math.pi) * (stats.standardDeviation))) *
        (math.exp(-math.pow((testValue - stats.average), 2) /
            (2 * (math.pow(stats.standardError, 2)))));
  }
}
