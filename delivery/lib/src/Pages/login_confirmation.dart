import 'package:delivery/main.dart';
import 'package:delivery/src/Controllers/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'mainpage.dart';
class login_confirmation extends StatefulWidget {
  login_confirmation({Key? key, required this.otp_request_id, required this.id}) : super(key: key);
  String otp_request_id;
  String id;

  @override
  _login_confirmationState createState() => _login_confirmationState();
}

class _login_confirmationState extends State<login_confirmation> {
  var frist_num=TextEditingController();
  var sec_num=TextEditingController();
  var third_num=TextEditingController();
  var fourth_num=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Config.darkColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            size: 25,
            color: Color(Config.yellowColor),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Verification Code',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(Config.darkColor),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('We sent the verification code to',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,

                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Text('011******66',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Color(Config.darkColor),
                      //     fontWeight: FontWeight.bold
                      //
                      //   ),
                      // ),
                      TextButton(onPressed: (){
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                          child: Text('Change phone number?',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(Config.yellowColor),
                                fontWeight: FontWeight.bold

                            ),
                          ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/imgs/confirm.png'),
                          opacity: 50
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: frist_num,
                          onFieldSubmitted: (value){print(value);},
                          onChanged: (value){
                            if(value.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            iconColor: Color(Config.yellowColor),
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          textAlign:TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: sec_num,
                          onFieldSubmitted: (value){print(value);},
                          onChanged: (value){
                            if(value.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            iconColor: Color(Config.yellowColor),
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          textAlign:TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: third_num,
                          onFieldSubmitted: (value){print(value);},
                          onChanged: (value){
                            if(value.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            iconColor: Color(Config.yellowColor),
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          textAlign:TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: fourth_num,
                          onFieldSubmitted: (value){print(value);},
                          onChanged: (value){
                            if(value.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            iconColor: Color(Config.yellowColor),
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          textAlign:TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),

                    ],
                  ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('Resend code after',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.black54,
                  //         fontWeight: FontWeight.bold
                  //
                  //       ),
                  //     ),
                  //     Text('1:35',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(Config.yellowColor),
                  //
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 190,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: (){
                          },
                          child: Text('Resend',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(Config.yellowColor)
                            ),
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(Color(Config.darkColor)),
                          )
                        ),
                        ),

                      SizedBox(
                        height: 50,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              if (formkey.currentState!.validate())
                              {
                                print(frist_num.text);
                                print(sec_num.text);
                                print(third_num.text);
                                print(fourth_num.text);
                              }
                              if(formkey.currentState!.validate()){
                                bLoC.validateOTP(context,otp: "${frist_num.text}${sec_num.text}${third_num.text}${fourth_num.text}",req_id: widget.otp_request_id,id:widget.id);
                              }
                            });
                          },
                          child: Text('Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(Config.darkColor)
                            ),
                          ),
                          style: ButtonStyle(elevation: MaterialStateProperty.all(0),backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor))),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      )
      ,
    );
  }
}
