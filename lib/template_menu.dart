import 'package:icons_plus/icons_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:todolist/pages/addTodo.dart';
import 'package:todolist/pages/liste.dart';
import 'package:todolist/pages/login.dart';
import 'package:todolist/utils/decoration.dart';
import 'package:todolist/utils/urls.dart';

import 'globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';

// int cnt = 1;

Widget customNavBar(
  BuildContext context,
  GlobalKey<ScaffoldState> scafkey, {
  bool home = false,
}) {
  String userName =
      Supabase.instance.client.auth.currentUser!.userMetadata!['name'] ??
      "New User";
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    decoration: BoxDecoration(
      color: Color.fromRGBO(252, 252, 252, 0.72),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 0,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.menu_outlined, size: 40, color: Colors.black),
            ),
            onTap: () {
              // Menu
              scafkey.currentState!.isDrawerOpen
                  ? scafkey.currentState!.closeDrawer()
                  : scafkey.currentState!.openDrawer();
            },
          ),
        ),
        //
        Expanded(
          flex: 1,
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dred3,
                  image: DecorationImage(
                    image: AssetImage('imgs/logo.png'),
                    fit: BoxFit.cover,
                    // opacity: 0.9
                  ),
                ),
                // padding: EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'ToDo List Master',
                  style: wtTitle(18, 1, Colors.black, true, false),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        //
        Expanded(
          flex: 0,
          child: PopupMenuButton(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Icon(
                home == true
                    ? Icons.arrow_back_outlined
                    : Icons.person_outlined,
                size: 40,
                color: Color.fromRGBO(252, 252, 252, 0.72),
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dred1,
                        ),
                        // padding: EdgeInsets.all(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName.split(' ').length >= 2
                                  ? userName.split(' ')[0][0]
                                  : userName.substring(0, 1),
                              style: wtTitle(30, 1, Colors.white, true, false),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              userName.split(' ').length >= 2
                                  ? userName.split(' ')[1][0]
                                  : userName.substring(1, 2),
                              style: wtTitle(60, 1, Colors.white, true, false),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuItem(
                  child: Tooltip(
                    message: "Connected As",
                    waitDuration: Duration(microseconds: 200),
                    preferBelow: false,
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      
                      ],
                    ),
                  ),
                ),
                //
                PopupMenuItem(
                  child: Tooltip(
                    message: "Mail Adress",
                    waitDuration: Duration(microseconds: 200),
                    preferBelow: false,
                    child: Row(
                      // mainAxisSize:
                      //     MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            Supabase.instance.client.auth.currentUser!.email ??
                                "User Mail",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Expanded(
                          flex: 0,
                          child: InkWell(
                            child: Icon(
                              Icons.mail_lock_outlined,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                PopupMenuItem(
                  child: Tooltip(
                    message: "LogOut",
                    waitDuration: Duration(microseconds: 200),
                    preferBelow: false,
                    child: customButton(
                      Color.fromRGBO(252, 252, 252, 0.72),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "LogOut",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Expanded(
                            flex: 0,
                            child: InkWell(
                              child: Icon(
                                Icons.logout_outlined,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      25,
                      () {
                        //

                        fermer(context);
                         customDiag(context, confirmDeconnexion());
                      },
                      7,
                      opt: 2,
                      bc: Colors.red,
                    ),
                  ),
                ),
              ];
            },
          ),

          /* InkWell(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Icon(
                home == true
                    ? Icons.arrow_back_outlined
                    : Icons.person_outlined,
                size: 40,
                color: Color.fromRGBO(252, 252, 252, 0.72),
              ),
            ),
            onTap: () {
              // Profil
              // home == true ? fermer(context) : ouvrirO(context, UserProfil());
            },
          ), */
        ),
      ],
    ),
  );
}

Widget footer() {
  return Container(
    color: Colors.black,
    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    child: FB5Row(
      classNames: 'align-items-center justify-content-center',
      children: [
        FB5Col(
          classNames: 'col-10 col-lg-6',
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 15,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.copyright_outlined, color: dred4, size: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Text(
                  'CopyRight ToDo Master',
                  style: wtTitle(12, 1, dred4, true, false),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  'Powered By Hafiz M.',
                  style: wtTitle(12, 1, dred4, true, false),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        FB5Col(
          classNames: 'col-10 mt-3 mt-lg-0 col-lg-6',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(135, 255, 255, 255),
              // color: Color.fromRGBO(252, 252, 252, 0.72),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 15,
              // spacing: 15,
              children: [
                cURLLink2("https://www.linkedin.com/in/abdul-moustapha-04b92b24b?", BoxIcons.bxl_linkedin),
                cURLLink2("https://www.youtube.com/@seniormood_dev", BoxIcons.bxl_youtube),
                cURLLink2("https://www.facebook.com/Abdulo64", BoxIcons.bxl_facebook),
                cURLLink2("https://www.instagram.com/abdulmoustapha64?igsh=YzljYTk1ODg3Zg==", BoxIcons.bxl_instagram),
               
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cDrawerTemp(
  BuildContext context,
  bool active,
  bool f,
  Map e,
  GlobalKey<ScaffoldState> scafkey,
) {
  return e['id'] == -1
      ? Container(
        height: 3,
        color: dred3,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      )
      : Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: InkWell(
          onTap: () {
            //
            // Scaffold.of(context).closeDrawer();
            scafkey.currentState!.closeDrawer();
            if (!f) {
              fermer(context);
            }

            // print(scafkey.currentState);
            ouvrirO(context, e['page']);
          },
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                child: Container(
                  color: active ? dred2 : dred4,
                  height: 80,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        flex: 0,
                        child: customIcon(
                          active ? Colors.white : dred22,
                          active ? dred1 : Colors.black,
                          e['icon'],
                          () {
                            // ouvrirO(context, e['page']);
                          },
                          rd: 30,
                          sz: 30,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: Text(
                          e['nom'],
                          style: wtTitle(
                            18,
                            1,
                            active ? Colors.white : Colors.black,
                            true,
                            false,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              Positioned(
                left: 0,
                child: Container(
                  height: 80,
                  width: 10,
                  color: active ? dred1 : Color.fromRGBO(252, 252, 252, 0.72),
                ),
              ),
            ],
          ),
        ),
      );
}

List<Map> menus = [
  {'id': -1},

  {
    'id': 1,
    'nom': 'Mes ToDos',
    'icon': Icons.line_style_outlined,
    'page': ListePage(),
  },

  {'id': -1},

  {
    'id': 2,
    'nom': 'Ajouter',
    'icon': Icons.add_circle_outline_outlined,
    'page': AddToDoPage(),
  },

  {'id': -1},
];

Widget customDrawer(
  BuildContext context,
  int active,
  GlobalKey<ScaffoldState> scafkey,
) {
  return FB5Row(
    children: [
      FB5Col(classNames: 'd-none d-lg-block col-lg-1', child: SizedBox()),
      FB5Col(
        child: Container(
          width: 270,
          height: scrH(context) - 100,
          color: dred4,
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Expanded(flex: 0, child: SizedBox(height: 25)),
              //
              //
              //
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        menus.map((e) {
                          return cDrawerTemp(
                            context,
                            e['id'] == active,
                            active == -999,
                            e,
                            scafkey,
                          );
                        }).toList(),
                  ),
                ),
              ),
              //
              //
              //
              Expanded(
                flex: 0,
                child: SizedBox(
                  child: Column(
                    children: [
                      //
                      // Déconexion
                      SizedBox(height: 25),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 117, 117, 0.388),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: Colors.red),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Icon(
                                  Icons.logout_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Déconnexion',
                                  style: wtTitle(
                                    18,
                                    1,
                                    Colors.black,
                                    true,
                                    false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          customDiag(context, confirmDeconnexion());
                        },
                      ),
                      //
                      // Divider
                      SizedBox(height: 25),
                      Container(
                        height: 3,
                        color: dred3,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                      ),
                      //
                      // Texts
                      SizedBox(height: 15),
                      Text(
                        'ToDo List Master',
                        style: wtTitle(15, 1, Colors.black, false, false),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'CopyRights - 2025 -- @fortest',
                        style: wtTitle(13, 1, Colors.black, false, false),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      FB5Col(classNames: 'd-none d-lg-block col-lg-1', child: SizedBox()),
    ],
  );
}

class TemplateMenu extends StatefulWidget {
  const TemplateMenu({
    super.key,
    required this.child,
    required this.drawer,
    required this.nav,
    required this.home,
  });
  final Widget child;
  final int drawer;
  final bool nav, home;

  @override
  State<TemplateMenu> createState() => _TemplateMenu();
}

class _TemplateMenu extends State<TemplateMenu> {
  GlobalKey<ScaffoldState> scafkey = GlobalKey<ScaffoldState>();
  // ValueKey<ScaffoldState> scafkey = ValueKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext contextx, setState) {
        return FlutterBootstrap5(
          builder:
              (ctx) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  key: scafkey,
                  drawer:
                      widget.drawer == -99
                          ? const SizedBox()
                          : customDrawer(context, widget.drawer, scafkey),
                  // drawer: widget.drawer,
                  backgroundColor: dred4,
                  body: FB5Row(
                    children: [
                      FB5Col(
                        classNames: 'd-none d-lg-block col-lg-1',
                        child: Container(
                          color: const Color.fromRGBO(0, 0, 0, 0.06),
                          height: scrH(context),
                        ),
                      ),
                      FB5Col(
                        classNames: 'col-lg-10',
                        child: SizedBox(
                          height: scrH(context),
                          child:
                              // widget.nav
                              //     ? 
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        child: SizedBox(
                                          height: scrH(context),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Contenu
                                                widget.child,
                                                // Footer
                                                footer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        child: SizedBox(
                                          width: scrW(context) * 10 / 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: customNavBar(
                                              context,
                                              scafkey,
                                              home: widget.home,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  // : SizedBox(
                                  //   height: scrH(context),
                                  //   child: SingleChildScrollView(
                                  //     child: Column(
                                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         // Contenu
                                  //         widget.child,
                                  //         // Footer
                                  //         footer(),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                        ),
                      ),
                      FB5Col(
                        classNames: 'd-none d-lg-block col-lg-1',
                        child: Container(
                          color: const Color.fromRGBO(0, 0, 0, 0.06),
                          height: scrH(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}

Widget confirmDeconnexion() {
  return StatefulBuilder(
    builder: (context, setStatex) {
      return Column(
        children: [
          //
          // Close
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  fermer(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: dred1),
                  ),
                  child: Icon(Icons.close, color: dred1),
                ),
              ),
            ],
          ),
          //
          // Title
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Déconnexion',
              style: wtTitle(20, 1, Colors.black, true, false),
            ),
          ),
          //
          //
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(136, 195, 74, 74),
                width: 15,
              ),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.redAccent,
              size: 250,
            ),
          ),
          //
          // Textes
          //
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Voulez-Vous Vraiment vous déconnecter !?',
              style: wtTitle(16, 1, Colors.black, false, false),
              textAlign: TextAlign.center,
            ),
          ),
          //
          //
          // Boutons
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customButton(
                Colors.redAccent,
                Text(
                  'Se Déconnecter',
                  style: wtTitle(18, 1, dred4, true, false),
                ),
                15,
                () async {
                  // Relancer lAPI
                  try {
                  await signOut();
                    
                  } catch (e) {
                    showToast(context, "Error", 'Erreur lors de la déconnexion.', type: ToastificationType.error);
                  }
                  fermer(context);
                  ouvrirR(context, LoginPage());
                },
                -1,
                cp: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
            ],
          ),
        ],
      );
    },
  );
}

class Clippermod extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // 2
    path.lineTo(0, size.height);
    // 3
    // path.lineTo(size.width * 0.03, size.height);
    path.quadraticBezierTo(
      size.width * 0.03,
      size.height,
      size.width * 0.03,
      size.height * 0.8,
    );
    // 4
    path.quadraticBezierTo(
      size.width * 0.03,
      size.height * 0.50,
      size.width * 0.1,
      size.height * 0.5,
    );
    // 5
    path.lineTo(size.width * 0.8, size.height * 0.5);
    // 6
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.5, size.width, 0);

    // path.lineTo(size.width, size.height*0.5);

    // path.quadraticBezierTo(-180, size.height / 1.2, 200 / 2, size.height / 1.2);

    //path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Junior extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // 2
    path.lineTo(0, size.height);
    // // 4
    path.quadraticBezierTo(
      size.width * 0,
      size.height * 0.5,
      size.width * 0.2,
      size.height * 0.5,
    );
    // // 5
    path.lineTo(size.width * 0.8, size.height * 0.5);
    // // 6
    path.quadraticBezierTo(size.width, size.height * 0.5, size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
