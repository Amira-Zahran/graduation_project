class API{
  static String url = '';
  static String base = url + '/api/';
  // https://osharif.xyz/api/
  static String login = base + 'login';

  static String MenuRoute = base + 'menu';
  static String CustomerRoute = base + 'Customer/';
  static String OrderRoute = base + 'Order/';

  static String newCustomer = CustomerRoute+'new';
  static String getCustomer = CustomerRoute+'getCustomer';
  static String insertAddress = CustomerRoute+'insertAddress';
  static String updateAddress = CustomerRoute+'updateAddress';
  static String updateCustomerBase = CustomerRoute+'updateCustomerBase';
  static String updatePhoneNumber = CustomerRoute+'updatePhoneNumber';
  static String createOrder = OrderRoute+'create';
  static String updateOrder = OrderRoute+'update';
  static String deleteOrder = OrderRoute+'delete';
  static String getOrder = OrderRoute + 'getOrder';
  static String printReceipt = OrderRoute + 'createPDF';
  static String history = OrderRoute+'history';
}