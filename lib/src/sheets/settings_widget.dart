import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import '../shared/gtext_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = context.watch<HomeController>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: controller.materias.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    GText(
                        controller.materias[index]['title']
                            .replaceAll("\n", " "),
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    GText(
                        " - " +
                            controller.materias[index]['totalLessons']
                                .toString() +
                            " aulas",
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SliderTheme(
                  data: SliderThemeData(
                      overlayShape: SliderComponentShape.noOverlay),
                  child: Slider(
                    value: double.parse(
                        controller.materias[index]['totalLessons'].toString()),
                    max: 30,
                    min: 1,
                    divisions: 30,
                    label:
                        controller.materias[index]['totalLessons'].toString(),
                    onChanged: (double value) {
                      controller.updateLessonsMax(index, value.toInt());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
