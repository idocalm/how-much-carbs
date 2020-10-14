import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context){
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
      home: HomePage(title: 'פחמי-כמה?'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

 
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
 
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  
  void signOut(){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => signOut(),
          
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
            child: Text("HOME", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50)),
            )
          ],
        ),
      );
  }
}

  

