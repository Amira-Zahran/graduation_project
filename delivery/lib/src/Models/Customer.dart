import 'package:delivery/src/Models/Phone.dart';

class Customer {
    String? name;
    List<Phone>? phones;

    Customer({this.name, this.phones});

    factory Customer.fromJson(Map<String, dynamic> json) {
        return Customer(
            name: json['name'], 
            phones: json['Phones'] != null ? (json['Phones'] as List).map((i) => Phone.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        if (this.phones != null) {
            data['phones'] = this.phones!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}