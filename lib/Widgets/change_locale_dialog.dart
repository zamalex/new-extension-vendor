import 'package:easy_localization/src/public_ext.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:flutter/material.dart';



class ChangeLocaleDoialog extends StatelessWidget {
  const ChangeLocaleDoialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locales = context.supportedLocales;

    return Container(
      padding: const EdgeInsets.all(8.0),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ListView.separated(itemBuilder: (c,i){
              return ListTile(title: Text(locales[i].languageCode.tr()),onTap: (){
                context.setLocale(locales[i]);
                Constants.LOCALE=locales[i].languageCode;
                Navigator.of(context).pop();
              },trailing: locales[i].languageCode==context.locale.languageCode?Icon(Icons.done,color: Colors.green,):Container(width: 12,height: 12,),);

            }, separatorBuilder: (d,_)=>Divider(), itemCount: locales.length))
          ],

        ),
      ),

    );
  }
}
