part of 'resources.dart';

class TextResources {
  final String appTitle = "Wallpy";
  final int itemLimit = 5;
  final String splashScreenRoute = '/';
  final String homeScreenRoute = '/home';
  final String detailScreenRoute = '/detail';
  final String snackBarLoadingInPagination = 'Loading';
  final String snackBarAllDataFetchInPagination = 'All Data Fetch';
  final String methodChannelName = "wallpyBackgroundService";
  final String methodChannelCallingServiceName = "StartService";
  final String methodChannelStopServiceName = "StopService";
}

enum Category { outside, flower, movie, city, nature }
