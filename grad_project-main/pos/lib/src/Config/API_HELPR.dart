class API{
  static final url = 'https://osharif.xyz';
  static final base = url + '/api/';
  // https://osharif.xyz/api/
  static final login = base + 'login';

  static final MenuRoute = base + 'menu';
  static final CustomerRoute = base + 'Customer/';
  static final OrderRoute = base + 'Order/';

  static final newCustomer = CustomerRoute+'new';
  static final getCustomer = CustomerRoute+'getCustomer';
  static final insertAddress = CustomerRoute+'insertAddress';
  static final updateAddress = CustomerRoute+'updateAddress';
  static final updateCustomerBase = CustomerRoute+'updateCustomerBase';
  static final updatePhoneNumber = CustomerRoute+'updatePhoneNumber';
  static final createOrder = OrderRoute+'create';
  static final updateOrder = OrderRoute+'update';
  static final deleteOrder = OrderRoute+'delete';
  static final getOrder = OrderRoute + 'getOrder';
  static final printReceipt = OrderRoute + 'createPDF';
  static final history = OrderRoute+'history';
}