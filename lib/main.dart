import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/app_config.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/bloc_observer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().load();
  Bloc.observer = const SimpleBlocObserver();
  final postsRepository = PostsRepository();

  runApp(startApp(postsRepository));
}
