import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import '../shared/gtext_widget.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({Key? key}) : super(key: key);

  @override
  _AddLessonState createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  String dropdownMateria = 'legislacao';
  bool loading = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  formatIt(date) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = context.read<HomeController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Matéria da aula:"),
            DropdownButton<String>(
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownMateria = newValue!;
                });
              },
              value: dropdownMateria,
              items: <Map>[
                {'id': 'legislacao', 'title': "Legislação de Trânsito"},
                {'id': 'direcao', 'title': "Direção Defensiva"},
                {'id': 'socorros', 'title': "Primeiros Socorros"},
                {'id': 'meioambiente', 'title': "Meio Ambiente"},
                {'id': 'mecanica', 'title': "Mecância Básica"},
              ].map<DropdownMenuItem<String>>((Map value) {
                return DropdownMenuItem<String>(
                  value: value['id'],
                  child: Text(value['title']),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Data da aula:"),
            Stack(
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(color: Colors.black),
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                        ),
                        onPressed: () async {
                          var day = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020, 1),
                              lastDate: DateTime.now(),
                              helpText: "Escolha a data");

                          setState(() {
                            if (day != null) {
                              selectedDate = day;
                            }
                          });
                        },
                        child: Text("${formatIt(selectedDate)}")),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 8,
                  child: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Horário de início:"),
            Stack(
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(color: Colors.black),
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                        ),
                        onPressed: () async {
                          var hour = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              hourLabelText: "Horas",
                              minuteLabelText: "Minutos",
                              helpText: "Escolha o horário");

                          setState(() {
                            if (hour != null) {
                              selectedTime = hour;
                            }
                          });
                        },
                        child: Text(selectedTime.format(context))),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 8,
                  child: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Color(0xfff53b57),
            minimumSize: Size(double.infinity, 40),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: loading
              ? SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : GText("Adicionar Aula",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await Future.delayed(Duration(milliseconds: 500));

            controller.addLesson(dropdownMateria, {
              'id': selectedDate.millisecondsSinceEpoch,
              'materia': dropdownMateria,
              'date': formatIt(selectedDate),
              'time': selectedTime.format(context)
            });
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
