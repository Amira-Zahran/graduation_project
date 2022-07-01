import 'package:flutter/material.dart';
import 'package:my_app/const/Colors/colors.dart';



class Elevated_Button extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(style: ButtonStyle(
            overlayColor: getColor(
                AppColors.BarColor, AppColors.ButtonColor
            )
        ),
            onPressed: () {}, child: Text('New'))
      ],
    );
  }
}

MaterialStateProperty<Color>getColor(Color barColor, Color buttonColor) {
  final getColor=(Set<MaterialState>states){
    if(states.contains(MaterialState.pressed)){
      return AppColors.ButtonColor;
    }
    else {
      return AppColors.BarColor;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}