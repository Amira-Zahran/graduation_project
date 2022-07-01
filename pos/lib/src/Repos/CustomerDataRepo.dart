
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/Addresse.dart';
import 'package:pos/src/ui/Widgets/AlertDialogs.dart';
import 'package:pos/src/ui/Widgets/newCustomer.dart';


class CustomerData{

  Customer customerData = Customer();
  ValueListenable<bool> cleard = ValueNotifier(true);
  Addresse? selectedAddress;
  TextEditingController customerAddress = new TextEditingController();
  TextEditingController customerName = new TextEditingController();
  TextEditingController phone_number = new TextEditingController();

  Future<void> getCustomer({required String PhoneNumber,required VoidCallback callback,context}) async {
    Response response = await post(Uri.parse(API.getCustomer),
        body: {
          "phone_number" : PhoneNumber
        },
        headers: {
          "Authorization":
          "Bearer ${bLoC.user.token}"
        });
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    if(response.statusCode == 200) {
        customerData = Customer.fromJson(data);
        orderDataRepo.comments.text = customerData.comments!;
        callback();
        cleard = ValueNotifier(false);
        // cleard.notifyListeners();

        Navigator.of(context, rootNavigator: true).pop();

    } else{
      Navigator.of(context, rootNavigator: true).pop();
      showMessageBox(title: 'Not Found',message: data['message'],type: 'error');
      newCustomerDialog(context,(){callback();});
    }
  }

  Future<Null> newCustomer(
      {required String name,
      required String phone_number,
      required String address,
      required String area,
      required String building,
      required String floor,
      required String apart_num,context,required VoidCallback callback}) async{
    Response response = await post(Uri.parse(API.newCustomer),
    headers: {
      'Authorization' : "Bearer ${bLoC.user.token}"
    },
    body:{
    'name' : name,
    'phone_number' : phone_number,
    'address' : address,
    'area' : '1',
    'building' : building,
    'floor' :floor ,
    'apart_num' : apart_num
    });
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    if(response.statusCode == 200){
      // Navigator.of(context, rootNavigator: true).pop();
      showMessageBox(title: 'Done',message: 'Customer ID: ${data['id']}',type: 'eee');
      getCustomer(context:scaffold.currentContext,PhoneNumber: phone_number, callback: () { callback(); });
    }else{
      Navigator.of(context, rootNavigator: true).pop();
      showMessageBox(title: 'Done',message: 'Customer ID: ${data['message']}',type: 'error');
    }
  }

  updateData(Customer CustData) {
    customerData = CustData;
    // name.text = CustData.basicInfo.name;
    orderDataRepo.comments.text = CustData.comments!;
    // internal_notes.text = CustData.basicInfo.internal_notes != null
    //     ? CustData.basicInfo.internal_notes
    //     : '';
    phone_number.text = CustData.phones!.first.phone_number!;
    // phoneNumber1ID = CustData.phones[0].id;
    // CustData.phones.length > 1
    //     ? PhoneNumber2.text = CustData.phones[1].phone_number
    //     : null;
    // CustData.phones.length > 1 ? phoneNumber2ID = CustData.phones[1].id : 0;
    try {
      selectedAddress = CustData.addresses!.first;
    } on RangeError {
      Navigator.of(scaffold.currentContext!, rootNavigator: true)
          .pop();
      throw showAlertDialog(scaffold.currentContext!, 'خطاء',
          'يوجد خطاء في عناوين العميل', 'error');
    }
    // delivery_fee = double.tryParse(CustData.address[0].cost.toString())!;
    // CustData.address
    //     .map((e) => address.add(DropdownMenuItem(
    //   child: Text(e.address),
    //   value: e,
    // )))
    //     .toList();
  }

  void clear(){
    customerData= Customer();
    selectedAddress = null;
    customerAddress.text = '' ;
    cleard = ValueNotifier(true);
    // cleard.notifyListeners();
  }

  Future<void> insertAddress({context,required String address, required String area, required String building, required String floor, required String apart_num,required VoidCallback callback}) async {
    Response response = await post(Uri.parse(API.insertAddress),
        headers: {
          'Authorization' : "Bearer ${bLoC.user.token}"
        },
        body: {
          'address':address,
          'area':area,
          'building':building,
          'floor':floor,
          'apart_num':apart_num,
          'csID': this.customerData.id.toString()
    });
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    this.customerData.addresses!.add(Addresse.fromJson(data['address']));
    callback();
    this.selectedAddress = Addresse.fromJson(data['address']);
    callback();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void updateAddress({context,required String address, required String area, required String building, required String floor, required String apart_num,required VoidCallback callback}) async {
    Response response = await post(Uri.parse(API.updateAddress),
        headers: {
          'Authorization' : "Bearer ${bLoC.user.token}"
        },
        body: {
          'address':address,
          'area':'..',
          'building':building,
          'floor':floor,
          'apart_num':apart_num,
          'id':selectedAddress!.id.toString(),
          // 'csID': this.customerData.id.toString()
        });
    print(response.body);
    String? phone = customerData.phones!.first.phone_number;
    clear();
    getCustomer(PhoneNumber: phone!, callback: (){callback();},context: context);
    callback();
  }

  void updatePhone() async{
    Response response = await post(Uri.parse(API.updatePhoneNumber),
    headers: {
      'Authorization' : "Bearer ${bLoC.user.token}"
    },
    body: {
      'phone_number' : phone_number.text,
      'id' : customerData.phones!.first.id.toString()
    });
    print(response.body);
  }

  void updateCustomer(VoidCallback callback) async{
    Response response = await post(Uri.parse(API.updateCustomerBase),
        headers: {
          "Authorization":
          "Bearer ${bLoC.user.token}"
        },
        body: {
      'id': customerData.id.toString(),
          'name' : customerName.text,
          'comments' : orderDataRepo.comments.text
        }
    );
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    print('called');

    String? phone = phone_number.text;
    updatePhone();
    clear();
    getCustomer(PhoneNumber: phone, callback: (){callback();},context: scaffold.currentContext);
  }

}