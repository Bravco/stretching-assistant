import 'package:flutter/material.dart';
import 'package:stretching_assistant/data/trainings.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Widget
import 'package:stretching_assistant/widget/training_preview.dart';

// Page
import 'package:stretching_assistant/page/training/exercises.dart';
import 'package:stretching_assistant/page/training/timer.dart';

class TrainingPage extends StatefulWidget {
  final Training training;
  final bool isCustom, forceEditing;

  const TrainingPage({
    super.key,
    required this.training,
    this.isCustom = false,
    this.forceEditing = false,
  });

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    isEditing = widget.forceEditing;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: widget.isCustom ? [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:(context) {
                    return AlertDialog(
                      title: const Text("Please confirm"),
                      content: Text("Are you sure to delete ${widget.training.name}?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() => customTrainings.remove(widget.training));
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Utils.primaryColor),
                          ),
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () =>  Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete_forever),
            ),
            IconButton(
              onPressed: () => setState(() => isEditing = !isEditing),
              icon: Icon(isEditing ? Icons.save : Icons.edit),
            ),
          ] : null,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TrainingPreview(
                training: widget.training,
                width: MediaQuery.of(context).size.width,
                height: widget.isCustom ? 192 : 160,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              ),

              for (int i = 0; i < widget.training.exercises.length; i++) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.training.exercises[i].key.name,
                              style: TextStyle(
                                color: Utils.textColorAlt,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              Utils.formatSeconds(widget.training.exercises[i].value.inSeconds),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Image(
                          height: 96,
                          image: widget.training.exercises[i].key.image,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ExercisesPage(),
            )).then((value) {
              if (value != null) {
                setState(() => widget.training.exercises.add(value));
              }
            });
            if (isEditing) return;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TrainingTimerPage(training: widget.training),
            ));
          },
          child: Icon(isEditing ? Icons.add : Icons.play_arrow),
        ),
      ),
    );
  }
}