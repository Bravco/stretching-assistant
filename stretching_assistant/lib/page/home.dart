import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/trainings.dart';

// Widget
import 'package:stretching_assistant/widget/training_preview.dart';

// Page
import 'package:stretching_assistant/page/training/preview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
        children: [
          buildTitle("Preset"),
          ...presetTrainings.map((training) => buildTile(context, training)),
          if (customTrainings.isNotEmpty) ...[
            buildTitle("Custom"),
            ...customTrainings.map((training) => buildTile(context, training)),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 12,
          color: Utils.primaryColor,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: Utils.textColorAlt,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget buildTile(BuildContext context, Training training) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TrainingPage(training: training))),
        borderRadius: BorderRadius.circular(8),
        splashColor: Utils.primaryColorAlt,
        child: TrainingPreview(
          training: training,
          width: 320,
          height: 160,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}