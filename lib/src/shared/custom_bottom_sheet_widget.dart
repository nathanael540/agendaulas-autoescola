import 'package:flutter/material.dart';
import 'gtext_widget.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const CustomBottomSheet(
      {Key? key,
      required this.title,
      required this.description,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, -5),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      )
                    ],
                  ),
                ),
                GText(
                  title.replaceAll("\n", " "),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 3),
                  child: Text(description),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
