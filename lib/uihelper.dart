import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uihelper{
  static CustomTextField(TextEditingController controller,String text,IconData iconData,bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 8),
      child: TextField(
          controller: controller,
          obscureText: toHide,
          decoration: InputDecoration(
              hintText: text,
              suffixIcon: Icon(iconData),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
              )
          )
      ),
    );
  }
  static CustomBtn(VoidCallback voidcallback ,String text){
    return SizedBox(height: 50,width:300,
      child: ElevatedButton(onPressed: (){
        voidcallback();
      }, child:Text(text,style: TextStyle(color:Colors.black, fontSize:20),))
      ,);
  }
  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok",style:TextStyle(color:Colors.red),))
          ],
        );
      },
    );
  }
}