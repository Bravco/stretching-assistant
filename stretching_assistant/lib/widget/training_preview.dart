import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

class TrainingPreview extends StatefulWidget {
  final Training training;
  final double width, height;
  final BorderRadiusGeometry? borderRadius;
  final bool editable;

  const TrainingPreview({
    super.key,
    required this.training,
    required this.width,
    required this.height,
    this.borderRadius,
    this.editable = false,
  });

  @override
  State<TrainingPreview> createState() => _TrainingPreviewState();
}

class _TrainingPreviewState extends State<TrainingPreview> {
  final TextEditingController controller = TextEditingController();
  int duration = 0;

  @override
  void initState() {
    super.initState();
    controller.text = widget.training.name;
    duration = widget.training.exercises.fold(0, (total, e) => total + e.value.toDuration().inSeconds) ~/ 60;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: widget.width,
      height: widget.training.image == null ? widget.height / 1.2 : widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: [Utils.boxShadow(Colors.black.withOpacity(.2))],
        color: widget.training.image == null ? Utils.secondaryBackgroundColor : null,
        image: widget.training.image != null ? DecorationImage(
          image: widget.training.image!,
          fit: BoxFit.cover,
        ) : null,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
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
              mainAxisAlignment: widget.training.image == null ? MainAxisAlignment.center : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.editable ? TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    setState(() {
                      widget.training.name = value;
                      widget.training.save();
                    });
                  },
                  maxLength: 16,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ) : Text(
                  widget.training.name,
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
                          "${widget.training.exercises.length} ${widget.training.exercises.length > 1 ? 'exercises' : 'exercise'}",
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
                          "$duration ${duration == 1 ? 'minute' : 'minutes'}",
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
    );
  }
}