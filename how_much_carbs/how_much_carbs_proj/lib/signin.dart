import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:how_much_carbs_proj/main.dart';

class SignIn extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("he","IL")
      ],
      locale: Locale("he","IL"),
      debugShowCheckedModeBanner: false,
      title: 'פחמי-כמה?',
      theme: ThemeData(fontFamily: 'Assistant'),
      home: SignInPage(title: 'פחמי-כמה?'),
    );
  }
}

class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);

 
  final String title;

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
 
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  Future<void> submitData() async
  {
   try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
} 
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title,),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(  
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: emailController,
              decoration: new InputDecoration(
                hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                suffixIcon: Icon(Icons.account_circle_sharp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5),
                hintText: 'אימייל'
            ),
            ),
            ),
            Padding(  
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: passwordController,
              decoration: new InputDecoration(
                hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                suffixIcon: Icon(Icons.account_circle_sharp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5),
                hintText: 'סיסמא'
            ),
            ),
            ),
            Padding(  
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {submitData();},
              child: const Text(
                "שלח",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)
              ),
            ),
                ),
            Padding(  
            padding: const EdgeInsets.all(10.0),
            child: InkWell(onTap: (){
               Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => MyApp()),                
               );
            },
             child: Text("עוד אין לך חשבון?"),
           ),
            ),
          ],
        ),
      );
  }
}
