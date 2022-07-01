import 'dart:ffi';
import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/Config/Config.dart';
import 'package:pos/src/Config/GlobalData.dart';
import 'package:pos/src/Models/Addresse.dart';
import 'package:pos/src/ui/Widgets/AlertDialogs.dart';

// import 'package:pos/src/ui/Widgets/CRM_SECTION.dart';
import 'package:pos/src/ui/Widgets/addressDialogs.dart';
import 'package:pos/src/ui/Widgets/menu.dart';
import 'package:pos/src/Config/GlobalData.dart' as DataRepo;
import 'package:pos/src/ui/Widgets/newCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win32/win32.dart';
import 'package:xml_parser/xml_parser.dart';

import 'History.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  ScrollController sideBar = new ScrollController();

  // DataRepo.bLoC;
  int activeButton = 1;
  Widget _content = menu(callback: (){},);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: DataRepo.scaffold,
      // appBar: AppBar(
      //   elevation: 0,
      //
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [NavigationBar(), _content],
        ),
      ),
    );
  }

//0xffF9B700 yellow
  //0xff0E232E blue
  Widget NavigationBar() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.17,
      color: Color(Config.darkColor),
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: 170,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/imgs/Logo.png'),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 127,
                    width: 144,
                    child: Image.network('https://cdn-icons-png.flaticon.com/512/2922/2922506.png',scale: 5,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(Config.yellowColor)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${DataRepo.bLoC.user.name}',
                    style: TextStyle(
                        color: Color(Config.yellowColor),
                        fontSize: 30,
                        fontFamily: 'Cairo_Regular'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeButton = 1;
                          _content = menu(callback: (){setState((){});
                            print('Called');},);
                          DataRepo.orderDataRepo.clear();
                        });
                      },
                      child: Text(
                        'New Order',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 1
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 1
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeButton = 2;
                          _content = history(onEvent: (v){
                            setState(() {
                              activeButton = v;
                              _content = menu(callback: (){
                                setState((){

                                });
                              },);
                            });
                          },);
                        });
                      },
                      child: Text(
                        'History',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 2
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 2
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  DataRepo.bLoC.user.type == 'CallCenterAgent' ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        newCustomerDialog(context,(){
                          setState(() {

                          });
                        });
                      },
                      child: Text(
                        'New Customer',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 3
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 3
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  DataRepo.bLoC.user.type == 'CallCenterAgent' ? CRM_SECTION(context) : Container(),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(Config.darkColor)),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                    color: Color(Config.yellowColor)))),


                      ),
                        onPressed: () async{
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.remove('user');
                          ShellExecute(NULL, TEXT('open'), TEXT('.\\..\\..\\pos.exe'), nullptr, TEXT(''), SW_SHOW);

                          Future.delayed(Duration(seconds: 1), () {
                            exit(0);
                          });
                        },
                        child: Text('Logout',
                        style: TextStyle(
                          color: Color(Config.yellowColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular'
                        ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'System State:',
                        style: TextStyle(
                            color: Color(Config.yellowColor),
                            fontFamily: "Cairo_Regular",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Connected',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Cairo_Regular",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late WebSocket briaSocket;
  var _briaData;
  Future<void> initializeSocket() async{
    briaSocket = await WebSocket.connect('wss://127.0.0.1:9002/counterpath/socketapi/v1');
    briaSocket.listen((event) {
      _briaData = event;
      // print(event);
      // sendBriaMessage();
      _briaPrint(event);
    });
  }

  sendBriaMessage() {
    briaSocket.add(
        '''GET/status\nUser-Agent: POS-CRM\nTransaction-ID: EF855137\nContent-Type: application/xml\nContent-Length: 70\n<?xml version="1.0" encoding="utf-8" ?>\n<status>\n<type>call</type>\n</status>''');
  }

  String? loadCustomerFromBria(context, {String? number}) {
    try {
      print(number);
      if (number == null) {

        XmlDocument? xmlDocument;
        xmlDocument = XmlDocument.from(
            _briaData.toString().substring(_briaData.toString().indexOf('<')));
        customerData.phone_number.text =
        xmlDocument!.getElement('number')!.text!;
        customerData
            .getCustomer(PhoneNumber: customerData.phone_number.text , callback: () {  },context: context);
        return xmlDocument.getElement('number')!.text;
      } else {
        print('number is $number');
        customerData.phone_number.text = number;
        customerData
            .getCustomer(PhoneNumber: customerData.phone_number.text , callback: () { setState(() {

        });},context: context);;
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      // showAlertDialog(context, 'خطاء', 'لا توجد مكالمة مفتوحة', 'error');
      return null;
    }
    return null;
  }

  bool showed = false;

  _briaPrint(event) {
    if (event.contains('<event type="call"></event>')) {
      this.sendBriaMessage();
    }
    customerData.phone_number.text = XmlDocument.from(
        event.toString().substring(_briaData.toString().indexOf('<')))!
        .getElement('number')!
        .text!;
    if (showed == false) {
      showed = true;
      showFlash(
        context: scaffold.currentContext!,
        persistent: true,
        builder: (_, controller) {
          return Positioned(
            left: 290,
            top:
            MediaQuery.of(scaffold.currentContext!).size.height -
                200,
            child: Flash(
              controller: controller,
              margin: EdgeInsets.zero,
              behavior: FlashBehavior.fixed,
              position: FlashPosition.bottom,
              borderRadius: BorderRadius.circular(8.0),
              borderColor: Color(Config.yellowColor),
              boxShadows: kElevationToShadow[8],
              barrierDismissible: false,
              backgroundGradient: RadialGradient(
                colors: [Colors.white, Colors.white],
                center: Alignment.topLeft,
                radius: 2,
              ),
              //onTap: () => controller.dismiss(),
              forwardAnimationCurve: Curves.linear,
              reverseAnimationCurve: Curves.linear,
              child: SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.black),
                  child: FlashBar(
                    title: Text('اتصال جديد'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('هل تريد فتح بيانات الرقم:'),
                        SelectableText(
                            '${XmlDocument.from(event.toString().substring(_briaData.toString().indexOf('<')))!.getElement('number')!.text}')
                      ],
                    ),
                    indicatorColor: Color(Config.yellowColor),
                    icon: Image.network(
                      'https://images.g2crowd.com/uploads/product/image/social_landscape/social_landscape_27eb606390e11ea8586d7eb25008c1fa/bria.png',
                      scale: 10,
                    ),
                    primaryAction: IconButton(
                      onPressed: () {
                        showed = false;
                        controller.dismiss();
                      },
                      icon: Icon(Icons.close, color: Color(Config.yellowColor)),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            controller.dismiss('Yes, I do!');
                            showed = false;
                            customerData.clear();
                            showLoadingDialog(
                                scaffold.currentContext!);
                            this.loadCustomerFromBria(
                                scaffold.currentContext,
                                number: XmlDocument.from(event
                                    .toString()
                                    .substring(_briaData
                                    .toString()
                                    .indexOf('<')))!
                                    .getElement('number')!
                                    .text);

                          },
                          child: Text('نعم',
                              style: TextStyle(color: Color(Config.yellowColor)))),
                      TextButton(
                          onPressed: () {
                            showed = false;
                            controller.dismiss('No, I do not!');
                          },
                          child: Text('لا',
                              style: TextStyle(color: Color(Config.yellowColor)))),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

  }

  void dispose(){
    briaSocket.close(70051,'Closed');
    // briaSocket = WebSocket.connect('') as WebSocket;
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSocket();
  }

  Widget CRM_SECTION(BuildContext context) {
    return Container(
      // height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(Config.yellowColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: customerData.customerData.name != null ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(Icons.edit),
                    onTap: (){
                      setState(() {
                        customerData.customerName.text = customerData.customerData.name!;
                        customerData.phone_number.text = customerData.customerData.phones!.first.phone_number!;
                        // orderDataRepo.comments.text = customerData.customerData.comments!;
                      });
                      editCustomerDialog(context,(){setState(() {

                      });});
                    },
                  ),
                  InkWell(
                    child: Icon(Icons.close),
                    onTap: (){
                      customerData.clear();
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
              Text(
                'Name: ${customerData.customerData.name}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.darkColor)),
              ),
              Column(
                children: [
                  DropdownButton(
                    borderRadius: BorderRadius.circular(10 ),
                    isExpanded: true,
                    isDense: true,
                    dropdownColor: Color(Config.yellowColor),
                    hint: Text(
                      'Choose Address',
                      style: TextStyle(color: orderDataRepo.ADDRESS ? Colors.red : Color(Config.darkColor),fontFamily: 'Cairo_Regular',fontWeight: FontWeight.bold),
                    ),
                    value:
                    customerData.selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        customerData.selectedAddress =
                        (value as Addresse?)!;
                        // DataRepo.Customer.delivery_fee =
                        // double.tryParse(
                        //     value!.cost.toString())!;
                      });
                    },
                    items: customerData.customerData.addresses!.map((e) => DropdownMenuItem(child: Text('${e.floor}, ${e.apart_num}, ${e.building}, ${e.address}, ${e.area}',style: TextStyle(color: Color(Config.darkColor),fontWeight: FontWeight.bold,fontFamily: 'Cairo_Regular'),),value: e,)).toList(),
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.add),
                        onTap: (){
                          newAddressDialog(context,(){setState(() {

                          });});
                        },
                      ),
                      InkWell(
                        child: Icon(Icons.edit),
                        onTap: (){
                          editAddressDialog(context,customerData.selectedAddress!,(){setState(() {

                          });});
                        },
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: customerData.customerData.phones!.map((e) => Text(
                  'Phone: ${e.phone_number}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)),
                )).toList(),
              )
            ],
          ),
        ) :
        Column(
          children: [
            TextFormField(
              controller: customerData.phone_number,
              key: _formKey,
              validator: (v){
                if(v!.isNotEmpty){
                  // return 'True';
                }else{
                  return 'error';
                }
                return null;
              },
              onFieldSubmitted: (v){
                if(v.isNotEmpty){
                  showLoadingDialog(
                      scaffold.currentContext!);
                  customerData.getCustomer(context: context,PhoneNumber: v, callback: (){setState(() {

                  });});
                }

              },
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.darkColor)),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
