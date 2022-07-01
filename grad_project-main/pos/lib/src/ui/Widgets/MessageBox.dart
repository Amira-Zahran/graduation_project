import 'dart:ffi';

import 'package:win32/win32.dart';

showMessageBox({String? title,String? message,String? type}){

  int msgboxID = MessageBox(
      FindWindow(nullptr,TEXT("pos")),
      TEXT(message!),
      TEXT(title!),
      type == 'error'
          ? MB_ICONERROR
          : MB_ICONINFORMATION | // Warning
              MB_OK // Second button is the default
      );

  if (msgboxID == MB_OK) {}

  return msgboxID;
}
showConfirmationBoxBox({String? title,String? message,String? type}){

  int msgboxID = MessageBox(
      FindWindow(nullptr,TEXT("pos")),
      TEXT(message!),
      TEXT(title!),
          MB_ICONHAND | // Warning
              MB_YESNO // Second button is the default
      );

  // if (msgboxID == MB_OK) {}

  return msgboxID;
}