import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/auth_repository.dart';
import '../utils/firestore_database_calling.dart';
import '../utils/http_requets.dart';
import '../utils/news_api_calling.dart';
import '../utils/store_data.dart';
import 'blocs.dart';

class RepositoryClass extends StatelessWidget {
  const RepositoryClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<FirebaseDatabase>(
          create: (context) => (FirebaseDatabase())),
      RepositoryProvider<AuthRepository>(create: (context) => AuthRepository()),
      RepositoryProvider<GoogleSignIn>(create: (context) => GoogleSignIn()),
      RepositoryProvider<HttpService>(create: (context) => HttpService()),
      RepositoryProvider<HttpRequests>(create: (context) => HttpRequests()),
      RepositoryProvider<PreferenceServices>(
          create: (context) => PreferenceServices()),
    ], child: const BlocClass());
  }
}
