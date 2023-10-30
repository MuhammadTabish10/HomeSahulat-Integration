import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/utilities/show_logout_dialog.dart';
import 'package:homesahulat_fyp/widget/build_button.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Text('Home'),
    const Text('Search'),
    const Text('Profile'),
    const Text('Request'),
    const Text("FAQ's"),
    const Text('Settings'),
    const Text('Logout'),
  ];

  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=869&q=80',
    'https://media.istockphoto.com/id/178126106/photo/hot-water-heater-service.jpg?s=612x612&w=0&k=20&c=dQDPH9tY01tOfw8Fts22QoiCaevnMpekRlktgsPgZ_E=',
    'https://plus.unsplash.com/premium_photo-1663091069400-7f298d3f60a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_selectedIndex == 0) {
      // Show CarouselSlider on Home screen
      body = SingleChildScrollView(
        child: Column(children: [
          CarouselSlider(
            items: _imageUrls.map((url) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'What are you looking for?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const ListTile(
                title: Text(
                  'Services',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Please Select Service of your choice',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                tileColor: Colors.transparent,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  buildButton(Icons.build, 'Carpenter', () {
                    // Handle Carpenter button press
                    Navigator.pushNamed(context, serviceProviderRoute);
                  }),
                  buildButton(Icons.plumbing, 'Plumber', () {
                    // Handle Plumber button press
                    Navigator.pushNamed(context, serviceProviderRoute);
                  }),
                  buildButton(Icons.electrical_services_rounded, 'Electritian', () {
                    // Handle Electritian button press
                    Navigator.pushNamed(context, serviceProviderRoute);
                  }),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ]),
      );
    } else {
      // Don't show CarouselSlider on any other screen
      body = _widgetOptions.elementAt(_selectedIndex);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeSahulat'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16.0),
        //     width: 36.0,
        //     height: 36.0,
        //     decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       image: DecorationImage(
        //         image: NetworkImage(
        //             'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
        //         fit: BoxFit.fill,
        //       ),
        //     ),
        //   ),
        // ],
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              // showSearch(
                  // context: context,
                  // delegate to customize the search bar
                  // delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.request_page_rounded),
              title: const Text('Request'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.adf_scanner_rounded),
              title: const Text("FAQ's"),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedIndex == 5,
              onTap: () {
                _onItemTapped(5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              selected: _selectedIndex == 6,
              onTap: () async {
                _onItemTapped(6);
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  // await AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}