import 'package:flutter/material.dart';

class APPBar extends StatefulWidget {
  const APPBar({Key? key}) : super(key: key);

  @override
  State<APPBar> createState() => _APPBarState();
}

class _APPBarState extends State<APPBar> {
  Color color1 = const Color(0xFF0E232E);
  Color color2 = const Color(0xFFF9B700);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: const Color(0xFFF9B700),
    minimumSize: const Size(80, 30),
    padding: const EdgeInsets.all(5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        flexibleSpace: Row(
          children: [
            Container(
                height: 100,
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/3.png", fit: BoxFit.fill)),
            VerticalDivider(
              color: color2,
              thickness: 2,
              width: 30,
            ),
            Container(alignment: AlignmentDirectional.bottomCenter,padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Text('ALL'),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Over Time'),
                        Icon(
                          Icons.timelapse_outlined,
                          color: color1,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Lunch'),
                        Icon(
                          Icons.lunch_dining,
                          color: color1,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Desserts'),
                        Icon(
                          Icons.lunch_dining,
                          color: color1,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Drinks'),
                        Icon(
                          Icons.local_drink,
                          color: color1,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: color1,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Counter',
                style: TextStyle(
                    color: Color(0xFFF9B700),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal)),
          )
        ],
      ),
    );
  }
}
