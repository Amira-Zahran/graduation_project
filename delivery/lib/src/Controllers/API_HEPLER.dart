import 'package:delivery/src/Pages/Login.dart';

class API{
  static const url = "https://osharif.xyz";

  static const base = "$url/api/";
  static const DeliveryAgentRoute = "${base}DeliveryAgent/";

  static const login = "${base}agentLogin";

  static const otpValidate = "${base}agentOTPValidate";

  static const Orders = "${DeliveryAgentRoute}Orders";

  static const History = "${DeliveryAgentRoute}History";

  static const updatedStatus = "${DeliveryAgentRoute}updatedStatus";

  static const updateStatus = base+'Order/updateStatus';
}