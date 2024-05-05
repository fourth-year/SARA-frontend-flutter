import 'package:flutter/material.dart';

class textfromfilde extends StatelessWidget {
  textfromfilde(
  {Key? key,
  required this.hint,
  this.color = Colors.grey,
  this.r = 30,
  this.count,
  this.icon,
  this.color1 = Colors.black87,
  this.size=14,
  this.sizeh,
  this.type,
  this.obscure = false,
  this.controller,
  this.validate,
  this.suffix,
  this.prefix,
  this.suffixPressed})
: super(key: key);


 String? Function(String?)? validate;
 void Function()? suffixPressed;
Color? color;
Color? color1;
String hint;
int? count ;
IconData? icon;
double? r;
double? size;
double? sizeh;
TextInputType? type;
bool obscure;
TextEditingController? controller;
IconData? suffix;
Icon? prefix;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: obscure,
    maxLength: count,

    // لون خط  مؤشر الكتابة وارتفاعه
    cursorColor: color1,
    cursorHeight: sizeh,

      //لون الكتابة وحجمها
    style: TextStyle(
    color: color1,
    fontSize: size,
    ),

    decoration:
    InputDecoration(
    // isDense: false,

    contentPadding:
    EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
    //لون المستطيل كامل
    filled: true,
    fillColor: color,

    // border: InputBorder.none,

    // enabledBorder: InputBorder.none,
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(r!),
      borderSide: BorderSide.none,


            ),
    hintText: hint,
    hintStyle: TextStyle(color: color1),

    suffixIcon: suffix != null
    ? IconButton(
    icon: Icon(
    suffix,
    color: color1,
    ),
    onPressed: suffixPressed,
    )
        : null,
        prefixIcon: prefix,
        suffixIconColor: color1),

    validator: validate,

    );
}
}
