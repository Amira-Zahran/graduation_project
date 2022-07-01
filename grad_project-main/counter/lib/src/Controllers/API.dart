class API{
  static final url = 'https://osharif.xyz';
  static final base = url + '/api/';
  // https://osharif.xyz/api/
  static final login = base + 'login';

  static final BackOperationsRoute = base + 'BackOperations/';

  static final getCounterOrders = BackOperationsRoute+'getCounterOrders';
  static final updateStatus = base+'Order/updateStatus';
  static final updateItemStatus = BackOperationsRoute+'updateItemStatus';
 // static final getDeliveryAgents = OrderRoute+'getDeliveryAgents';

/* static final MenuRoute = base + 'menu';
  static final CustomerRoute = base + 'Customer/';

  static final insertAddress = CustomerRoute+'insertAddress';
*/}