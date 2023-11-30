import 'package:flutter/material.dart';
import 'package:miniproject/pages/article.dart';
import 'package:miniproject/pages/register.dart';
import 'package:miniproject/provider/authprovider.dart';
import 'package:miniproject/style.dart';
import 'package:miniproject/widget/custombutton.dart';
import 'package:miniproject/widget/custometextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _obscure = true;
  late AuthProvider authProvider;

  @override
  void initState() {
    authProvider = AuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(60),
            width: double.infinity,
            height: 222,
            decoration: ShapeDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/banner.jpg"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(113, 157, 223, 0.7), BlendMode.srcATop)),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
          Column(
            children: [
              Text('Selamat Datang', style: Styles.text32),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: [
                  CustomTextField(
                    label: "Email",
                    controller: _email,
                    hint: "Masukkan Email",
                  ),
                  CustomTextField(
                    label: "Password",
                    controller: _password,
                    hint: "Masukkan Password",
                    obscureText: _obscure,
                    sufficIcon: IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Styles.lightgrey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  )
                ]),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      label: 'Masuk',
                      onPressed: () {
                        print(_email.text);
                        onLogin(context);
                      },
                    ),
                    Text(
                      "Belum punya akun Metrodata Academy?",
                      style: Styles.text10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Daftar Sekarang!",
                        style: Styles.linktext10,
                      ),
                    )
                  ]))
        ],
      ),
    );
  }

  onLogin(BuildContext context) async {
    dynamic result = await authProvider.login(_email.text, _password.text);
    if (result != null && result["message"] == "Success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ArticlePage()));
    } else if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result["message"]),
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error!"),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
