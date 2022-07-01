import 'package:flutter/material.dart';
import 'package:untitled6/src/Controllers/API.dart';
import 'package:untitled6/src/Controllers/GlobalData.dart';
import 'package:untitled6/src/Controllers/Printing.dart';
import 'package:untitled6/src/Models/Item.dart';

class ItemWidget extends StatefulWidget {
  ItemWidget({Key? key,required this.item}) : super(key: key);
  Item item;
  @override
  _ItemState createState() => _ItemState();
}


class _ItemState extends State<ItemWidget> {



  Color color1() => const Color(0xFF0E232E);

  Color color2() => const Color(0xFFF9B700);
  bool x = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.item.photo!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 2,
                  child: Container(
                    height:25,
                    width: 70,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      child:  Text(
                        widget.item.item_name!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),

                  ),
                )
              ],
            ),
            height: 95,
            width: 145,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.red,
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Text('Notion: ${widget.item.comment} ',
                                style: TextStyle(
                                    color: color1(),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal)),
                            const SizedBox(
                              height: 1,
                            ),
                            Text('COUNT: ${widget.item.quantity}',
                                style: TextStyle(
                                    color: color1(),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal)),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: AlignmentDirectional.topEnd,
                      child: Checkbox(checkColor: color2(),activeColor: color1(),
                        value: widget.item.status == 'Done' ? true : false ,
                        onChanged: widget.item.status == 'Prepared'  ? null : (val) {
                          setState(() {
                            // x = val!;
                            bLoC.updateItemStatus(widget.item.id);
                            PrintingServices().printFromURL(url: API.BackOperationsRoute+'createLabelPDF',id: widget.item.id.toString(),printType: PrintType.DEFAULT_PRINTER);

                          });
                        },
                      )),
                )
              ],
            ),
            height: 35,
            width: 145,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: color2(),
            ),
          ),
        ],
      ),
    );
  }
}
