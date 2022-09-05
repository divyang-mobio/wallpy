part of 'resources.dart';

class TextResources {
  // AppBar title
  final String appTitle = "Wallpy";
  final String settingAppTitle = "Setting";

  // final String categoryAppTitle = "Category";
  final String adminAppTitle = "Admin";
  final String gradiantAppTitle = "Gradiant";
  final String favoriteAppTitle = "Favorite";
  final String newsDetailAppTitle = "News Details";
  final String newsAppTitle = "News";
  final String homeScreenLabel = "Home";

  // final String categoryScreenLabel = "Category";
  //bottom navigation bar name
  final String gradiantScreenLabel = "Gradiant";
  final String favouriteScreenLabel = "Favorite";
  final String settingScreenLabel = "Setting";
  final String newsScreenLabel = "News";
  final String splashScreenTile = "Wallpy";
  final String weatherTitle = "Weather";

  // final String latitude = "Latitude";
  // final String longitude = "Longitude";
  final String humidity = "Humidity";
  final String swWind = "SW Wind";
  final String visibility = "Visibility";
  final String pressure = "Air Pressure";
  final String noData = "Error No Data :(";
  final String downloadImage = "downloading";
  final String successImgDownloaded = "Save Image";
  final String errorImgDownloaded = "Not Able To download Image";
  final String errorWallpaperSetting = "Wallpaper Not Set";
  final String successWallpaperSetting = "Gradiant Wallpaper Set";
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
  final String url =
      "https://newsapi.org/v2/everything?q=world&apiKey=1b20cae31e6d41eeab3fad233fbeecbd";
  final String weatherUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToY5hNtemPEvOyyPKrWdVOZWR-gQBRI-ThmA&usqp=CAU";
  final String snackBarLoadingInPagination = 'Loading';
  final String snackBarAllDataFetchInPagination = 'All Data Fetch';

  //setting screen data
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
  final String screenDec =
      "Select Wallpaper setter screen. By default it is Home & lock screen";
  final String screenHomeDec = "Home Screen";
  final String screenLockDec = "Lock Screen";
  final String collectionTitle = "Collections";
  final String collectionDec =
      "Set wallpaper from Favorite/Random. By default it is Random.";

  final String emptyCart = "No Data in Favorite :(";
  final String blocError = "Error :(";
  final String categoryDetail = "CategoryDetails";
  final String googleSignInUp = "google Sign-In";
  final String signUp = 'Sign_Up';
  final String signIn = 'Sign-In';
  final String welcomeSubtitle =
      'Wallpy does not rely on fixed-time alarms that prevent your device from getting enough sleep. It lets Android figure out when is the best time to change wallpapers. You can configure constraints to only change wallpaper while your device is:';
  final String fireStoreCategory = "Category";
  final String fireStoreImgFav = "image_fav";
  final String fireStoreImgCat = "image_category";
  final String urlNotLoading = "not able to open url";
  final String darkModeTitle = "Dark Mode";
  final String source = "Source:-";
  final String categoryTitleNews = "News";
  final String fontFamily = "PTSans";
  final String adminTitle = "Admin";
  final String adminDec = "";
  final String alertBox = "OK";
  final String whenImgCatNotThere = "Pls enter Category & upload image";
  final String whenImgNotThere = "Pls upload image";
  final String whenCatNotThere = "Pls enter Category";
  final String submitItemToFireStore = "Submit";
  final String successItemToFireStore = "Success";
  final String addCatName = "Add Category";
  final String errorAtUploadImg = "Retry";
  final String uploadImgButton = "Upload Image";
  final String imgSizeMore = 'Image Size is more than 100kb';
  final String imgAspectRatio = "pls upload image of aspect ratio of 16:9";
  final String imgIsNotSelected = 'No Image Path Received';
  final String permissionIsNotGiven =
      'Permission not granted. Try Again with permission access';
  final String ifErrorHappenTimeOfRemoveImage = "Not Able to remove Image :(";
  final String imageStoreInStoragePath = "image/";

//Int type
  final int adsInternalInList = 5;
  final int androidAlarmManagerId = 0;
  final int itemLimit = 5;

//routes Strings
  final String splashScreenRoute = '/';
  final String homeScreenRoute = '/bottomBar';
  final String welcomeScreenRoute = '/welcome';
  final String detailScreenRoute = '/detail';
  final String detailNewsScreenRoute = "/detailNews";
  final String signUpScreenRoute = '/signUp';
  final String detailGradiantScreenRoute = "/detailGradiant";
  final String searchScreenRoute = '/search';
  final String signInScreenRoute = '/signIn';
  final String newsCategoryScreenRoute = "/newCategory";
  final String adminRoute = "/Admin";
  final String redirectScreen = "/redirect";
  final String onSearchNoDataFound = "No Data Found :(";
  final String searchHint = "Search";
  final String placeHolderForLoadingImage = "assets/black_preloading.gif";
  final String placeHolderForLoadingImageDark = "assets/preloading_dark.gif";
}

List<SettingModel> dialogDataForTimeLine = [
  SettingModel(title: "15 minutes", onclick: 15),
  SettingModel(title: "30 minutes", onclick: 30),
  SettingModel(title: "60 minutes", onclick: 60),
  SettingModel(title: "6 hours", onclick: 360),
  SettingModel(title: "24 hours", onclick: 1440)
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
  SettingModel(title: "Random", onclick: "random"),
  SettingModel(title: "Favorite", onclick: "favorite"),
];

DataModel loadingDataModel = DataModel(
    id: 1,
    name: "Loading",
    uid: "Loading",
    category: [],
    fav: false,
    timestamp: DateTime(2022 - 08 - 03, 1, 3),
    url: "Loading",
    wallpy_unm: "Loading");

List<BottomNavigationModel> bottomData = [
  BottomNavigationModel(
      actionIcon: IconsResources().homeScreenSelected,
      icon: IconsResources().homeScreenUnSelected,
      label: TextResources().homeScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().gradiantScreenUnSelectedSelected,
      icon: IconsResources().gradiantScreenUnSelectedSelected,
      label: TextResources().gradiantAppTitle),
  BottomNavigationModel(
      actionIcon: IconsResources().weatherIconSelected,
      icon: IconsResources().weatherIconUnselected,
      label: TextResources().weatherTitle),
  BottomNavigationModel(
      actionIcon: IconsResources().favouriteScreenSelected,
      icon: IconsResources().favouriteScreenUnSelected,
      label: TextResources().favouriteScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().newScreenUnSelectedSelected,
      icon: IconsResources().newScreenUnSelectedSelected,
      label: TextResources().newsScreenLabel),
  BottomNavigationModel(
      actionIcon: IconsResources().settingScreenSelected,
      icon: IconsResources().settingScreenUnSelected,
      label: TextResources().settingScreenLabel)
];

List<NewsCategory> categoryData = [
  NewsCategory(
      title: "War",
      link:
          "https://newsapi.org/v2/everything?q=war&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2Fwar.jpg?alt=media&token=2da6d4e5-cd93-433c-834e-8e3ce7961401"),
  NewsCategory(
      title: "Car",
      link:
          "https://newsapi.org/v2/everything?q=car&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2Fcar.jpg?alt=media&token=ebb7cc38-6426-45e9-95a2-393b53175a58"),
  NewsCategory(
      title: "Airplane",
      link:
          "https://newsapi.org/v2/everything?q=airplane&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2Fairplane.jpg?alt=media&token=d8c9974c-4441-4f86-9543-7058a21814b3"),
  NewsCategory(
      title: "Business",
      link:
          "https://newsapi.org/v2/everything?q=business&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2Fbusiness.jpg?alt=media&token=f0b7476e-125f-4872-b7f6-ebcf8c1ea87b"),
  NewsCategory(
      title: "BitCoin",
      link:
          "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2FBitCoin.jpg?alt=media&token=98a0f344-31f2-45e8-8bf7-96466d0555a8"),
  NewsCategory(
      title: "Sport",
      link:
          "https://newsapi.org/v2/everything?q=sport&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2FSport.jpg?alt=media&token=d5eca19a-f3d3-43ae-a4fe-d8c2459feb1f"),
  NewsCategory(
      title: "Stock Market",
      link:
          "https://newsapi.org/v2/everything?q=stock&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2FStock.jpg?alt=media&token=4b9a62b2-c9c8-4551-8a7d-b3b3d05612cf"),
  NewsCategory(
      title: "Tech",
      link:
          "https://newsapi.org/v2/everything?q=tech&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2FTech.jpg?alt=media&token=f9abf7d0-0b00-4e46-bdf0-f9d26a3c33b2"),
  NewsCategory(
      title: "Apple",
      link:
          "https://newsapi.org/v2/everything?q=apple&apiKey=1b20cae31e6d41eeab3fad233fbeecbd",
      imageLink:
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/news_category_cover%2FApple.jpg?alt=media&token=5090de5a-f070-4d85-9ba9-b6804c27748b")
];

List<String> monthData = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
