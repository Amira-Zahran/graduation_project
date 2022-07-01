import 'package:delivery/main.dart';
import 'package:delivery/src/Controllers/Config.dart';
import 'package:flutter/material.dart';

import 'login_confirmation.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var phoneNumber=TextEditingController();
  var passwordController=TextEditingController();
  var formkey=GlobalKey<FormState>();
  bool password_eye= true;
  var phone_value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    bLoC.RetriveUserFromStorage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/imgs/login.png')
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return'Phone number must not be empty';
                        }
                        return null;
                      },
                      controller: phoneNumber,
                      onFieldSubmitted: (phone_value){print(phone_value);},
                      onChanged: (phone_value){print(phone_value);},
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                          color: Color(Config.yellowColor),
                          size: 30,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return'Password must be not empty';
                        }
                        return null;
                      },
                      controller: passwordController,
                      onFieldSubmitted: (p_value){print(p_value);},
                      // keyboardType: TextInputType.visiblePassword,
                      // obscureText: password_eye,
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        prefixIcon: Icon(
                          Icons.credit_card,
                          size: 30,
                          color: Color(Config.yellowColor),
                        ),
                        // suffixIcon: IconButton(
                        //   onPressed:(){
                        //     setState(() {
                        //       password_eye=!password_eye;
                        //     });
                        //   },
                        //   icon: Icon(password_eye?Icons.visibility:Icons.visibility_off,size: 30,),
                        //   color: Color(Config.yellowColor),
                        //
                        // ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 60,),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            if(formkey.currentState!.validate())
                            {
                              print(passwordController.text);
                              print(phoneNumber.text);
                              bLoC.login(context,phone: phoneNumber.text,id: passwordController.text);
                            }
                            if(formkey.currentState!.validate()){

                            }

                          },
                          child: Text('LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color(Config.darkColor)
                            ),
                          ),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor)),

                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
      ,
    );
  }
}
