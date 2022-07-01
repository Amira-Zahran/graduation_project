class Address {
    String? address;
    String? apart_num;
    String? area;
    String? building;
    String? created_at;
    int? customer_id;
    String? floor;
    int? id;
    String? updated_at;

    Address({this.address, this.apart_num, this.area, this.building, this.created_at, this.customer_id, this.floor, this.id, this.updated_at});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            address: json['address'], 
            apart_num: json['apart_num'], 
            area: json['area'], 
            building: json['building'], 
            created_at: json['created_at'], 
            customer_id: json['customer_id'], 
            floor: json['floor'], 
            id: json['id'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['apart_num'] = this.apart_num;
        data['area'] = this.area;
        data['building'] = this.building;
        data['created_at'] = this.created_at;
        data['customer_id'] = this.customer_id;
        data['floor'] = this.floor;
        data['id'] = this.id;
        data['updated_at'] = this.updated_at;
        return data;
    }
}