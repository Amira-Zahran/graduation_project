import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_screen/colors.dart';
import 'package:win32/win32.dart';

int activeButton = 1;

class loginScreen extends StatelessWidget {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool rfid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/images/login.png"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('lib/assets/images/Logo.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 500,
                            height: 500,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 95,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                  Theme(
                                    data: ThemeData(

                                      inputDecorationTheme: InputDecorationTheme(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: AppColors.ButtonColor),
                                        ),
                                        focusColor: AppColors.ButtonColor,
                                        fillColor: AppColors.ButtonColor,
                                      )
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30,
                                              bottom: 15,
                                              left: 50,
                                              right: 50),
                                          child: TextField(
                                            controller: _usernameController,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'Cairo_Regular'),
                                            decoration: InputDecoration(
                                                hintText: "User Name",
                                                icon: Icon(
                                                  Icons.account_box_outlined,
                                                  size: 35,
                                                  color: AppColors.ButtonColor,
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.black),
                                                ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30,
                                              bottom: 15,
                                              left: 50,
                                              right: 50),
                                          child: TextField(
                                            controller: _passwordController,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo_Regular',
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                icon: Icon(
                                                  Icons.lock_open,
                                                  size: 35,
                                                  color: AppColors.ButtonColor,
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                           Response response = await post(Uri.parse(
                                                "https://osharif.xyz/api/login"),
                                                body: rfid ? {
                                                  "email": _usernameController
                                                      .text,
                                                  "password": _passwordController
                                                      .text
                                                } : {
                                                    "card_id": _usernameController
                                                        .text,
                                                });
                                           print(response.body);
                                            Map<String,dynamic> data = json.decode(response.body);
                                            switch(data['type']){
                                              case "CallCenterAgent":
                                                print('called');
                                                print(ShellExecute(NULL, nullptr, TEXT('C:\\Users\\omars\\Documents\\GitHub\\grad_project\\login_screen\\build\\windows\\runner\\Debug\\software\\pos\\pos.exe'), TEXT('--username=osharif --password=123456789'), TEXT('..\\'), SW_SHOW));
                                            }
                                          },
                                          child: Text(
                                            "Login",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.ButtonColor,
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.black54,
                                            ),
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "FRID",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.ButtonColor,
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.black54,
                                            ),
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
