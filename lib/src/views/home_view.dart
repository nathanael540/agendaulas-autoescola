import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/gtext_widget.dart';
import '../shared/custom_bottom_sheet_widget.dart';
import '../shared/quote_widget.dart';
import '../shared/cardmateria_widget.dart';
import '../sheets/add_lesson_widget.dart';
import '../sheets/see_lessons_widget.dart';
import '../sheets/settings_widget.dart';
import '../controllers/home_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void showAddSheet() {
    HomeController controller =
        Provider.of<HomeController>(context, listen: false);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: controller,
          child: CustomBottomSheet(
            title: "Adicionar nova aula",
            description:
                "Acompanhe seu progresso nas aulas da autoescola de uma maneira simples e prática.",
            child: AddLesson(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfff53b57),
        child: Icon(Icons.add),
        onPressed: showAddSheet,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xfff53b57),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 45, 20, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            GText("AgendAulas",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            SizedBox.square(
                              dimension: 7,
                            ),
                            GText("- Agenda de AutoEscola",
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Icon(
                              Icons.settings,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            HomeController controller =
                                Provider.of<HomeController>(context,
                                    listen: false);

                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return ChangeNotifierProvider.value(
                                  value: controller,
                                  child: CustomBottomSheet(
                                    title: "Configurações",
                                    description:
                                        "Altere o número de aulas de cada matéria de acordo com o DETRAN do seu estado.",
                                    child: Settings(),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox.square(
                      dimension: 5,
                    ),
                    QuoteDay(),
                    SizedBox.square(
                      dimension: 7,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: Colors.white,
                        minimumSize: Size(150, 33),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      child: GText("Adicionar nova aula",
                          color: Color(0xfff53b57),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      onPressed: showAddSheet,
                    )
                  ],
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GText(
                        "Suas Aulas",
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      Consumer<HomeController>(
                          builder: (context, controller, child) {
                        return GText(
                          "${controller.totalRemaininLessons} aulas restantes",
                          color: Colors.black87,
                          fontSize: 13,
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GText(
                    "Acompanhe o progresso das aulas em cada matéria:",
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
                Consumer<HomeController>(builder: (context, controller, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9714,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.materias.length,
                    itemBuilder: (context, index) {
                      final materia = controller.materias[index];
                      return CardMateria(
                        id: materia['id'],
                        title: materia['title'],
                        backgroundAsset: materia['image'],
                        totalLessons: materia['totalLessons'],
                        doneLessons: materia['lessons'].length,
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return ChangeNotifierProvider.value(
                                value: controller,
                                child: CustomBottomSheet(
                                  title: materia['title'],
                                  description:
                                      "Abaixo você pode conferir e remover as aulas que foram adicionadas a essa matéria.",
                                  child: SeeLessons(
                                    lessons: materia['lessons'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
