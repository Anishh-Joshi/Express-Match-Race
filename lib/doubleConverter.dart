import 'package:intl/intl.dart';

class  DoubleConverter{

  String convertDouble(double number) {
    print(number);
  double num = number;
  final formatter = new NumberFormat("#.###", "en_US");
  
    if(num>=1000000000000){
    num=num/1000000000000;
    String formattedNumber = formatter.format(num);
     return num.toStringAsFixed(2).toString()+' T';// prints 13273.628T
  }
  else if(num>=1000000000){
    num=num/1000000000;
    String formattedNumber = formatter.format(num);
    return num.toStringAsFixed(2).toString()+' B';
  }
  else if(num>=1000000){
    num=num/1000000;
    String formattedNumber = formatter.format(num);
      return num.toStringAsFixed(2).toString()+' M';
  }
  else if(num>=1000){
    num=num/1000;
    String formattedNumber = formatter.format(num);
   return num.toStringAsFixed(2).toString()+' K';
  }
  else{
    String formattedNumber = formatter.format(num);
    return num.toStringAsFixed(2).toString();
  }
}

}