import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:todolist/globals.dart';
import 'package:todolist/pages/liste.dart';
import 'package:todolist/pages/register.dart';
import 'package:todolist/template_menu.dart';
import 'package:todolist/utils/decoration.dart';
import 'package:todolist/utils/loading/loading_overlay_pro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mail_ctrl = TextEditingController();
  TextEditingController pass_ctrl = TextEditingController();

  bool showpass = true;
  IconData iconpass = Icons.visibility_off;

  final formkey = GlobalKey<FormState>();

  bool loading = false;

  loginUser() async {
    // déclencher le loading
    setState(() {
      loading = true;
    });

    String res = await signIn(mail_ctrl.text, pass_ctrl.text);

    setState(() => loading = false);

    if (res.isEmpty) {
      showToast(context, "Connexion Réussie !", "A l'instant");

      ouvrirR(context, ListePage());
    } else {
      showToast(context, "Erreur !", res, type: ToastificationType.error);
    }
  }

  void _handleGoogleLogin() async {
    setState(() => loading = true);

    String res = await signInWithGoogle();

    setState(() => loading = false);

    if (res.isEmpty) {
      showToast(context, "Connexion Réussie !", "A l'instant");
      ouvrirR(context, ListePage());
    } else {
      showToast(context, "Erreur !", res, type: ToastificationType.error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // mail_ctrl.text = "abdulmoustapha64@gmail.com2";
      // pass_ctrl.text = "hafiz1234@";
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
      child: FlutterBootstrap5(
        builder: (ctx) {
          return Scaffold(
            // appBar: AppBar(
            //   title: const Text(
            //     'Connexion',
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   ),
            //   backgroundColor: Colors.blue,
            // ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  child: ClipPath(
                    clipper: Clippermod(),
                    child: Container(
                      color: dred2,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.26,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: dred4,
                            shape: BoxShape.circle,
                            border: Border.all(color: dred1, width: 5),
                          ),
                          width: 300,
                          height: 300,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.6,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: dred4,
                            shape: BoxShape.circle,
                            border: Border.all(color: dred1, width: 3),
                          ),
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                ),
                FB5Row(
                  classNames: "justify-content-center",
                  children: [
                    // FB5Col(
                    //   classNames: "d-none d-md-block col-md-6",
                    //   ch
                    // ),
                    FB5Col(
                      classNames: "col-12 col-md-6",
                      child: Stack(
                        children: [
                          //
                          Container(
                            color: const Color.fromARGB(199, 255, 255, 255),
                            height: scrH(context),
                            padding: EdgeInsets.all(18),
                            child: SingleChildScrollView(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 40),
                                  Text(
                                    "Se connecter",
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
                                            color: dred1,
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
                                            color: dred1,
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),

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
                                            controller: mail_ctrl,
                                            keyboardType: TextInputType.text,
                                            decoration: mydecoration(
                                              'Email *',
                                              15,
                                              12,
                                              true,
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                width: 80,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.mail,
                                                      color: dred1,
                                                      size: 30,
                                                    ),
                                                    SizedBox(width: 5),
                                                    SizedBox(
                                                      height: 30,
                                                      child: VerticalDivider(
                                                        color: dred1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              false,
                                              SizedBox(),
                                              BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return "Ce champ est Obligatoire";
                                              }
                                              return null;
                                            },
                                          ),

                                          SizedBox(height: 25),

                                          //
                                          TextFormField(
                                            controller: pass_ctrl,
                                            keyboardType: TextInputType.text,
                                            obscureText: showpass,
                                            decoration: mydecoration(
                                              'Password *',
                                              15,
                                              12,
                                              true,
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                width: 80,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.lock,
                                                      color: dred1,
                                                      size: 30,
                                                    ),
                                                    SizedBox(width: 5),
                                                    SizedBox(
                                                      height: 30,
                                                      child: VerticalDivider(
                                                        color: dred1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              true,
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showpass = !showpass;

                                                    iconpass =
                                                        iconpass ==
                                                                Icons
                                                                    .visibility_off
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off;
                                                  });
                                                },
                                                icon: Icon(iconpass),
                                              ),
                                              BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return "Ce champ est Obligatoire";
                                              }
                                              return null;
                                            },
                                          ),

                                          //
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  customButton(
                                    dred1,
                                    Text(
                                      'Connexion',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    22,
                                    () async {
                                      // showToast();
                                      if (formkey.currentState!.validate()) {
                                        loginUser();
                                      }
                                    },
                                    -15,
                                    cp: EdgeInsets.symmetric(vertical: 15, horizontal: 40)
                                  ),
                                  SizedBox(height: 25),

                                  // Divider OU
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: dred1,
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            "Continuer Avec",
                                            style: TextStyle(color: dred1),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: dred1,
                                            thickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  // Bouton Continuer avec Google
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _handleGoogleLogin();
                                    },
                                    icon: Brand(Brands.google, size: 25),
                                    //  Icon(Bootstrap.google, size : 25, color: Color.fromARGB(255, 255, 81, 68),),
                                    label: const Text("Google"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      side: BorderSide(color: dred1),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Vous n\'avez pas de compte ?'),
                                      TextButton(
                                        // style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.green,)),
                                        onPressed: () async {
                                          ouvrirR(context, RegisterPage());
                                        },
                                        child: Text(
                                          'inscrivez-vous',
                                          style: TextStyle(color: dred1),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 200),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned(
                  child: Container(
                    // alignment: Alignment.bottomCenter,
                    // color: const Color.fromARGB(223, 239, 145, 145),
                    // width: MediaQuery.of(context).size.width,
                    // height: double.infinity,
                    child: footer(),
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
