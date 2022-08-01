import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isPassVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     "Sign In",
      //     style: TextStyle(fontSize: 28),
      //   ),
      //   centerTitle: true,
      //   bottom: const PreferredSize(
      //       child: SizedBox(), preferredSize: Size.fromHeight(10)),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(25.0),
      //         bottomRight: Radius.circular(25.0)),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Lottie.asset('assets/sign_in.json')),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                border: OutlineInputBorder(),
                label: Text("Email"),
                hintText: "swingo@mail.com"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                border: const OutlineInputBorder(),
                label: const Text("Pasword"),
                suffixIcon: IconButton(
                  icon: isPassVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPassVisible = !isPassVisible;
                    });
                  },
                )),
            obscureText: isPassVisible,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              elevation: 5.0,
              minimumSize: const Size(200, 50),
              onPrimary: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            onPressed: SignUpFire,
            child: const Text("SignUp"),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'SignIn',
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }

  Future SignUpFire() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
