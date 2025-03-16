import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:todolist/globals.dart';
import 'package:todolist/pages/updateTodo.dart';
import 'package:todolist/template_menu.dart';
import 'package:todolist/utils/classlist.dart';
import 'package:todolist/utils/decoration.dart';

import '../utils/loading/loading_overlay_pro.dart';

class ListePage extends StatefulWidget {
  const ListePage({super.key});

  @override
  State<ListePage> createState() => _ListePageState();
}

class _ListePageState extends State<ListePage>
    with SingleTickerProviderStateMixin {
  List<ToDo> todoLst = [
  
  ];
  TextEditingController searchctrl = TextEditingController();

  late final controller = SlidableController(this);
  final _supabase = Supabase.instance.client;
  bool loading = false;

  Future<void> _fetchTodos() async {
    try {
      setState(() => loading = true);
      final response = await _supabase
          .from('todos')
          .select()
          .eq('user_id', _supabase.auth.currentUser!.id)
          .order('created_at', ascending: false);
      setState(() {
        List<Map<String, dynamic>> tmp =
            (response as List).cast<Map<String, dynamic>>();

        print(tmp);
        todoLst = tmp.map((e) => ToDo.fromMap(e)).toList();
        
      });
    } catch (error) {
      showToast(context, "Error", 'Erreur lors de la récupération des tâches.', type: ToastificationType.error);
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// print(Supabase.instance.client.auth.currentUser!.toJson());
    _fetchTodos();
  }

  //

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: loading,
      progressIndicator: LoadingJumpingLine.square(
        backgroundColor: Colors.amber,
      ),
      child: TemplateMenu(drawer: 1, nav: true, home: false, child: content()),
    );
  }

  Widget content() {
    return Column(
      children: [
        // First Stack
        Container(
          // height: scrH(context) * 0.5,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: AssetImage('imgs/wt7.jpg'),
              fit: BoxFit.cover,
              opacity: 0.85,
            ),
          ),
          child: Column(
            children: [
              // // Navbar
              SizedBox(height: 120),
              //
              // // Textes
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'BIENVENUE !',
                  textAlign: TextAlign.center,
                  style: wtTitle(40, 1, Colors.black54, true, false),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Organisez Mieux vos Tâches!',
                  textAlign: TextAlign.center,
                  style: wtTitle(30, 1, Colors.black, true, false),
                ),
              ),
              const SizedBox(height: 20),
              //
              // Racourcis
              FB5Col(
                classNames: '',
                child: Container(
                  alignment: Alignment.center,
                  width: scrW(context),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(right: 120),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(252, 252, 252, 0.72),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                menus
                                    .where((element) => element['id'] >= 0)
                                    .map(
                                      (e) => Tooltip(
                                        message: e['nom'],
                                        waitDuration: Duration(
                                          microseconds: 200,
                                        ),
                                        preferBelow: false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: customIcon(
                                            dred3,
                                            Colors.white,
                                            e['icon'],
                                            () {
                                              ouvrirO(context, e['page']);
                                            },
                                            rd: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //
        //
        // Second Stack
        Column(
          children: [
            /*  // part1 searchline
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 0.72),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: FB5Row(
                classNames: 'align-items-center justify-content-center gy-2',
                children: [
                  FB5Col(
                    classNames: 'col-12 col-sm-6',
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            // filterUsers();
                          },
                          controller: searchctrl,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Field Required !';
                          //   } else if (npiRegex.hasMatch(value) == false) {
                          //     return 'Format Invalide !';
                          //   }
                          //   return null;
                          // },
                          decoration: mydecoration(
                            "Rechercher ... ",
                            15,
                            12,
                            true,
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              width: 80,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    color: dred1,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    height: 30,
                                    child: VerticalDivider(color: dred1),
                                  ),
                                ],
                              ),
                            ),
                            false,
                            const SizedBox(),
                            const BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  // FB5Col(
                  //   classNames: 'col-12 col-sm-6 ',
                  //   child: InkWell(
                  //     onTap: () {
                  //       //
                  //       customDiag(context, contenuLocalisation());
                  //     },
                  //     child: Wrap(
                  //       alignment: WrapAlignment.end,
                  //       crossAxisAlignment: WrapCrossAlignment.center,
                  //       // mainAxisAlignment: MainAxisAlignment.end,
                  //       // mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const Icon(
                  //           Icons.location_on_outlined,
                  //           size: 30,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 8.0),
                  //           child: Text(
                  //             allComQuart
                  //                 ? 'Tous les Emplacements'
                  //                 : '${actCom['lib_com']}, ${actQuart['id_quart'] == '-999' ? ' _ _ ' : actQuart['lib_quart']}',
                  //             style: wtTitle(15, 1, Colors.black, true, false),
                  //             maxLines: 2,
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            // */
            const SizedBox(height: 15),
            // part 2 domaines
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: [
                  SizedBox(height: 25),
                  FB5Col(
                    classNames: "col-12 col-md-5 ",
                    child: cmodelO(
                      "Nombre Total de Tâches",
                      Icons.album_sharp,
                      todoLst.length.toString(),
                    ),
                  ),
                  SizedBox(height: 20),
                  FB5Col(
                    classNames: "col-12 col-md-5 ",
                    child: cmodelO(
                      "Tâches Non Commencées",
                      Icons.list_alt_outlined,
                      todoLst
                          .where((e) => e.isBegined == false)
                          .length
                          .toString(),
                    ),
                  ),
                  SizedBox(height: 20),
                  FB5Col(
                    classNames: "col-12 col-md-5 ",
                    child: cmodelO(
                      "Tâches En Cours",
                      Icons.data_saver_on_outlined,
                      todoLst
                          .where(
                            (e) => e.isBegined == true && e.isFinished == false,
                          )
                          .length
                          .toString(),
                    ),
                  ),
                  SizedBox(height: 20),
                  FB5Col(
                    classNames: "col-12 col-md-5 ",
                    child: cmodelO(
                      "Tâches Terminées",
                      Icons.check,
                      todoLst
                          .where((e) => e.isFinished == true)
                          .length
                          .toString(),
                    ),
                  ),
                ],
              ),
            ),

            // part 3
            //
            // Divider
            Container(
              height: 2,
              color: dred2,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),

            //
            todoLst.isNotEmpty
                ? FB5Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FB5Col(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: customCard(
                                ExpansionTile(
                                  // controller: expctrl,
                                  onExpansionChanged: (value) {
                                    setState(() {
                                      // selectPlus = value;
                                    });
                                    // print(value);
                                  },
                                  collapsedBackgroundColor: dred4,
                                  // Color.fromRGBO(184, 184, 184, 0.563),
                                  backgroundColor: dred4,
                                  title: Text(
                                    'Non Commencées',
                                    style: wtTitle(
                                      16,
                                      1,
                                      const Color.fromARGB(255, 175, 76, 76),
                                      true,
                                      false,
                                    ),
                                  ),

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.spaceEvenly,
                                        spacing: 30,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                            todoLst
                                                .where(
                                                  (e) => e.isBegined == false,
                                                )
                                                .map((e) {
                                                  return cmodel(
                                                    0,
                                                    e,
                                                    todoLst.indexOf(e) + 1,
                                                  );

                                                  // customSlide(0, e, cmodel(e, todoLst.indexOf(e) + 1));
                                                })
                                                .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    FB5Col(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: customCard(
                                ExpansionTile(
                                  // controller: expctrl,
                                  onExpansionChanged: (value) {
                                    setState(() {
                                      // selectPlus = value;
                                    });
                                    // print(value);
                                  },
                                  collapsedBackgroundColor: dred4,
                                  // Color.fromRGBO(184, 184, 184, 0.563),
                                  backgroundColor: dred4,
                                  title: Text(
                                    'En Cours',
                                    style: wtTitle(
                                      16,
                                      1,
                                      Colors.amber,
                                      true,
                                      false,
                                    ),
                                  ),

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.spaceEvenly,
                                        spacing: 30,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                            todoLst
                                                .where(
                                                  (e) =>
                                                      e.isBegined == true &&
                                                      e.isFinished == false,
                                                )
                                                .map((e) {
                                                  return cmodel(
                                                    1,
                                                    e,
                                                    todoLst.indexOf(e) + 1,
                                                  );

                                                  // customSlide(0, e, cmodel(e, todoLst.indexOf(e) + 1));
                                                })
                                                .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    FB5Col(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: customCard(
                                ExpansionTile(
                                  // controller: expctrl,
                                  onExpansionChanged: (value) {
                                    setState(() {
                                      // selectPlus = value;
                                    });
                                    // print(value);
                                  },
                                  collapsedBackgroundColor: dred4,
                                  // Color.fromRGBO(184, 184, 184, 0.563),
                                  backgroundColor: dred4,
                                  title: Text(
                                    'Terminées',
                                    style: wtTitle(
                                      16,
                                      1,
                                      Colors.green,
                                      true,
                                      false,
                                    ),
                                  ),

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.spaceEvenly,
                                        spacing: 30,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                            todoLst
                                                .where(
                                                  (e) => e.isFinished == true,
                                                )
                                                .map((e) {
                                                  return cmodel(
                                                    2,
                                                    e,
                                                    todoLst.indexOf(e) + 1,
                                                  );

                                                  // customSlide(0, e, cmodel(e, todoLst.indexOf(e) + 1));
                                                })
                                                .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                : Column(
                  children: [
                    SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 20,
                      ),
                      child: Text(
                        'Aucune Tâche Planifée !',
                        style: wtTitle(22, 1, dred3, false, false),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: 150),
                  ],
                ),

            //
            //
          ],
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget cmodel(int mode, ToDo el, int index) {
    // print(el.id.toString());

    return InkWell(
      onTap: () {
        detailsTodo(el);
      },
      onLongPress: () {
        confirmdelete(el);
        setState(() {});
      },
      child: Card(
        surfaceTintColor:
            el.priority == "low"
                ? const Color.fromARGB(34, 7, 255, 98)
                : el.priority == "medium"
                ? const Color.fromARGB(35, 255, 230, 7)
                : const Color.fromARGB(124, 7, 218, 255),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title:
                    mode != 2
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                el.title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                el.title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                subtitle: Column(
                  children: [
                    Text(
                      el.description.toString().length < 50
                          ? el.description.toString()
                          : "${el.description.toString().substring(0, 51)} ... ",
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Priority : ${el.priority.toString()}")],
                    ),
                  ],
                ),
                leading: Text(index.toString(), style: TextStyle(fontSize: 18)),
              ),
              mode == 0
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            el.isBegined = true;
                          });

                          setState(() => loading = true);

                          String res = await updateTodo(el);

                          setState(() => loading = false);

                          if (res.isEmpty) {
                            showToast(
                              context,
                              "Modification Effectuée",
                              "A l'instant",
                            );
                            _fetchTodos();
                          } else {
                            showToast(
                              context,
                              "Erreur !",
                              res,
                              type: ToastificationType.error,
                            );
                          }
                        },
                        child: Text("Start", style: TextStyle(color: dred1)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateToDo(todo: el),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () {
                              confirmdelete(el);
                            },
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : mode == 1
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            el.isFinished = true;
                          });
                          setState(() => loading = true);

                          String res = await updateTodo(el);

                          setState(() => loading = false);

                          if (res.isEmpty) {
                            showToast(
                              context,
                              "Modification Effectuée",
                              "A l'instant",
                            );
                            _fetchTodos();
                          } else {
                            showToast(
                              context,
                              "Erreur !",
                              res,
                              type: ToastificationType.error,
                            );
                          }
                        },
                        child: Text("Finish", style: TextStyle(color: dred1)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              confirmdelete(el);
                            },
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              confirmdelete(el);
                            },
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void detailsTodo(ToDo el) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 20),
              Text('Détails'),
            ],
          ),
          content: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            el.id.toString(),
                            style: TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //
                        SizedBox(height: 10),

                        Text(
                          'Titre  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            el.title.toString(),
                            style: TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //
                        SizedBox(height: 10),

                        Text(
                          'Priority  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            el.priority.toString(),
                            style: TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //
                        SizedBox(height: 10),
                        Text(
                          'Contenu  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            el.description.toString(),
                            style: TextStyle(fontSize: 17),
                          ),
                        ),

                        //
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void confirmdelete(ToDo el) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Text('Confirmation'),
          content: Center(
            child: Column(
              children: [
                Icon(Icons.delete_outline, size: 70, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Etes vous sûr de vouloir supprimer ce ToDo ?',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                String res = await deleteTodo(el.id);
                if (res.isEmpty) {
                  showToast(context, "Suppression Effectuée", "A l'instant");
                  fermer(context);
                  _fetchTodos();
                } else {
                  showToast(
                    context,
                    "Erreur !",
                    res,
                    type: ToastificationType.error,
                  );
                  fermer(context);
                }
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  Widget customSlide(ToDo el, Widget child) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: UniqueKey(),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(
          onDismissed: () {
            // confirmdelete(el);
          },
        ),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              confirmdelete(el);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      // endActionPane: ActionPane(
      //   motion: const ScrollMotion(),
      //   children: [
      //     SlidableAction(
      //       // An action can be bigger than the others.
      //       flex: 2,
      //       onPressed: (_) => controller.openEndActionPane(),
      //       backgroundColor: const Color(0xFF7BC043),
      //       foregroundColor: Colors.white,
      //       icon: Icons.archive,
      //       label: 'Archive',
      //     ),
      //     SlidableAction(
      //       onPressed: (_) => controller.close(),
      //       backgroundColor: const Color(0xFF0392CF),
      //       foregroundColor: Colors.white,
      //       icon: Icons.save,
      //       label: 'Save',
      //     ),
      //   ],
      // ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: child,
    );
  }

  //

  Widget cmodelO(String titre, IconData iconn, String value) {
    return Card(
      // color: el.priority == "low"
      //     ? const Color.fromARGB(125, 7, 255, 98)
      //     : el.priority == "medium"
      //         ? const Color.fromARGB(124, 255, 230, 7)
      //         : const Color.fromARGB(124, 7, 218, 255),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(flex: 0, child: Icon(iconn)),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    titre,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
