import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todolist/globals.dart';
import 'package:todolist/pages/liste.dart';
import 'package:todolist/template_menu.dart';
import 'package:todolist/utils/classlist.dart';
import 'package:todolist/utils/decoration.dart';
import 'package:todolist/utils/loading/loading_overlay_pro.dart';

class UpdateToDo extends StatefulWidget {
  const UpdateToDo({super.key, required this.todo});
  final ToDo todo;

  @override
  State<UpdateToDo> createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  TextEditingController titre_ctrl = TextEditingController();
  TextEditingController cont_ctrl = TextEditingController();
  TextEditingController date_ctrl = TextEditingController();

  var vpriority;
  final formkey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(widget.todo.title);
      print(widget.todo.description);
      print(widget.todo.isBegined);
      print(widget.todo.isFinished);

      titre_ctrl.text = widget.todo.title;
      cont_ctrl.text = widget.todo.description;
    });
  }

  //

  @override
    Widget build(BuildContext context) {
    return LoadingOverlayPro(
       isLoading: loading,
      progressIndicator: LoadingJumpingLine.square(
        backgroundColor: Colors.amber,
      ),
      child: TemplateMenu(drawer: 2, nav: true, home: false, child: content()));
  }

  Widget content() {
    return Column(
      children: [

         SizedBox(height: 130),
                                  Text(
                                    "Modification de Tâche",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 130,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 160,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.black,
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
        
        //
      Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titre_ctrl,
                        keyboardType: TextInputType.text,
                        decoration: mydecoration(
                                              'Titre *',
                                              15,
                                              12,
                                              false, SizedBox(),
                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //     left: 20,
                                              //   ),
                                              //   width: 80,
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.mail,
                                              //         color: dred1,
                                              //         size: 30,
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       SizedBox(
                                              //         height: 30,
                                              //         child: VerticalDivider(
                                              //           color: dred1,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              false,
                                              SizedBox(),
                                              BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Ce champ est Obligatoire";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 25),

                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          value: vpriority,
                          decoration: mydecoration(
                                              'Priority *',
                                              15,
                                              12,
                                              false, SizedBox(),
                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //     left: 20,
                                              //   ),
                                              //   width: 80,
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.mail,
                                              //         color: dred1,
                                              //         size: 30,
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       SizedBox(
                                              //         height: 30,
                                              //         child: VerticalDivider(
                                              //           color: dred1,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              false,
                                              SizedBox(),
                                              BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Ce champ est Obligatoire";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              vpriority = value;
                            });
                          },
                          items:
                              [
                                    {'text': 'Low', 'value': 'low'},
                                    {'text': 'Medium', 'value': 'medium'},
                                    {'text': 'High', 'value': 'high'},
                                  ]
                                  .map(
                                    (Map e) => DropdownMenuItem(
                                      value: e['value'],
                                      child: Text(e['text']),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),

                      SizedBox(height: 25),

                      //
                      TextFormField(
                        controller: cont_ctrl,
                        keyboardType: TextInputType.text,
                        maxLines: 6,
                        decoration: mydecoration(
                                              'Description *',
                                              15,
                                              12,
                                              false, SizedBox(),
                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //     left: 20,
                                              //   ),
                                              //   width: 80,
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.mail,
                                              //         color: dred1,
                                              //         size: 30,
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       SizedBox(
                                              //         height: 30,
                                              //         child: VerticalDivider(
                                              //           color: dred1,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              false,
                                              SizedBox(),
                                              BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Ce champ est Obligatoire";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),

                      //
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              customButton(
                                    dred1,
                                    Text(
                                      'Mettre à Jour',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    22,
                                    () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                          widget.todo.title = titre_ctrl.text;
                          widget.todo.description = cont_ctrl.text;
                          widget.todo.priority = vpriority;
                          widget.todo.isBegined = widget.todo.isBegined;
                          widget.todo.isFinished = widget.todo.isFinished;
                        });

                     setState(() => loading = true);

              String res = await updateTodo(widget.todo);

              setState(() => loading = false);

              if (res.isEmpty) {
                showToast(context, "Tâche Modifiée", "A l'instant");
                fermer(context);
                ouvrirR(context, ListePage());
              } else {
                showToast(
                  context,
                  "Erreur !",
                  res,
                  type: ToastificationType.error,
                );
              }
                  }
                },
                                    -15,
                                    cp: EdgeInsets.symmetric(vertical: 15, horizontal: 40)
                                  ),
             

        const SizedBox(height: 30),
      ],
    );
  }

}
