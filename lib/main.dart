import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(startApp());
}
