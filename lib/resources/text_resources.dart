part of 'resources.dart';

class TextResources {
  final String appTitle = "Wallpy";
  final String settingAppTitle = "Setting";
  final String favoriteAppTitle = "Favorite";
  final String homeScreenLabel = "Home";
  final String favouriteScreenLabel = "Favorite";
  final String settingScreenLabel = "Setting";
  final String splashScreenTile = "Wallpy";
  final int itemLimit = 5;
  final String splashScreenRoute = '/';
  final String homeScreenRoute = '/bottomBar';
  final String detailScreenRoute = '/detail';
  final String snackBarLoadingInPagination = 'Loading';
  final String snackBarAllDataFetchInPagination = 'All Data Fetch';
  final String methodChannelName = "wallpyBackgroundService";
  final String methodChannelCallingServiceName = "StartService";
  final String methodChannelStopServiceName = "StopService";
  final int androidAlarmManagerId = 0;
  final String bottomSheetTitle = "Select Screen";
  final String homeScreenWallpaper = "On Home Screen";
  final String lockScreenWallpaper = "On Lock Screen";
  final String bothScreenWallpaper = "On Both Screen";
  final String changeWallpaperTitle = "Auto change wallpaper";
  final String changeWallpaperDec =
      "Change wallpaper periodically, based on below condition";
  final String intervalTitle = "Interval";
  final String intervalDec =
      "Wallpaper Change as per selected Time. By default it is 15 min.";
  final String screenTitle = "Select Screen";
  final String screenDec = "Home & Lock Screen";
  final String screenHomeDec = "Home Screen";
  final String screenLockDec = "Lock Screen";
  final String collectionTitle = "Collections";
  final String collectionDec =
      "Set wallpaper from Favorite/Random. By default it is Random.";
  final String emptyCart = "No Data in Favorite :(";
  final String blocError = "Error :(";
}

List<SettingModel> dialogDataForTimeLine = [
  SettingModel(title: "15 minutes", onclick: 15),
  SettingModel(title: "30 minutes", onclick: 30),
  SettingModel(title: "60 minutes", onclick: 60),
  SettingModel(title: "6 hours", onclick: 360),
  SettingModel(title: "24 hours", onclick: 1440),
];

List<SettingModel> bottomSheetScreenData = [
  SettingModel(
      title: TextResources().homeScreenWallpaper,
      onclick: WallpaperManagerFlutter.HOME_SCREEN),
  SettingModel(
      title: TextResources().lockScreenWallpaper,
      onclick: WallpaperManagerFlutter.LOCK_SCREEN),
  SettingModel(
      title: TextResources().bothScreenWallpaper,
      onclick: WallpaperManagerFlutter.BOTH_SCREENS)
];

List<SettingModel> dialogDataForCollection = [
  SettingModel(title: "Home Screen", onclick: "homeScreen"),
  SettingModel(title: "Favorite Screen", onclick: "favorite"),
];
