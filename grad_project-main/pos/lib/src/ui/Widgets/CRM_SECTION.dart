import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/Addresse.dart';
import 'package:pos/src/ui/Widgets/addressDialogs.dart';
import 'package:xml_parser/xml_parser.dart';

import 'AlertDialogs.dart';
import 'newCustomer.dart';

class CRM_SECTION extends StatefulWidget implements PreferredSizeWidget{
  const CRM_SECTION({Key? key}) : super(key: key);

  @override
  State<CRM_SECTION> createState() => _CRM_SECTIONState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CRM_SECTIONState extends State<CRM_SECTION> {
  // TextEditingController phoneNumber = new TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(Config.yellowColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        customerData.customerData.name != null ?
        SingleChildScrollView(
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
