import 'package:flutter/material.dart';
import 'package:swim_app/api/trainer_api.dart';
import 'package:swim_app/models/trainers.dart';
import 'package:swim_app/pages/trainer_data.dart';
import '../models/pools.dart';

class UserPage extends StatefulWidget {
  final Pool pool;

  const UserPage({
    Key? key,
    required this.pool,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBarController = TabController(length: 3, vsync: this);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Pool Details"),
      // ),
      body: Container(
        margin: EdgeInsets.only(top: 0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  widget.pool.mainimage,
                  //width: double.maxFinite,
                  //height: 350.0,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 20,
                    left: 10.0,
                    child: Text(
                      widget.pool.poolname,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(height: 15),
            TabBar(
                controller: _tabBarController,
                isScrollable: true,
                //labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
                labelColor: Colors.blue[900],
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
                indicatorColor: Colors.transparent,
                tabs: const [
                  Text("Trainers"),
                  Text("Photos"),
                  Text("Details")
                ]),
            Expanded(
              child: Container(
                  width: double.infinity,
                  //height: 200,
                  child: TabBarView(controller: _tabBarController, children: [
                    FutureBuilder<List<Trainer>>(
                      future: TrainerApi.getTrainers(),
                      builder: (context, snapshot) {
                        final trainers = snapshot.data;

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Some error occurred!'));
                            } else {
                              return trainerList(trainers!);
                            }
                        }
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 10),
                          itemCount: widget.pool.gallary.length,
                          itemBuilder: (context, index) =>
                              buildImageCard(widget.pool.gallary[index])),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: detailTab(widget.pool))
                  ])),
            )
          ],
        ),
      ),
    );
  }
}

Widget trainerList(List<Trainer> trainers) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: trainers.length,
      itemBuilder: (context, index) {
        final trainer = trainers[index];

        return ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TrainerPage(trainer: trainer),
          )),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(trainer.urlAvatar),
          ),
          title: Text(
            trainer.username,
            style: const TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(trainer.address),
          trailing: trainer.availability
              ? const Text(
                  "Available",
                  style: TextStyle(
                      color: Colors.greenAccent, fontWeight: FontWeight.w500),
                )
              : const Text("Not Available",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w500)),
        );
      },
    );

Widget buildImageCard(String img) => Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
Widget detailTab(Pool data) => ListView(
      children: [
        Container(child: Text(data.pooldetails)),
        const SizedBox(height: 20.0),
        const Text(
          "Address",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Container(
              child: Text(data.pooladdress),
            ),
            Container(
              child: Text(""),
            )
          ],
        ),
        const SizedBox(height: 20.0),
        const Text("Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
