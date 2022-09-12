import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controllers/add_category_bloc/add_category_bloc.dart';
import '../controllers/add_other_category_bloc/add_other_category_bloc.dart';
import '../controllers/admin_visible_bloc/admin_visible_bloc.dart';
import '../controllers/auth_bloc/auth_bloc_bloc.dart';
import '../controllers/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import '../controllers/category_bloc/category_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../controllers/data_fetch_bloc/data_fetch_bloc.dart';
import '../controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../controllers/download_image_bloc/download_image_bloc.dart';
import '../controllers/favorite_bloc/favorite_bloc.dart';
import '../controllers/gradiant_bloc/gradiant_bloc.dart';
import '../controllers/month_selected_bloc/month_selected_bloc.dart';
import '../controllers/new_category_bloc/news_category_bloc.dart';
import '../controllers/news_data_fetch_bloc/news_data_fetch_bloc.dart';
import '../controllers/search_bloc/search_bloc.dart';
import '../controllers/service_bloc/service_bloc.dart';
import '../controllers/upload_data_fireStore_bloc/upload_data_fire_store_bloc.dart';
import '../controllers/upload_image_bloc/upload_image_bloc.dart';
import '../controllers/weather_bloc/weather_bloc.dart';
import '../resources/resources.dart';
import '../utils/auth_repository.dart';
import '../utils/firestore_database_calling.dart';
import '../utils/http_requets.dart';
import '../utils/news_api_calling.dart';
import '../utils/store_data.dart';
import 'material_app.dart';

class BlocClass extends StatelessWidget {
  const BlocClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DataFetchBloc>(
          create: (context) =>
              DataFetchBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                ..add(GetAllData(isFavorite: false, category: null))),
      BlocProvider<DarkModeBloc>(
          create: (context) =>
              DarkModeBloc(RepositoryProvider.of<PreferenceServices>(context))
                ..add(Check())),
      BlocProvider<DetailScreenBloc>(
          create: (context) => DetailScreenBloc()..add(OnTab(isVis: true))),
      BlocProvider<BottomNavigationBloc>(
          create: (context) =>
              BottomNavigationBloc()..add(OnChangeBar(index: 0))),
      BlocProvider<GradiantBloc>(
          create: (context) => GradiantBloc()
            ..add(SelectedColor(
                myColor: ColorResources().pickerGradiantDefault))),
      BlocProvider<MonthSelectedBloc>(
          create: (context) => MonthSelectedBloc(monthData)),
      BlocProvider<UploadImageBloc>(create: (context) => UploadImageBloc()),
      BlocProvider<DownloadImageBloc>(create: (context) => DownloadImageBloc()),
      BlocProvider<AddCategoryBloc>(
          create: (context) =>
              AddCategoryBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                ..add(ShowCategory())),
      BlocProvider<AddOtherCategoryBloc>(
          create: (context) => AddOtherCategoryBloc()),
      BlocProvider<UploadDataFireStoreBloc>(
          create: (context) => UploadDataFireStoreBloc()),
      BlocProvider<AdminVisibleBloc>(
          create: (context) => AdminVisibleBloc(CheckAdminFireStore(),
              RepositoryProvider.of<PreferenceServices>(context))
            ..add(CheckAdmin())),
      BlocProvider<ServiceBloc>(
          create: (context) => ServiceBloc()
            ..add(CheckService(
                pref: RepositoryProvider.of<PreferenceServices>(context)))),
      BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(FirebaseDatabase())
            ..add(GetFavoriteData(isFavorite: true, category: null))),
      BlocProvider<SearchBloc>(
          create: (context) =>
              SearchBloc(RepositoryProvider.of<FirebaseDatabase>(context))),
      BlocProvider<NewsDataFetchBloc>(
          create: (context) =>
              NewsDataFetchBloc(RepositoryProvider.of<HttpService>(context))
                ..add(GetAllNewsData(url: TextResources().url))),
      BlocProvider<AuthBlocBloc>(
          create: (context) => AuthBlocBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              googleSignIn: RepositoryProvider.of<GoogleSignIn>(context))),
      BlocProvider<NewsCategoryBloc>(create: (context) => NewsCategoryBloc()),
      BlocProvider<CategoryBloc>(
          create: (context) =>
              CategoryBloc(RepositoryProvider.of<FirebaseDatabase>(context))
                ..add(const GetAllCategory(category: []))),
      BlocProvider<WeatherBloc>(
          create: (context) =>
              WeatherBloc(RepositoryProvider.of<HttpRequests>(context))
                ..add(const GetAllWeather(weather: null))),
    ], child: MaterialAppClass());
  }
}
