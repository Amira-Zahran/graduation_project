import 'package:untitled1/config/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/mainpage.dart';
import 'package:untitled1/modules/login_confirmation.dart';
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
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: password_eye,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30,
                          color: Color(Config.yellowColor),
                        ),
                        suffixIcon: IconButton(
                          onPressed:(){
                            setState(() {
                              password_eye=!password_eye;
                            });
                          },
                          icon: Icon(password_eye?Icons.visibility:Icons.visibility_off,size: 30,),
                          color: Color(Config.yellowColor),

                        ),
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
                            }
                          if(formkey.currentState!.validate()){
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context)=>login_confirmation())
                            );
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
