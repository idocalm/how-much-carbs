import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:how_much_carbs_proj/home.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

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
      home: MyHomePage(title: 'פחמי-כמה?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

 
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  Future<void> submitData() async
  {
    try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
  } 
  on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }else if(e == null)
  {
  Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => Home()),                
          );
  }       
} catch (e) {
  print(e);
}
  }

  @override
  Widget build(BuildContext context) {


    FirebaseAuth.instance
    .authStateChanges()
    .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => HomePage(),),                
          );
          }
          

      }
    );
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
            
          ],
        ),
      );
  }
}
