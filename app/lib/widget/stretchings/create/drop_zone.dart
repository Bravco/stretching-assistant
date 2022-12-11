import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/stretchings.dart';

//Libaries
import 'package:flutter_slidable/flutter_slidable.dart';

class DropZone extends StatefulWidget {
  const DropZone({ super.key });

  @override
  State<DropZone> createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  @override
  Widget build(BuildContext context) {
    return selected.isEmpty
    ? const Center(
      child: Text(
        "Drag here.",
        style: TextStyle(
          color: utils.color0Alt,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    )
    : ReorderableListView.builder(
      itemCount: selected.length,
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex) newIndex--;

        setState(() {
          final item = selected.removeAt(oldIndex);
          selected.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(index),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                backgroundColor: utils.color10Alt,
                foregroundColor: utils.color0Alt,
                icon: Icons.delete_outline,
                label: "Remove",
                onPressed: (context) {
                  setState(() => selected.removeAt(index));
                },
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              color: utils.color30,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${index + 1}.",
                      style: const TextStyle(
                        color: utils.color0,
                        fontWeight: FontWeight.w300,
                        fontSize: 32,
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 2,
                      color: utils.color0Alt,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Image(
                      image: AssetImage("assets/stretchings/karate/stretches/${selected[index]}.png"),
                      fit: BoxFit.scaleDown,
                      width: MediaQuery.of(context).size.width * .4,
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}