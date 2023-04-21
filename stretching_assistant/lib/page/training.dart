import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Widget
import 'package:stretching_assistant/widget/training_preview.dart';

class TrainingPage extends StatelessWidget {
  final Training training;

  const TrainingPage({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: TrainingPreview(
          training: training,
          width: MediaQuery.of(context).size.width,
          height: 160,
        ),
      ),
    );
  }
}