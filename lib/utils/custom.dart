
import 'dart:math';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:todolist/utils/decoration.dart';

double scrW(context) {
  return MediaQuery.of(context).size.width;
}

double scrH(context) {
  return MediaQuery.of(context).size.height;
}

List colslst = [
  // Color.fromARGB(131, 0, 0, 0),
  // Colors.red,
  Color.fromARGB(255, 233, 104, 61),
  Color.fromARGB(255, 255, 145, 0),
  Color.fromARGB(255, 110, 233, 61),
  Color.fromARGB(255, 61, 233, 78),
  Color.fromARGB(255, 13, 227, 250),
  Color.fromARGB(255, 28, 156, 247),
  Color.fromARGB(255, 78, 61, 233),
  Color.fromARGB(255, 173, 61, 233),
  Color.fromARGB(255, 233, 61, 196),
  Color.fromARGB(255, 233, 61, 61),
];

Color randomColor() {
  return colslst[Random().nextInt(colslst.length)];
}

void ouvrirO(context, page) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => page));
}

void ouvrirR(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => page));
}

void fermer(context) {
  Navigator.of(context).pop();
}

void showsnack(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: dred1),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 228, 228),
      duration: Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showToast(BuildContext context, String title, String content,
    {ToastificationType type = ToastificationType.success}) {
  toastification.show(
    context: context, // optional if you use ToastificationWrapper
    type: type,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 8),
    title: Text(title),
    // you can also use RichText widget for title and description parameters
    description:  Text(content),// RichText(text: TextSpan(text: content)),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 500),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(Icons.notifications_active_outlined),
    showIcon: true, // show or hide the icon
    primaryColor: Color(0xffEE5366),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Color(0xffEE5366) ),
    boxShadow: const [
      // BoxShadow(
      //   color: Color(0x07000000),
      //   blurRadius: 16,
      //   offset: Offset(0, 16),
      //   spreadRadius: 0,
      // )
    ],
    showProgressBar: true,
    closeButton: ToastCloseButton(showType: CloseButtonShowType.onHover),
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          print('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          print('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    ),
  );
}

Future timepicker(BuildContext context) async {
  final TimeOfDay? tempchoix =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  // ignore: use_build_context_synchronously
  return tempchoix == null ? '' : tempchoix.format(context);

  //  timepicker(context).then((value) => textheuredp.text=value); UTILISATION
}

Future datepicker(BuildContext context) async {
  final DateTime? tempchoix = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 15),
      firstDate: DateTime(DateTime.now().year - 80),
      lastDate: DateTime(DateTime.now().year - 10));
  // ignore: use_build_context_synchronously
  return tempchoix ?? '';

  // datepicker(context).then((value) => textheuredp.text=value);  UTILISATION
}

String engtimetofrench(String engtime) {
  if (engtime.isEmpty) {
    return '';
  }
  int hr = int.parse(engtime.split(' ')[0].split(':')[0]);
  int min = int.parse(engtime.split(' ')[0].split(':')[1]);
  String ampm = engtime.split(' ')[1];
  if (ampm == 'PM' && hr != 12) {
    hr += 12;
  } else if (ampm == 'PM' && hr == 12) {
    hr = 0;
  }
  return '${hr.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:00';

  /* engtimetofrench(value) UTILISATION */
}

DateTime doubletodatetime(DateTime depart, double nbhr) {
  int day = (nbhr / 24).floor();
  nbhr -= day * 24;
  int hr = nbhr.toInt() % 24;
  nbhr -= hr;
  int min = (nbhr * 60).floor();
  nbhr = ((nbhr * 60) - min);
  int sec = (nbhr * 60).floor();

  // print('jr : $day , hr : $hr , min : $min , sec : $sec');

  DateTime date =
      depart.add(Duration(days: day, hours: hr, minutes: min, seconds: sec));
  return date;
}

DateTime strtoDateTime(String str) {
  if (str.split(' ').length == 2) {
    List date = str.split(' ')[0].split('-');
    List heure = str.split(' ')[1].split(':');
    return DateTime(
      int.parse(date[0]),
      int.parse(date[1]),
      int.parse(date[2]),
      //
      int.parse(heure[0]),
      int.parse(heure[1]),
      int.parse(heure[2]),
    );
  }
  List date = str.split(' ')[0].split('-');
  return DateTime(
    int.parse(date[0]),
    int.parse(date[1]),
    int.parse(date[2]),
    //
  );
}

String intcodegenerator(int length, List<String> notin) {
  List<int> code = [];
  String codestr = '';
  do {
    code = List.generate(length, (_) => Random().nextInt(10));
    codestr = code.join();
  } while (notin.contains(codestr));
  return codestr;
}

String passwordGenerator(int length) {
  const caracteresPermis =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';
  Random random = Random();
  String resultat = '';

  while (resultat.length <= length) {
    int index = random.nextInt(caracteresPermis.length);
    String caractere = caracteresPermis[index];
    if (!resultat.contains(caractere) && caractere.isNotEmpty) {
      resultat += caractere;
    }
  }
  return resultat;
}

String datetoday(DateTime date, [String fren = 'fr']) {
  const List daysfr = [
    'lundi',
    'mardi',
    'mercredi',
    'jeudi',
    'vendredi',
    'samedi',
    'dimanche'
  ];
  const List daysen = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  if (fren == 'fr') {
    return daysfr[date.weekday - 1];
  }
  return daysen[date.weekday - 1];
}

String datetomonth(DateTime date, [String fren = 'fr']) {
  const List daysfr = [
    'janvier',
    'février',
    'mars',
    'avril',
    'mai',
    'juin',
    'juillet',
    'aout',
    'septembre',
    'octobre',
    'novembre',
    'décembre',
  ];
  const List daysen = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  if (fren == 'fr') {
    return daysfr[date.month - 1];
  }
  return daysen[date.month - 1];
}

Future msgerreur(BuildContext context, String msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Erreur !'),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future msgsucces(BuildContext context, String msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Succès !'),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future customDiag(BuildContext context, Widget child) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          scrollable: true,
          // title: const Text('Succès !'),
          content: child,
          // actions: [
          //   TextButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //         // if (page != Null) {
          //         //   ouvrirR(context, page);
          //         // }
          //       },
          //       child: const Text('OK'))
          // ],
        );
      });
}

String tempsEcoule(DateTime datec, [String fren = 'en']) {
  String resultat = "";

  Duration duree = DateTime.now().difference(datec);

  if (datec.year < DateTime.now().year) {
    resultat = "${datec.day} ${datetomonth(datec, fren)}, ${datec.year}";
  } else if ((datec.month < DateTime.now().month) ||
      ((datec.month == DateTime.now().month)) &&
          (DateTime.now().day - datec.day >= 7)) {
    resultat = "${datec.day} ${datetomonth(datec, fren)}";
  } else if (DateTime.now().day - datec.day >= 2) {
    resultat = fren == 'fr'
        ? "Il y a ${DateTime.now().day - datec.day} jrs"
        : "${DateTime.now().day - datec.day} days ago";
  } else if (DateTime.now().day - datec.day == 1) {
    resultat = fren == 'fr' ? "Hier" : "Yesterday";
  } else if (duree.inHours >= 1) {
    resultat = fren == 'fr'
        ? "Il y a ${duree.inHours} hr."
        : "${duree.inHours} hr. ago";
  } else if (duree.inMinutes >= 1) {
    resultat = fren == 'fr'
        ? "Il y a ${duree.inMinutes} min"
        : "${duree.inMinutes} min ago";
  } else if (duree.inSeconds >= 1) {
    resultat = fren == 'fr'
        ? "Il y a ${duree.inSeconds} sec"
        : "${duree.inSeconds} sec ago";
  }
  return resultat;
}

String chatTime(context, DateTime datec, [String fren = 'fr']) {
  // String rs = '';
  TimeOfDay tm = TimeOfDay.fromDateTime(datec);

//   if (fren == 'fr') {
//     rs = "${tm.hour}h ${tm.minute}min";
//   } else {
//     if(tm.hour > 12){
//  rs = "${tm.hour}:${tm.minute} PM";
//     } else {
//  rs = "${tm.hour}:${tm.minute} AM";

//     }
//   }

  return DateTime.now().difference(datec).inDays < 1
      ? tm.format(context)
      : DateTime.now().difference(datec).inDays < 2
          ? "Yesterday"
          : "${datec.day}/${datec.month}/${datec.year}";
}

customBottomSheetBuildContext(context, double height, Widget child,
    {bool isDismissible = false}) {
  showModalBottomSheet(
    isDismissible: isDismissible,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return FractionallySizedBox(heightFactor: height, child: child);
    },
  );
}
String obscur(String string, int startind, int endind, String pattern) {
  return '${string.substring(0, startind).padRight(endind, pattern)}${string.substring(endind, string.length)}';
}

String hider(String string, int maxchar, String pattern, int patternlen) {
  return '${string.substring(0, maxchar - 1 - patternlen)}${pattern * patternlen}';
//  return'${string.substring(0,maxchar-1-patternlen).padRight(patternlen, '*')}';
}
//
// hider(dom.nom, 12, '.', 3)

// 8min + 1maj + 1chiff + 1special
RegExp remdp = RegExp(
    r'^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{6,}$');

RegExp passRegex = RegExp(r'^[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$');

RegExp npiRegex = RegExp(r'^[0-9]{10}$');
RegExp ifuRegex = RegExp(r'^[0-9]{13}$');

RegExp numeroRegex2 = RegExp(r'^[0-9]{8}$');

RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

RegExp numeroRegex1 = RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$');

RegExp datenaissRegex =
    RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/((19|20)\d\d)$');

RegExp doubleRegex = RegExp(r'^\d+\.?\d{0,2}');

RegExp fbkRegex =
    RegExp(r'^(http|https)://(www\.)?facebook.com/([a-zA-Z0-9.]{3,})/?$');
RegExp instaRegex =
    RegExp(r'^(http|https)://(www\.)?instagram.com/([a-zA-Z0-9._]{3,})/?$');
RegExp linRegex =
    RegExp(r'^(http|https)://(www\.)?linkedin.com/in/([a-zA-Z0-9-]{3,})/?$');
RegExp twtrRegex =
    RegExp(r'^(http|https)://(www\.)?twitter.com/([a-zA-Z0-9_]{1,15})/?$');
