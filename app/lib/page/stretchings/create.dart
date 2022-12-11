import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Model
import 'package:app/model/stretching.dart';

//Data
import 'package:app/data/stretchings.dart';

//Widgets
import 'package:app/widget/appbar.dart';
import 'package:app/widget/textfield_dialog.dart';
import 'package:app/widget/stretchings/create/list_item.dart';
import 'package:app/widget/stretchings/create/drop_zone.dart';

class CreateStretchingPage extends StatefulWidget {
  const CreateStretchingPage({ Key? key }) : super(key: key);

  @override
  State<CreateStretchingPage> createState() => _CreateStretchingPageState();
}

class _CreateStretchingPageState extends State<CreateStretchingPage> {
  late TextEditingController textDialogController;
  final GlobalKey draggableKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    textDialogController = TextEditingController();
  }

  @override
  void dispose() {
    textDialogController.dispose();

    super.dispose();
  }

  void itemDroppedOnDropZone(int item) {
    setState(() {
      selected.add(item);
    });
  }
  
  void saveStretching(BuildContext context) {
    if (selected.isNotEmpty) {
      customStretchings.add(
        CustomStretching(
          title: tempTitle == null ? "Title" : tempTitle as String,
          stretches: selected,
        ),
      );

      tempTitle = null;
      selected = [];
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPf(
        title: tempTitle == null ? "Title" : tempTitle as String,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                final stretchingTitle = await openDialog(context, textDialogController, "Edit Stretching Name", "Title");
                if (stretchingTitle == null || stretchingTitle.isEmpty) return;

                setState(() {
                  tempTitle = stretchingTitle;
                });
              },
              child: const Icon(
                Icons.edit,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: buildDropZone(),
              ),
              Expanded(
                child: buildMenuList(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          saveStretching(context);
        },
        backgroundColor: utils.color10,
        child: const Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget buildMenuList() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 2,
            color: utils.color0Alt,
            indent: 64,
            endIndent: 64,
          ),
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stretchings[0].stretches,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 12.0,
              );
            },
            itemBuilder: (context, index) {
              return LongPressDraggable<int>(
                data: index,
                dragAnchorStrategy: pointerDragAnchorStrategy,
                delay: const Duration(milliseconds: 300),
                feedback: DraggingListItem(
                  dragKey: draggableKey,
                  imageProvider: AssetImage("assets/stretchings/karate/stretches/$index.png"),
                ),
                child: ListItem(
                  imageProvider: AssetImage("assets/stretchings/karate/stretches/$index.png"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDropZone() {
    return DragTarget<int>(
      builder: (context, candidateItems, rejectedItems) {
        // ignore: prefer_const_constructors
        return DropZone();
      },
      onAccept: (item) {
        itemDroppedOnDropZone(item);
      },
    );
  }
}