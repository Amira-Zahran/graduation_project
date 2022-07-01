import 'package:flutter/material.dart';
import 'package:untitled6/src/UI/item.dart';
import 'package:untitled6/src/Controllers/Config.dart';
import 'package:untitled6/src/Controllers/GlobalData.dart';
import 'package:untitled6/src/Models/Order.dart';

  // constructor


class OrderItem extends StatefulWidget {
  OrderItem({Key? key,required this.order}) : super(key: key);
  Order order;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderItem> {

  @override
  Widget build(BuildContext context) {
    Color color1() => const Color(0xFF0E232E);
    Color color2() => const Color(0xFFF9B700);

    return Container(
      child: Column(
        children: [

          Container(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                GridView(
                  padding: EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  children: widget.order.items!.map((e) => ItemWidget(item: e)).toList(),
                ),
                IconButton(onPressed: (){
                  print(widget.order.items!.where((element) => element.status == 'Preparing' ).length);
                    widget.order.items!.forEach((element) {
                      setState(() {
                        // x = val!;
                        element.status == 'Prepared' ? bLoC.updateItemStatus(element.id) : null ;

                      });
                    });

                }, icon: Icon(Icons.check_box_outline_blank_outlined, color: Colors.white,),),
              ],
            ),
            alignment: Alignment.topRight,
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: color1(),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: color2(),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topLeft,
                      child: Text('ID Order: ${widget.order.order_id}           Type: ${widget.order.type}',
                          style: TextStyle(
                              color: color1(),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                    ),
                    Expanded(
                      child: Container(padding: const EdgeInsets.all(2),
                          alignment: AlignmentDirectional.topEnd,
                          child:
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(DateTime.now().difference(DateTime.parse(widget.order.created_at!)).inMinutes.toString(),
                                  style: TextStyle(
                                      color: color1(),
                                      fontSize:17,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal)),
                              const Icon(
                                Icons.timelapse_outlined,
                                color: Colors.green,
                                size: 20,
                              )

                            ],
                          )


                      ),
                    )
                  ],
                ),
                widget.order.items!.where((elemnt) => elemnt.status != 'Done').length > 0 ? Text('') : ElevatedButton(onPressed: widget.order.items!.where((elemnt) => elemnt.status != 'Done').length > 0 ? null :  (){
                  bLoC.updateStatus(widget.order.id!,widget.order.type!.toLowerCase().contains('delivery') ? 'Ready' : 'Done');
                }, child: Text('Done'),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(
                        Config.darkColor)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            side: BorderSide(
                                color: Color(Config.yellowColor))))),)
              ],
            ),
          )

        ],
      ),
    );
  }
}
