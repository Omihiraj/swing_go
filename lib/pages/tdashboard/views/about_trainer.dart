import 'package:flutter/material.dart';

class AboutTrainer extends StatefulWidget {
  const AboutTrainer({Key? key}) : super(key: key);

  @override
  State<AboutTrainer> createState() => _AboutTrainerState();
}

class _AboutTrainerState extends State<AboutTrainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(400),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1620750554453-7a11c1b5adc6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: TextEditingController(text: "Robet James"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: TextEditingController(text: "robotjames@gmail.com"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: TextEditingController(text: "076 389 7465"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile No',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: TextEditingController(text: "Deep Swimmer"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Trainer Type',
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //           side: const BorderSide(color: Colors.lightBlueAccent)),
            //       backgroundColor: Colors.lightBlueAccent,
            //       padding: const EdgeInsets.symmetric(vertical: 20),
            //       textStyle: const TextStyle(fontSize: 24),
            //     ),
            //     onPressed: () {},
            //     child: const Text(
            //       'Login',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
