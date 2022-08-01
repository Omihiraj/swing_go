import 'package:flutter/material.dart';

class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Upcomming Lessons",
            style: TextStyle(fontSize: 22),
          ),
        ),
        lessonItem(
            "https://images.unsplash.com/photo-1623718649591-311775a30c43?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            "20 Day Speed Workout",
            "0/40 Hours"),
        lessonItem(
            "https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            "30 Day Speed Workout",
            "0/40 Hours"),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Completed Lessons",
            style: TextStyle(fontSize: 22),
          ),
        ),
        lessonItem(
            "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            "Free Style Technique",
            "40/40 Hours"),
        lessonItem(
            "https://images.unsplash.com/photo-1575429198097-0414ec08e8cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            "10 Day Speed Workout",
            "40/40 Hours"),
      ]),
    );
  }
}

Widget lessonItem(String img, String txt1, String txt2) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:
                Image.network(img, width: 100, height: 100, fit: BoxFit.cover)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt1,
              style: const TextStyle(fontSize: 20),
            ),
            Text(txt2),
          ],
        ),
        const Icon(Icons.play_circle_outline_sharp)
      ],
    ),
  );
}
