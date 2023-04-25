import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

// Data
import 'package:stretching_assistant/data/timer.dart';
import 'package:stretching_assistant/utils.dart';

// Widget
import 'package:stretching_assistant/widget/inputfield.dart';

class AddExercisePage extends StatefulWidget {
  final Exercise exercise;

  const AddExercisePage({
    super.key,
    required this.exercise,
  });

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.exercise.name,
                style: TextStyle(
                  color: Utils.textColorAlt,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Image(
                height: 192,
                image: widget.exercise.image,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 32),
              Inputfield(
                value: time,
                isTime: true,
                onIncrease: () => setState(() => time != maxTime ? time++ : time),
                onDecrease: () => setState(() => time != 1 ? time-- : time),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(time);
            time = defaultTime;
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}