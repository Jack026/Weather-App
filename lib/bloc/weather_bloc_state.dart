import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();
  
  @override
  List<Object> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}
class WeatherBlocFailure extends WeatherBlocState {}
class WeatherBlocSuccess extends WeatherBlocState {
  late final Weather weather;

  WeatherBlocSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}
