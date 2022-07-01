class HistoryOrder {
    String? accepting_date;
    String? adding_time;
    String? agent_name;
    String? cc_name;
    String? custoemr_name;
    int? id;
    int? is_updated;
    String? last_update;
    String? operation_id;
    int? order_id;
    String? order_type;
    String? status;
    String? type;

    HistoryOrder({this.accepting_date, this.adding_time, this.agent_name, this.cc_name, this.custoemr_name, this.id, this.is_updated, this.last_update, this.operation_id, this.order_id, this.order_type, this.status, this.type});

    factory HistoryOrder.fromJson(Map<String, dynamic> json) {
        return HistoryOrder(
            accepting_date: json['accepting_date'], 
            adding_time: json['adding_time'], 
            agent_name: json['agent_name'], 
            cc_name: json['cc_name'], 
            custoemr_name: json['custoemr_name'], 
            id: json['id'], 
            is_updated: json['is_updated'], 
            last_update: json['last_update'], 
            operation_id: json['operation_id'], 
            order_id: json['order_id'], 
            order_type: json['order_type'], 
            status: json['status'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['accepting_date'] = this.accepting_date;
        data['adding_time'] = this.adding_time;
        data['agent_name'] = this.agent_name;
        data['cc_name'] = this.cc_name;
        data['custoemr_name'] = this.custoemr_name;
        data['id'] = this.id;
        data['is_updated'] = this.is_updated;
        data['last_update'] = this.last_update;
        data['operation_id'] = this.operation_id;
        data['order_id'] = this.order_id;
        data['order_type'] = this.order_type;
        data['status'] = this.status;
        data['type'] = this.type;
        return data;
    }
}