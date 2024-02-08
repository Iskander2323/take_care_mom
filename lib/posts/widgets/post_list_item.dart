import 'package:flutter/material.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'package:routemaster/routemaster.dart' as routemaster;

class PostsListItem extends StatelessWidget {
  const PostsListItem({required this.post, super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
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
          height: 245,
          width: 80,
          child: Column(
            children: [
              if (post.featureImage.isNotEmpty)
                SizedBox(
                  height: 200,
                  width: 500,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      post.featureImage,
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
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
