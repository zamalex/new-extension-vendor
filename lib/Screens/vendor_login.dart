
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Providers/loginmodel.dart';
import 'package:extension_vendor/Screens/home_screen.dart';
import 'package:extension_vendor/Screens/worker/worker_appointments.dart';
import 'package:extension_vendor/vendor/text_field.dart';
import 'package:extension_vendor/vendor/theme_button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class VendorLogin extends StatefulWidget {


  @override
  _VendorLoginState createState() => _VendorLoginState();
}

class _VendorLoginState extends State<VendorLogin> {
  @override
  Widget build(BuildContext context) {


    return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hair.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SignInWidget(title: 'Welcome back'),
            )
          ],
        );

  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key key,
    this.title,
  }) : super(key: key);

  /// Optional widget title.
  final String title;

  @override
  _SignInWidgetState createState() => _SignInWidgetState();


}

class _SignInWidgetState extends State<SignInWidget> with SingleTickerProviderStateMixin {
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPassController = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  final GlobalKey<ThemeTextInputState> keyEmailInput = GlobalKey<ThemeTextInputState>();
  final GlobalKey<ThemeTextInputState> keyPasswordInput = GlobalKey<ThemeTextInputState>();

  AnimationController _controller;

  bool _showPassword = false;
  bool loading = false;


  String _title;

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? null);
    String type = (prefs.getString('type') ?? null);
    Constants.USER_TOKEN = token;
    Constants.USER_TYPE=type;

    if(Constants.USER_TOKEN!=null&&type!=null){
      Future.delayed(Duration.zero).then((value){
        goHome(type);
      });
    }
  }

  checkUpdate()async{

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    String ref = 'android';
    if(Platform.isAndroid)
      ref='android';
    else
      ref='ios';
    FirebaseDatabase.instance.ref(ref).once().then((value){
      print('newest is ${value.snapshot.value}');
      print('current is ${buildNumber}');
      if(value==null)
        return;
      int newest = int.parse(value.snapshot.value.toString());

      if(newest>int.parse(buildNumber)){
        print('new update available');
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );

        /* UI.showCustomDialog(context,title: 'New version available',message: 'Please Update to the Latest Version', actions: [ElevatedButton(onPressed:(){

          if (Platform.isAndroid) {
            launch("https://play.google.com/store/apps/details?id=$packageName");
          } else if (Platform.isIOS) {
            launch("market://details?id=$packageName");
          }
        }, child: Text('Update'))]);*/
      }

    });

  }
  AlertDialog alert = AlertDialog(
    title: Text("New Version Available"),
    content: Text("Please Update to the Latest Version"),
    actions: [
      ElevatedButton(onPressed: ()async{
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        String packageName = packageInfo.packageName;

        if (Platform.isAndroid) {
          launch("https://play.google.com/store/apps/details?id=$packageName");
        } else if (Platform.isIOS) {
          launch("market://details?id=$packageName");
        }
      }, child: Text('Update')),
    ],
  );
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    checkUpdate();
    _textEmailController.text = '';
    _textPassController.text = '';

    _title = widget.title ?? '';

    Future.delayed(Duration.zero).then((value){
      try{
        final newVersion = NewVersion(context: context);

        newVersion.showAlertIfNecessary();

        print(newVersion.iOSId??'');

      }catch(e){}
    });

    checkToken();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
void goHome(String type) async{
  final status = await OneSignal.shared.getDeviceState();
  final String osUserID = status.userId;

  print('onesignal id $osUserID');
  if(osUserID!=null)
    LoginModel().sendPlayerID(osUserID);


  Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>type!='staff'?Home(): WorkerAppointmentsList()),
      );
    }
  void _validateForm() {
     //

    if (keyPasswordInput.currentState.validate() && keyEmailInput.currentState.validate()) {
      setState(() {
        loading=true;
      });
       LoginModel().loginUser(_textEmailController.text, _textPassController.text).then((value) async {
         setState(() {
           loading=false;
         });

         if(value==null||value.user==null){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid credentials')));
         }

          else {
           if(value.user.type=='customer'){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid credentials')));

             return;
           }
           SharedPreferences prefs = await SharedPreferences.getInstance();
           await prefs.setString('token',  value.accessToken);
           await prefs.setString('type',  value.user.type);
           Constants.USER_TYPE=value.user.type;
           goHome(value.user.type);
          Constants.USER_TOKEN = value.accessToken;
          }

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_title.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        _title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                        //style: Theme.of(context).textTheme.headline5.bold,
                      ),
                    )
                  else
                    Container(),
                  ThemeTextInput(
                    onSubmitted: (c){FocusScope.of(context).requestFocus(_focusPass);},
                    key: keyEmailInput,
                    controller: _textEmailController,
                    hintText: 'phone',
                    focusNode: _focusEmail,
                    keyboardType: TextInputType.phone,
                    icon: const Icon(Icons.clear),
                    textInputAction: TextInputAction.next,
                    onTapIcon: () async {
                      await Future<dynamic>.delayed(const Duration(milliseconds: 100));
                      _textEmailController.clear();
                    },
                    validator: (s){
                      if(s.length<9)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('enter valid number')));
                      return s.length<9?'enter valid number':null;
                    },

                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ThemeTextInput(
                    helpText: '',
                    key: keyPasswordInput,
                    hintText: 'password',
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String text) => _validateForm(),
                    onTapIcon: () => setState(() => _showPassword = !_showPassword),
                    obscureText: !_showPassword,
                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    controller: _textPassController,
                    focusNode: _focusPass,
                    validator: (s){
                      if(s.length<6)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('enter valid 6 chars')));

                      return s.length<6?'enter 6 chars':null;
                    },

                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  loading?CircularProgressIndicator():ThemeButton(
                    onPressed: _validateForm,
                    text: 'Login',
                    showLoading: false,
                    disableTouchWhenLoading: true,
                  ),

                ],
              ),
            ),
          ),
        ),

      ],
    ),);
  }


}

