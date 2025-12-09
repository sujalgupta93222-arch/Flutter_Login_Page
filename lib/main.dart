import 'package:flutter/material.dart';
import 'package:loginpage/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginPage',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isloding = true;
  String name ="";

  final TextEditingController UserName = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  bool login1 = false;
  void login() async{
    setState(() {
      login1=true;
    });
  

  String user = UserName.text.trim();
  String email = emailController.text.trim();
  String pass = passwordController.text.trim();

  // Email or password empty check
  if (email.isEmpty || pass.isEmpty || user.isEmpty) {
    setState(() {
      login1 = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("UserName ,Email & Password cannot be empty")),
    );
    return;
  }

  // Email format check
  bool emailValid = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
  ).hasMatch(email);

  if (!emailValid) {
    setState(() {
      login1 = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a valid email address")),
    );
    return;
  }

  // Password length check (Minimum 6)
  if (pass.length < 6) {
    setState(() {
      login1 = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password must be at least 6 characters")),
    );
    return;
  }
   await Future.delayed(Duration(seconds: 3));

  setState(() {
    login1 = false;
      }); // hide loader before navigation
  
  // All good → next page
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );

  UserName.clear();
  emailController.clear();
  passwordController.clear();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // BIG CENTER HEADING
                Text(
                  "LOGIN PAGE",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 35),
                Text('Welocme $name',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(
                  height: 20,
                ),

                Icon(Icons.lock, size: 90, color: Colors.black87),
                SizedBox(height: 30),
                //USERNAME
                TextField(
                  controller: UserName,
                  decoration: InputDecoration(
                    labelText: "UserName",
                    prefixIcon: Icon(Icons.person),
                    hint: Text('Enter Your Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                // EMAIL
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    hint: Text('Enter Your Email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 20),

                // PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: _isloding,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hint: Text('Enter Your Password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffix: IconButton(
                     icon: Icon(
                      _isloding ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isloding = !_isloding;
                });
              },
                    ),
              
              
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 30),

                // LOGIN BUTTON
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: login1
      ? CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.black,
        )
      : Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

