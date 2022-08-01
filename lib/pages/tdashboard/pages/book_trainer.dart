import 'package:flutter/material.dart';
import 'package:swim_app/models/trainer_booking.dart';

class BookTrainer extends StatefulWidget {
  final TrainerBook trainee;
  const BookTrainer({Key? key, required this.trainee}) : super(key: key);

  @override
  State<BookTrainer> createState() => _BookTrainerState();
}

class _BookTrainerState extends State<BookTrainer> {
  @override
  Widget build(BuildContext context) {
    const List monthsName = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Trainee Details"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        widget.trainee.traineeImg,
                        width: screenWidth * 0.25,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.trainee.traineeName,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      widget.trainee.status == 1
                          ? const Text(
                              "Accept",
                              style: TextStyle(
                                  backgroundColor: Colors.greenAccent,
                                  color: Colors.white),
                            )
                          : const Text(
                              "Reject",
                              style: TextStyle(
                                  backgroundColor: Colors.redAccent,
                                  color: Colors.white),
                            ),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Text('${monthsName[widget.trainee.date.month]}-' +
                        widget.trainee.date.month.toString().padLeft(2, '0')),
                    Text(
                      widget.trainee.time,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    )
                  ],
                )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            padding: const EdgeInsets.only(top: 10.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Pool",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: Text(widget.trainee.poolName),
                  trailing: const Icon(Icons.water),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const ListTile(
                  title: Text(
                    "Mobile No",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: Text("076 4562781"),
                  trailing: Icon(Icons.mobile_friendly),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const ListTile(
                  title: Text(
                    "Lesson",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: Text("20 Day Speed Workout"),
                  trailing: Icon(Icons.book),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: Colors.greenAccent)),
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.all(20),
                  textStyle: const TextStyle(fontSize: 24),
                ),
                onPressed: () {},
                child: const Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: Colors.redAccent)),
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.all(20),
                  textStyle: const TextStyle(fontSize: 24),
                ),
                onPressed: () {},
                child: const Text(
                  'Reject',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
