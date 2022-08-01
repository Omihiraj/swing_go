import 'package:flutter/material.dart';
import 'package:swim_app/api/trainer_booking_api.dart';
import 'package:swim_app/models/trainer_booking.dart';
import 'package:swim_app/pages/tdashboard/pages/book_trainer.dart';
import 'package:swim_app/pages/tdashboard/views/appoiment.dart';

class TrainerMainPage extends StatefulWidget {
  const TrainerMainPage({Key? key}) : super(key: key);

  @override
  State<TrainerMainPage> createState() => _TrainerMainPageState();
}

class _TrainerMainPageState extends State<TrainerMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "https://images.unsplash.com/photo-1620750554453-7a11c1b5adc6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Mr Robet James",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Deep Trainer",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Appointments",
                  style: TextStyle(fontSize: 20.0),
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Appoiment(),
                        )),
                    child: const Text(
                      "See All",
                      style: TextStyle(fontSize: 16.0),
                    ))
              ],
            ),
          ),
          Container(
            height: 500,
            width: double.infinity,
            child: FutureBuilder<List<TrainerBook>>(
                future: TrainerBookApi.getBooking(1),
                builder: (context, snapshot) {
                  final bookItem = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Some error occurred!'));
                      } else {
                        return bookingItem(bookItem!);
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}

Widget bookingItem(List<TrainerBook> items) {
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
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => BookTrainer(
              trainee: item,
            ),
          )),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(item.traineeImg,
                          width: 100, height: 100, fit: BoxFit.cover)),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.traineeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    item.status == 1
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
                          )
                  ],
                )),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Text('${monthsName[item.date.month]}-' +
                        item.date.day.toString().padLeft(2, '0')),
                    Text(
                      item.time,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    )
                  ],
                )),
              ],
            ),
          ),
        );
      });
}
