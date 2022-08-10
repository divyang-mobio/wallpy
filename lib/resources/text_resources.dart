part of 'resources.dart';

class TextResources {
  final String appTitle = "Wallpy";
  final String settingAppTitle = "Setting";
  final String categoryAppTitle = "Category";
  final String favoriteAppTitle = "Favorite";
  final String homeScreenLabel = "Home";
  final String categoryScreenLabel = "Category";
  final String favouriteScreenLabel = "Favorite";
  final String settingScreenLabel = "Setting";
  final String splashScreenTile = "Wallpy";

  final String signInTitle = "Welcome  Back";
  final String signUpTitle = "Create Account";
  final String email = "Email";
  final String password = "Password";
  final String name = "Name";
  final String or = "OR";
  final String passwordValidate = "Password can't be empty";
  final String enterPassword = "Enter a password with length at least 6";
  final String enterEmail = "Enter a correct email";
  final String nameValidate = "Name can't be empty";
  final String emailValidate = "Email can't be empty";
  final String failedErrorCode = "Failed with error code:";

  final String snackBarLoadingInPagination = 'Loading';
  final String snackBarAllDataFetchInPagination = 'All Data Fetch';
  final String methodChannelName = "wallpyBackgroundService";
  final String methodChannelCallingServiceName = "StartService";
  final String methodChannelStopServiceName = "StopService";
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
  final String startService = "Start Service";
  final String stopService = "Stop Service";
  final String categoryDetail = "CategoryDetails";
  final String googleSignInUp = "google Sign-In";
  final String signUp = 'Sign_Up';
  final String signIn = 'Sign-In';
  final String welcomSubtitle =
      'Walpy does not rely on fixed-time alarms that prevent your device from getting enough sleep. It lets Android figure out when is the best time to change wallpapers. You can configure constraints to only change wallpaper while your device is:';
  final String fireStoreCategory = "Category";
  final String fireStoreImgFav = "image_fav";
  final String fireStoreImgCat = "image_category";
//Int type
  final int adsInternalInList = 2;
  final int androidAlarmManagerId = 0;
  final int itemLimit = 5;

//routes Strings
  final String splashScreenRoute = '/';
  final String homeScreenRoute = '/bottomBar';
  final String welcomeScreenRoute = '/welcome';
  final String detailScreenRoute = '/detail';
  final String signUpScreenRoute = '/signUp';
  final String searchScreenRoute = '/search';
  final String signInScreenRoute = '/signIn';
  final String onSearchNoDataFound = "No Data Found :(";
  final String searchHint = "Search";
  final String placeHolderForLoadingImage = "assets/99318-hms-loading.gif";
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
  SettingModel(title: "Random", onclick: "homeScreen"),
  SettingModel(title: "Favorite", onclick: "favorite"),
];

DataModel loadingDataModel = DataModel(
    id: 1,
    name: "Loading",
    uid: "Loading",
    category: [],
    fav: false,
    timestamp: DateTime(2022 - 08 - 03, 1, 3),
    url: "Loading");

List<BottomNavigationModel> bottomData = [
  BottomNavigationModel(
      actionIcon: IconsResources().homeScreenSelected,
      icon: IconsResources().homeScreenUnSelected,
      label: TextResources().homeScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().categoryScreenSelected,
      icon: IconsResources().categoryScreenUnSelected,
      label: TextResources().categoryScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().favouriteScreenSelected,
      icon: IconsResources().favouriteScreenUnSelected,
      label: TextResources().favouriteScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().settingScreenSelected,
      icon: IconsResources().settingScreenUnSelected,
      label: TextResources().settingScreenLabel)
];
