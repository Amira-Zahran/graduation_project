class API{
  static String url = '';

  static String base = url + '/api/';

  static String login = base + 'login';

  static String DispatcherRoute = base + 'Dispatching/';

  static String OrderRoute = base + 'Order/';

  static String getAgent = DispatcherRoute+'getDeliveryAgents';

  static String getOrders = DispatcherRoute+'getOrders';

  static String acceptOrder = DispatcherRoute+'acceptOrder';

  static String updateStatus = OrderRoute+'updateStatus';

  static String history = OrderRoute+'history';

  static String createOp = DispatcherRoute+ 'createDeliveryOperation';

  static String printReceipt = OrderRoute+'createPDF';
}