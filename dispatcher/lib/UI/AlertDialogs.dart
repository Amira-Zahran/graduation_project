import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:win32/win32.dart';
showAlertDialog(title, message, type) {



  int msgboxID = MessageBox(
      FindWindow(nullptr,TEXT("pos")),
      TEXT(message),
      TEXT(title),
      type == 'error'
          ? MB_ICONERROR
          : MB_ICONINFORMATION | // Warning
              MB_OK // Second button is the default
      );
  if (msgboxID == MB_OK) {}
  return msgboxID;
}

showLicenseDialog(BuildContext context, message) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('License Issue'),
    content: Text(message),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoadingDialog(BuildContext context) {
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}



///the confirmation dialog that is shown to the user just before deleting a being edited order
// showConfirmationDialog(BuildContext context, title, message, type) {
//   // title : Text('هل أنت متأكد من مسح الاودرد؟ هذه العملية لايمكن العودة عنها');
//   // set up the button
//   Widget Cancel = FlatButton(
//     child: Text("الغاء"),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop();
//     },
//   );
//
//   Widget Delete = FlatButton(
//     child: Text("مسح الاوردر"),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop();
//     },
//   );
//
//
//
//   Widget okButton = FlatButton(
//     child: Text("اغلاق"),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop();
//     },
//   );
//
//
//
//   int msgboxID = MessageBox(
//       FindWindow(nullptr,TEXT("POS - TradePoint POS")),
//       TEXT(message),
//       TEXT(title),
//       type == 'error'
//           ? MB_ICONERROR
//           : MB_ICONINFORMATION | // Warning
//       MB_OK // Second button is the default
//   );
//   if (msgboxID == MB_OK) {}
//   return msgboxID;
// }




showConfirmationAlertDialog(BuildContext context, title, message , int ? OrderID) {
  // set up the button
  // Widget No = FlatButton(
  //   child: Text("اغلاق"),
  //   onPressed: () {
  //     Navigator.of(context, rootNavigator: true).pop();
  //   },
  // );
  //
  // Widget YesDelete = FlatButton(
  //   child: Text("هل انت متأكد من أنك تريد مسح هذا الطلب؟"),
  //   onPressed: () {
  //     Navigator.of(context, rootNavigator: true).pop();
  //     DataRepo.bLoC.deleteOrder(OrderID, context);
  //
  //   },
  // );


  //
  //
  // // set up the AlertDialog
  // AlertDialog alert = AlertDialog(
  //   title: Text(title),
  //   content: Text(message),
  //   actions: [
  //     YesDelete,
  //     No,
  //   ],
  // );

  // // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );

  int msgboxID = MessageBox(
      FindWindow(nullptr,TEXT("POS - TradePoint POS")),
      TEXT(message),
      TEXT(title),
      MB_ICONINFORMATION | // Warning
      MB_YESNO // Second button is the default
  );
  if (msgboxID == IDYES) {

    // DataRepo.bLoC.deleteOrder(OrderID, context);
  }
  return msgboxID;
}


showAlertDialog2(BuildContext context, title, message, type) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("اغلاق"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );













  // AlertDialog(
  //   title: const Text('in correct credentials'),
  //   content: const Text('AlertDialog description'),
  //   actions: <Widget>[
  //     TextButton(
  //       onPressed: () => Navigator.pop(context, 'Cancel'),
  //       child: const Text('Cancel'),
  //     ),
  //     TextButton(
  //       onPressed: () => Navigator.pop(context, 'OK'),
  //       child: const Text('OK'),
  //     ),
  //   ],
  // );
  //
  //
  //













  // int msgboxID = MessageBox(
  //     FindWindow(nullptr,TEXT("POS - TradePoint POS")),
  //     TEXT(message),
  //     TEXT(title),
  //     type == 'error'
  //         ? MB_ICONERROR
  //         : MB_ICONINFORMATION | // Warning
  //             MB_OK // Second button is the default
  //     );
  // if (msgboxID == MB_OK) {}
  // return msgboxID;
}



