import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.imageProvider,
    this.isDepressed = false,
  });

  final ImageProvider imageProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: utils.color30,
      width: 256,
      height: 256,
      child: Image(
        image: imageProvider,
        fit: BoxFit.scaleDown,
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * .2,
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.imageProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-.5, -.5),
      child: Opacity(
        opacity: .75,
        child: Container(
          color: utils.color30,
          child: Image(
            image: imageProvider,
            fit: BoxFit.scaleDown,
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .2,
          ),
        ),
      ),
    );
  }
}