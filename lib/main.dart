// lib/main.dart
import 'package:brain_station_project_task/core/constants/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import 'features/repos/logic/bloc/repo_bloc.dart';
 import 'features/splash_screen.dart';
 

void main() {
  runApp(  MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    
      providers: [
        BlocProvider<RepositoryBloc>(
          create: (context) => RepositoryBloc(ApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Repository Explorer',
        home: SplashScreenWrapper(),
      ),
    );
  }
}
