import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/bloc/page_bloc.dart';
import 'package:flutter_application_1/page/view/page_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostViewPage extends StatelessWidget {
  final String id;
  PostViewPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => PageBloc()..add(PageFetched(id)),
        child: PageViewBody(),
      ),
    );
  }
}
