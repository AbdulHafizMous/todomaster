import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:todolist/globals.dart';
import 'package:todolist/pages/liste.dart';
import 'package:todolist/pages/login.dart';
import 'package:todolist/template_menu.dart';
import 'package:todolist/utils/decoration.dart';
import 'package:todolist/utils/loading/loading_overlay_pro.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController mail_ctrl = TextEditingController();
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController pass_ctrl = TextEditingController();

  bool showpass = true;
  IconData iconpass = Icons.visibility_off;
  bool loading = false;

  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mail_ctrl.text = "abdulmoustapha64@gmail.com";
    // name_ctrl.text = "Hafiz MOUSTAPHA";
    // pass_ctrl.text = "hafiz1234@";
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

  createUser() async {
    setState(() {
      loading = true;
    });

    String res = await signUp(mail_ctrl.text, pass_ctrl.text, name_ctrl.text);

    if (res.isEmpty) {
      showToast(context, "Inscription Réussie !", "A l'instant");
      String res2 = await signIn(mail_ctrl.text, pass_ctrl.text);
       if (res2.isEmpty) {
          showToast(context, "Connexion Réussie !", "A l'instant");
          setState(() {
            loading = false;
          });
          ouvrirR(context, ListePage());
        } else {
          setState(() {
            loading = false;
          });
          ouvrirR(context, LoginPage());
        }
    } else {
      setState(() {
        loading = false;
      });
      showToast(context, "Erreur !", res, type: ToastificationType.error);
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: loading,
      progressIndicator: LoadingJumpingLine.square(
        backgroundColor: Colors.amber,
      ),
      // bottomLoading: CircularProgressIndicator(backgroundColor: Colors.amber,),
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
                                    "Inscription",
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
                        controller: name_ctrl,
                        keyboardType: TextInputType.text,
                        decoration: mydecoration(
                                              'Full Name *',
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
                                                      Icons.person,
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
                          if (value == null || value == "") {
                            return "Ce champ est Obligatoire";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
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
                                              else if(!emailRegex.hasMatch(value)){
                                                return "Format Invalide !";
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
                                              else if(!remdp.hasMatch(value)){
                                                return "Format Invalide !";
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
                                      'S\'inscrire',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    22,
                                    () async {
                                      // showToast();
                                      if (formkey.currentState!.validate()) {
                                        createUser();
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
                                      Text('Vous avez déjà un compte ?'),
                                      TextButton(
                                        // style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.green,)),
                                        onPressed: () async {
                                          ouvrirR(context, LoginPage());
                                        },
                                        child: Text(
                                          'connectez-vous',
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
      
      
     /*  Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'Inscription',
        //     style: TextStyle(color: Colors.white, fontSize: 20),
        //   ),
        //   backgroundColor: Colors.blue,
        // ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'Inscription',
                style: TextStyle(color: Colors.amber, fontSize: 25),
              ),
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
                        controller: name_ctrl,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          label: Text('Full Name *'),
                        ),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Ce champ est Obligatoire";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),

                      TextFormField(
                        controller: mail_ctrl,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.mail),
                          label: Text('Email *'),
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
                      TextFormField(
                        controller: pass_ctrl,
                        keyboardType: TextInputType.text,
                        obscureText: showpass,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showpass = !showpass;

                                iconpass =
                                    iconpass == Icons.visibility_off
                                        ? Icons.visibility
                                        : Icons.visibility_off;
                              });
                            },
                            icon: Icon(iconpass),
                          ),
                          label: Text('Password *'),
                        ),
                        validator: (value) {
                          if (value == null || value == "") {
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
              SizedBox(height: 30),
              ElevatedButton(
                // style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.green,)),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    createUser();
                  }
                },
                child: Text('Inscription'),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Vous avez déjà un compte ?'),
                  TextButton(
                    // style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.green,)),
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('connectez-vous'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
     */
    
    );
  }
}
