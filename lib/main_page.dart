import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim_app/models/bookings.dart';
import 'package:swim_app/pages/pool_data.dart';
import 'api/pool_api.dart';
import 'api/booking_api.dart';
import 'models/bookings.dart';
import 'models/pools.dart';
import 'package:geolocator/geolocator.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  var messagePosition;
  bool locationAccept = false;
  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    var msg;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationAccept = false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationAccept = false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationAccept = false;
    }
    msg = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    setState(() {
      locationAccept = true;
      messagePosition = msg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  final urlImages = [
    'https://images.unsplash.com/photo-1572331165267-854da2b10ccc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1575429198097-0414ec08e8cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1505847610351-22b86a1afd66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1600965962102-9d260a71890d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1530549387789-4c1017266635?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(messagePosition);
    //position == false ? print("Correct") : print("Incorrect");
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              }),
        ),
        const SizedBox(height: 20.0),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
          labelColor: Colors.blue[900],
          unselectedLabelColor: Colors.grey,
          labelStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          indicatorColor: Colors.transparent,
          tabs: [
            const Text("Bookings"),
            locationAccept ? const Text("Near By") : const Text("Hotel Pools")
          ],
        ),
        Container(
          width: 100.0,
          height: 500.0,
          child: TabBarView(
            controller: _tabController,
            children: [
              FutureBuilder<List<Booking>>(
                future: BookingApi.getBookingsLocally(context),
                builder: (context, snapshot) {
                  final bookings = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Some error occurred!'));
                      } else {
                        return bookingList(bookings!);
                      }
                  }
                },
              ),
              FutureBuilder<List<Pool>>(
                future: locationAccept
                    ? PoolApi.getPools()
                    : PoolApi.getUsersLocally(context),
                builder: (context, snapshot) {
                  final pools = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Some error occurred!'));
                      } else {
                        return poolList(pools!, screenWidth);
                      }
                  }
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget poolList(List<Pool> pools, double screenWidth) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: pools.length,
      itemBuilder: (context, index) {
        final pool = pools[index];

        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => UserPage(pool: pool),
          )),
          child: Container(
            width: double.infinity,
            height: 100.0,
            margin: EdgeInsets.only(
                bottom: 20.0,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.5,
                  child: Stack(children: [
                    Positioned(
                      left: 8,
                      top: 10,
                      child: Text(
                        pool.poolname,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 35,
                      child: Text(
                        pool.pooladdress,
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    )
                  ]),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    pool.mainimage,
                    height: 100.0,
                    width: screenWidth * 0.35,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bookingList(List<Booking> bookings) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final book = bookings[index];
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.date!,
                    style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                  Text(book.time!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14)),
                  Text(
                    '${book.participents} Participants',
                    style: const TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Swimming Pool",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  Text("Trainer",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(book.pool!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                  Text(book.trainer!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                ],
              ),
            ],
          ),
        );
      });
}
