part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppThemeUpdateState extends AppState {}

class AppInternetConnectedState extends AppState {}

class AppInternetDisconnectedState extends AppState {}
