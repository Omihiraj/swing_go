import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swim_app/models/trainers.dart';
import 'package:swim_app/pages/auth_page.dart';
import 'package:swim_app/pages/book_now.dart';
import 'package:swim_app/pages/sign_in.dart';

class TrainerPage extends StatefulWidget {
  final Trainer trainer;
  const TrainerPage({
    Key? key,
    required this.trainer,
  }) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Trainer Detail"),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(widget.trainer.urlAvatar,
                      width: 100.0, height: 100.0, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  left: 120,
                  child: Text(
                    widget.trainer.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Positioned(
                    top: 35,
                    left: 120,
                    child: widget.trainer.availability
                        ? Text(
                            "Available Now",
                            style: TextStyle(color: Colors.green[600]),
                          )
                        : const Text("Not Available",
                            style: TextStyle(color: Colors.redAccent)))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(widget.trainer.phonenumber),
                  trailing: Icon(Icons.mobile_friendly),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  title:
                      const Text("Address", style: TextStyle(fontSize: 18.0)),
                  subtitle: Text(widget.trainer.address),
                  trailing: const Icon(Icons.map),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const ListTile(
                    title:
                        Text("Working Time", style: TextStyle(fontSize: 18.0)),
                    subtitle: Text("09.00 A.M - 02.00 P.M"),
                    trailing: Icon(Icons.watch)),
                const SizedBox(
                  height: 10.0,
                ),
                ListTile(
                    title:
                        const Text("Price", style: TextStyle(fontSize: 18.0)),
                    subtitle: Text('USD ' + widget.trainer.price),
                    trailing: const Icon(Icons.money))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w500),
                elevation: 5.0,
                minimumSize: const Size(200, 50),
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         BookNow(trainerId: widget.trainer.id))),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return BookNow(
                              trainerId: widget.trainer.id,
                              traineeId: snapshot.data!.email,
                            );
                          } else {
                            return const AuthPage();
                          }
                        },
                      ))),
              child: const Text("Book Now"),
            ),
          )
        ],
      ),
    );
  }
}
