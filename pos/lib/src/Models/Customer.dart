import 'Addresse.dart';
import 'Phone.dart';

class Customer {
    List<Addresse>? addresses;
    String? comments;
    int? id;
    String? name;
    String? notes;
    List<Phone>? phones;

    Customer({this.addresses, this.comments, this.id, this.name, this.notes, this.phones});

    factory Customer.fromJson(Map<String, dynamic> json) {
        return Customer(
            addresses: json['addresses'] != null ? (json['addresses'] as List).map((i) => Addresse.fromJson(i)).toList() : null, 
            comments: json['comments'], 
            id: json['id'], 
            name: json['name'], 
            notes: json['notes'], 
            phones: json['phones'] != null ? (json['phones'] as List).map((i) => Phone.fromJson(i)).toList() : null, 
        );
    }
}