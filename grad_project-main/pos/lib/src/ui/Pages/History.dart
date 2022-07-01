import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Config/Printing.dart';
import 'package:pos/src/Models/HistoryOrder.dart';

class history extends StatefulWidget implements ObstructingPreferredSizeWidget {
  history({Key? key, required this.onEvent}) : super(key: key);
  ValueChanged onEvent;

  @override
  _historyState createState() => _historyState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    throw UnimplementedError();
  }
}

class _historyState extends State<history> {
  int history_search = 1;
  late String valuechoose;
  String orderType = 'Delivery';
  final List sort = [
    'All',
    'Id',
    'Empolyee',
    'Date',
    'State',
    'Cus.Name',
    'Driver Name',
    'Type'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderType = bLoC.user.type == 'CallCenterAgent' ? 'Delivery' : 'Floor';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.83,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'ALL ORDERS HISTORY',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo_Regular',
                        color: Color(Config.yellowColor)),
                  ),
                  Text(
                    '6 October,Egypt|3rd October 2021',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo_Regular',
                        color: Color(Config.darkColor)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.darkColor)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(Config.darkColor),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(2),
                      icon: Icon(Icons.search),
                      color: Color(Config.yellowColor),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: bLoC.user.type == 'CallCenterAgent'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderType = 'DeliveryTakeAway';
                            });
                          },
                          child: Text(
                            'TakeAway',
                            style: TextStyle(
                              color: Color(orderType == 'DeliveryTakeAway'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderType == 'DeliveryTakeAway'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                            // shape: MaterialStateProperty.all(
                            //     RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.all(Radius.circular(15)),
                            //         side: BorderSide(color: Color(Config.yellowColor))
                            //     )
                            // )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderType = 'Delivery';
                            });
                          },
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              color: Color(orderType == 'Delivery'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderType == 'Delivery'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                            // shape: MaterialStateProperty.all(
                            //     RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.all(Radius.circular(15)),
                            //         side: BorderSide(color: Color(Config.yellowColor))
                            //     )
                            // )
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderType = 'Floor';
                            });
                          },
                          child: Text(
                            'Floor',
                            style: TextStyle(
                              color: Color(orderType == 'Floor'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderType == 'Floor'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderType = 'TakeAway';
                            });
                          },
                          child: Text(
                            'TakeAway',
                            style: TextStyle(
                              color: Color(orderType == 'TakeAway'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderType == 'TakeAway'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<UnmodifiableListView<HistoryOrder>>(
              stream: bLoC.History,
              initialData: UnmodifiableListView<HistoryOrder>([]),
              builder: (context, snapshot) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                      showCheckboxColumn: false,
                      columns: bLoC.user.type == 'CallCenterAgent'
                          ? [
                              DataColumn(
                                  label: Text(
                                '#',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Empolye',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Cus.Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Driver Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Type',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                            ]
                          : [
                              DataColumn(
                                  label: Text(
                                '#',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Empolye',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(
                                  label: Text(
                                'Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              // DataColumn(
                              //     label: Text(
                              //       'Cus.Name',
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 25,
                              //           fontFamily: 'Cairo_Regular',
                              //           color: Color(Config.darkColor)),
                              //     )),
                              // DataColumn(
                              //     label: Text(
                              //       'Driver Name',
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 25,
                              //           fontFamily: 'Cairo_Regular',
                              //           color: Color(Config.darkColor)),
                              //     )),
                              DataColumn(
                                  label: Text(
                                'Type',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Cairo_Regular',
                                    color: Color(Config.darkColor)),
                              )),
                              DataColumn(label: Text(''))
                            ],
                      rows: snapshot.data!
                          .where((element) => element.type!.contains(orderType))
                          .map((e) => DataRow(
                              onSelectChanged:
                                  (e.status == 'Canceled' || e.status == 'Done')
                                      ? null:  (b) {
                                          bLoC.getOrder(e.id).then((value) {
                                            setState(() {
                                              widget.onEvent(value);
                                            });
                                          });
                                        },
                              cells: bLoC.user.type == 'CallCenterAgent'
                                  ? [
                                      DataCell(Text(
                                        e.order_id!.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.cc_name!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        DateFormat(DateFormat.HOUR_MINUTE)
                                            .format(
                                                DateTime.parse(e.adding_time!))
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.status!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.custoemr_name!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.agent_name!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.type!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                    ]
                                  : [
                                      DataCell(Text(
                                        e.order_id!.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.cc_name!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        DateFormat(DateFormat.HOUR_MINUTE)
                                            .format(
                                                DateTime.parse(e.adding_time!))
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(Text(
                                        e.status!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      // DataCell(Text(
                                      //   e.custoemr_name!,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Cairo_Regular',
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Color(Config.darkColor)),
                                      // )),
                                      // DataCell(Text(
                                      //   e.agent_name!,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Cairo_Regular',
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Color(Config.darkColor)),
                                      // )),
                                      DataCell(Text(
                                        e.type!,
                                        style: TextStyle(
                                            fontFamily: 'Cairo_Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Config.darkColor)),
                                      )),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(
                                            Icons.print_outlined,
                                            color: Color(Config.yellowColor),
                                          ),
                                          onPressed: () {
                                            bLoC.user.type == 'Cashier'
                                                ? PrintingServices()
                                                    .printFromURL(
                                                        url: API.printReceipt,
                                                        id: e.id.toString(),
                                                        printType: PrintType
                                                            .DEFAULT_PRINTER)
                                                : null;
                                            // _showDialog(e.id);
                                          },
                                        ),
                                      )
                                    ]))
                          .toList()),
                );
              }),
        ],
      ),
    );
  }
}
