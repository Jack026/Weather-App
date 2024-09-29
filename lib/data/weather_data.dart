import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final int? weatherConditionCode;
  final double? temperature;
  final double? tempMax;
  final double? tempMin;
  final String? areaName;
  final DateTime? date;
  final DateTime? sunrise;
  final DateTime? sunset;
  final String? weatherMain;

  const WeatherData({
    this.weatherConditionCode,
    this.temperature,
    this.tempMax,
    this.tempMin,
    this.areaName,
    this.date,
    this.sunrise,
    this.sunset,
    this.weatherMain,
  });

  @override
  List<Object?> get props => [
    weatherConditionCode,
    temperature,
    tempMax,
    tempMin,
    areaName,
    date,
    sunrise,
    sunset,
    weatherMain,
  ];
}
