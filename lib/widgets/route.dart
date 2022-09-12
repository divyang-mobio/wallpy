import 'package:flutter/material.dart';
import 'package:wallpy/screens/occasion_detail_screen.dart';
import 'package:wallpy/screens/redirect_screen.dart';
import '../models/navigation_model.dart';
import '../models/news_category_model.dart';
import '../screens/admin_screen.dart';
import '../screens/bottom_navigation_screen.dart';
import '../screens/detail_news_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/gradiant_detail.dart';
import '../screens/gradiant_screen.dart';
import '../screens/main_screen.dart';
import '../screens/news_category_list_screen.dart';
import '../screens/search_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case "/bottomBar":
        return MaterialPageRoute(
            builder: (context) => const BottomNavigationBarScreen());
      case "/detail":
        final args = setting.arguments as DetailScreenArgument;
        return MaterialPageRoute(
            builder: (context) => DetailScreen(dataModel: args.dataModel));
      case "/detailNews":
        final args = setting.arguments as DetailNewsScreenArgument;
        return MaterialPageRoute(
            builder: (context) => DetailNewsScreen(articles: args.articles));
      case "/search":
        final args = setting.arguments as SearchScreenArgument;
        return MaterialPageRoute(
            builder: (context) => SearchScreen(screen: args.selectedScreen));
      case "/welcome":
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case "/signUp":
        return MaterialPageRoute(builder: (context) => const SignUp());
      case "/signIn":
        return MaterialPageRoute(builder: (context) => const SignIn());
      case "/ocassion":
        return MaterialPageRoute(
            builder: (context) => OccasionDetailScreen(
                  data: [],
                  title: '',
                ));
      case "/detailGradiant":
        final args = setting.arguments as DetailGradiantScreenArgument;
        return MaterialPageRoute(
            builder: (context) => DetailGradiantScreen(myColor: args.myColor));
      case "/Admin":
        return MaterialPageRoute(builder: (context) => const AdminScreen());
      case "/redirect":
        return MaterialPageRoute(builder: (context) => RedirectScreen());
      case "/gradiant":
        return MaterialPageRoute(builder: (context) => const GradiantScreen());
      case "/newCategory":
        final args = setting.arguments as NewsCategory;
        return MaterialPageRoute(
            builder: (context) => NewsCategoryScreen(category: args));
      default:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
    }
  }
}
