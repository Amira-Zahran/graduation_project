class API{
  static String url = 'https://osharif.xyz';
  static String base = url + '/api/';
  // https://osharif.xyz/api/
  static String login = base + 'login';

  static String BackOperationsRoute = base + 'BackOperations/';

  static String getCounterOrders = BackOperationsRoute+'getCounterOrders';
  static String updateStatus = base+'Order/updateStatus';
  static String updateItemStatus = BackOperationsRoute+'updateItemStatus';
 // static String getDeliveryAgents = OrderRoute+'getDeliveryAgents';

 static String MenuRoute = base + 'menu';
  /*static String CustomerRoute = base + 'Customer/';

  static String insertAddress = CustomerRoute+'insertAddress';*/
}