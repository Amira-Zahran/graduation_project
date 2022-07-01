class Addresse {
    String? address;
    String? apart_num;
    String? area;
    String? building;
    int? customer_id;
    String? floor;
    int? id;

    Addresse({this.address, this.apart_num, this.area, this.building, this.customer_id, this.floor, this.id});

    factory Addresse.fromJson(Map<String, dynamic> json) {
        return Addresse(
            address: json['address'], 
            apart_num: json['apart_num'], 
            area: json['area'], 
            building: json['building'], 
            customer_id: json['customer_id'], 
            floor: json['floor'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['apart_num'] = this.apart_num;
        data['area'] = this.area;
        data['building'] = this.building;
        data['customer_id'] = this.customer_id;
        data['floor'] = this.floor;
        data['id'] = this.id;
        return data;
    }
}