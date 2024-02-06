import 'package:flutter/material.dart';
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:routemaster/routemaster.dart' as routemaster;

class CategoriesListItem extends StatelessWidget {
  const CategoriesListItem({required this.categorie, super.key});

  final Categorie categorie;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          routemaster.Routemaster.of(context).push('/posts/${categorie.slug}');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              )),
          padding: EdgeInsets.all(1.0),
          height: 200,
          width: 80,
          child: Column(
            children: [
              Container(
                height: 130,
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 41, 1, 153),
                          Color.fromARGB(255, 0, 212, 184),
                        ])),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(categorie.name),
                    Text(categorie.slug),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
