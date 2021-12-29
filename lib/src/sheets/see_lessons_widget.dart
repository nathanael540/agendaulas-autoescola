import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';

class SeeLessons extends StatefulWidget {
  final List lessons;

  const SeeLessons({Key? key, required this.lessons}) : super(key: key);

  @override
  _SeeLessonsState createState() => _SeeLessonsState();
}

class _SeeLessonsState extends State<SeeLessons> {
  formatIt(date) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = context.watch<HomeController>();

    return (widget.lessons.isEmpty)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Icon(
                    Icons.close,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Nenhuma aula foi adicionada ainda.")
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: widget.lessons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.check_box,
                    size: 25,
                    color: Colors.green,
                  ),
                  minLeadingWidth: 10,
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  dense: true,
                  title: Text(widget.lessons[index]['date'] +
                      " - " +
                      widget.lessons[index]['time']),
                  subtitle: Text('Aula de ' +
                      controller
                          .getMateriaFromID(
                              widget.lessons[index]['materia'])['title']
                          .replaceAll('\n', " ")),
                  trailing: IconButton(
                    iconSize: 15,
                    padding: EdgeInsets.all(2),
                    onPressed: () {
                      controller.removeLesson(widget.lessons[index]['id'],
                          widget.lessons[index]['materia']);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
