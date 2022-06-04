import 'package:exams_quizzes_alike/models/option.dart';
import 'package:exams_quizzes_alike/utils/callbacks/option_callback.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget(
      {Key? key,
      required this.option,
      required this.type,
      required this.callback})
      : super(key: key);

  final Option option;
  final String type;
  final OptionCallback callback;

  @override
  State<OptionWidget> createState() => OptionWidgetState();
}

class OptionWidgetState extends State<OptionWidget> {
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case "unica-respuesta":
        return Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Checkbox(
                  value: checkboxValue,
                  activeColor: Colors.indigo,
                  onChanged: (value) {
                    setState(() {});
                    checkboxValue = value!;
                    widget.callback(widget.option.description);
                  },
                ),
                const SizedBox(width: 10),
                Text(widget.option.description),
              ],
            ));
      case 'multiple-respuesta':
        return Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Checkbox(
                  value: checkboxValue,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      checkboxValue = value!;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Text(widget.option.description),
              ],
            ));

      case 'completar':
        return Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Flexible(
                    child: TextField(
                  decoration: InputDecoration(
                    hintText: widget.option.description,
                    prefixIcon: const Icon(
                      Icons.text_fields,
                    ),
                    focusColor: Colors.deepPurple,
                  ),
                  onChanged: (value) {},
                )),
              ],
            ));
      default:
        return const Text('Tipo de pregunta no encontrado');
    }
  }

  String getOptionDescription() {
    return widget.option.description;
  }
}
