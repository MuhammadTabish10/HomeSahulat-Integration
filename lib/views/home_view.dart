import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/utilities/show_logout_dialog.dart';
import 'package:homesahulat_fyp/widget/build_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late String token;

  final List<Widget> _widgetOptions = const <Widget>[
    Text('Home'),
    Text('Search'),
    Text('Profile'),
    Text('Request'),
    Text("FAQ's"),
    Text('Settings'),
    Text('Logout'),
  ];

  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=869&q=80',
    'https://media.istockphoto.com/id/178126106/photo/hot-water-heater-service.jpg?s=612x612&w=0&k=20&c=dQDPH9tY01tOfw8Fts22QoiCaevnMpekRlktgsPgZ_E=',
    'https://plus.unsplash.com/premium_photo-1663091069400-7f298d3f60a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    token = args?['token'] ?? '';

    Widget body;
    if (_selectedIndex == 0) {
      body = _buildHomeScreen();
    } else {
      body = _widgetOptions.elementAt(_selectedIndex);
    }

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: body,
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                navigateToServiceProviderView('Carpenter');
              }),
              buildButton(Icons.plumbing, 'Plumber', () {
                navigateToServiceProviderView('Plumber');
              }),
              buildButton(Icons.electrical_services_rounded, 'Electrician', () {
                navigateToServiceProviderView('Electrician');
              }),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
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
          _buildDrawerItem(0, Icons.home, 'Home'),
          _buildDrawerItem(1, Icons.search, 'Search'),
          _buildDrawerItem(2, Icons.person, 'Profile'),
          _buildDrawerItem(3, Icons.request_page_rounded, 'Request'),
          _buildDrawerItem(4, Icons.adf_scanner_rounded, "FAQ's"),
          _buildDrawerItem(5, Icons.settings, 'Settings'),
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
    );
  }

  ListTile _buildDrawerItem(int index, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }

  void navigateToServiceProviderView(String serviceName) {
    Navigator.of(context).pushNamed(
      serviceProviderRoute,
      arguments: {'token': token, 'serviceName': serviceName},
    );
  }
}
