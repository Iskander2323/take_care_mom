import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/categories/widgets/bottom_loader.dart';
import 'package:flutter_application_1/page/bloc/page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PageViewBody extends StatelessWidget {
  const PageViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        switch (state.status) {
          case PageStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PageStatus.success:
            if (state.page.isEmpty) {
              return const Center(child: Text('no posts'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      state.page.first.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 3,
                        bottom: 20,
                      ),
                      child: HtmlWidget(state.page.first.html)),
                ],
              ),
            );

          case PageStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
