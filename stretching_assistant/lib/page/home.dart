import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/trainings.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: trainings.length,
        itemBuilder: (context, i) {
          Training training = trainings[i];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: InkWell(
              onTap: () {},
              splashColor: Utils.primaryColorAlt,
              child: Ink(
                width: 320,
                height: 160,
                decoration: BoxDecoration(
                  boxShadow: [Utils.boxShadow(Colors.black.withOpacity(.2))],
                  image: DecorationImage(
                    image: training.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.1),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            training.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.bolt,
                                    color: Utils.primaryColor,
                                  ),
                                  Text(
                                    "${training.exercises.length} ${training.exercises.length > 1 ? 'exercises' : 'exercise'}",
                                    style: TextStyle(
                                      color: Utils.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Utils.primaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${training.exercises.fold(0, (total, e) => total + e.value.inSeconds) ~/ 60} minutes",
                                    style: TextStyle(
                                      color: Utils.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}