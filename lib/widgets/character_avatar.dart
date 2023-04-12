import "package:flutter/material.dart";
import "package:rick_and_morty_app/models/character.dart";

class AvatarImage extends StatelessWidget {
  final int index;
  final String image;
  final Status status;
  const AvatarImage(
      {super.key,
      required this.index,
      required this.image,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipOval(
            child: Hero(
              tag: "imageId - $index",
              child: Image(fit: BoxFit.cover, image: NetworkImage(image)),
            ),
          ),
          Positioned(
            right: 1,
            bottom: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: statusColor(status),
                borderRadius: BorderRadius.circular(400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color statusColor(Status status) {
    switch (status) {
      case Status.alive:
        return Colors.green;
      case Status.dead:
        return Colors.red;
      case Status.unknown:
        return Colors.grey;
    }
  }
}
