import 'package:flutter/material.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'package:routemaster/routemaster.dart' as routemaster;

class PostsListItem extends StatelessWidget {
  const PostsListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          routemaster.Routemaster.of(context).push('/page/${post.id}');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              )),
          padding: const EdgeInsets.all(1.0),
          height: 240,
          width: 80,
          child: Column(
            children: [
              if (post.feature_image != null && post.feature_image.isNotEmpty)
                Container(
                  height: 200,
                  width: 500,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      post.feature_image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  width: 500,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 163, 9, 9),
                            Color.fromARGB(255, 223, 122, 8),
                          ])),
                ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
