// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:homesahulat_fyp/config/token_provider.dart';
// import 'package:homesahulat_fyp/constants/routes.dart';
// import 'package:homesahulat_fyp/models/user.dart';
// import 'package:homesahulat_fyp/utilities/show_logout_dialog.dart';
// import 'package:homesahulat_fyp/views/user_profile_view.dart';
// import 'package:homesahulat_fyp/widget/build_button.dart';
// import 'dart:convert';
// import 'package:homesahulat_fyp/constants/api_end_points.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _selectedIndex = 0;
//   late User user = User(name: '', password: '', phone: '');
//   late String token;
//   bool isMounted = false;
//   late List<Widget> _widgetOptions;

//   final List<String> _imageUrls = [
//     'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=869&q=80',
//     'https://media.istockphoto.com/id/178126106/photo/hot-water-heater-service.jpg?s=612x612&w=0&k=20&c=dQDPH9tY01tOfw8Fts22QoiCaevnMpekRlktgsPgZ_E=',
//     'https://plus.unsplash.com/premium_photo-1663091069400-7f298d3f60a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     token = Provider.of<TokenProvider>(context, listen: false).token;
//     isMounted = true;
//   }

//   @override
//   void dispose() {
//     isMounted = false;
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Move the initialization of _widgetOptions here
//     _widgetOptions = <Widget>[
//       buildHomeScreen(),
//       const Text('Search'),
//       const UserProfileView(), // Profile screen directly embedded
//       const Text('Request'),
//       const Text("FAQ's"),
//       const Text('Settings'),
//       const Text('Logout'),
//     ];

//     // Load data or perform other tasks if needed
//     loadData();
//   }

//   Future<void> loadData() async {
//     try {
//       final loggedInUser = await getUser(token);
//       if (isMounted) {
//         setState(() {
//           user = loggedInUser;
//         });
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   Future<User> getUser(String token) async {
//     String apiUrl = getLoggedInUserUrl;
//     final Uri uri = Uri.parse(apiUrl);

//     try {
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> userData = json.decode(response.body);
//         User user = User.fromJson(userData);
//         return user;
//       } else {
//         print('Failed to load logged in user: ${response.statusCode}');
//         return user;
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       return user;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       drawer: _buildDrawer(),
//       body: Container(
//         decoration: const BoxDecoration(
//           // Add a background image to the container
//           image: DecorationImage(
//             image: AssetImage('lib/assets/images/design.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: _widgetOptions[_selectedIndex],
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Text('HomeSahulat'),
//       leading: Builder(
//         builder: (BuildContext context) {
//           return IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           );
//         },
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             // method to show the search bar
//             // showSearch(
//             // context: context,
//             // delegate to customize the search bar
//             // delegate: CustomSearchDelegate());
//           },
//           icon: const Icon(Icons.search),
//         )
//       ],
//     );
//   }

//   Widget buildHomeScreen() {
//     return Container(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             CarouselSlider(
//               items: _imageUrls.map((url) {
//                 return SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: ClipRRect(
//                     child: Image.network(
//                       url,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 height: 200,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 viewportFraction: 1.0,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'What are you looking for?',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const ListTile(
//               title: Text(
//                 'Services',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 'Please Select Service of your choice',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//               contentPadding: EdgeInsets.symmetric(horizontal: 16),
//               tileColor: Colors.transparent,
//             ),
//             const SizedBox(height: 16),
//             Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//                 buildButton(Icons.build, 'Carpenter', () {
//                   navigateToServiceProviderView('Carpenter');
//                 }),
//                 buildButton(Icons.plumbing, 'Plumber', () {
//                   navigateToServiceProviderView('Plumber');
//                 }),
//                 buildButton(Icons.electrical_services_rounded, 'Electrician',
//                     () {
//                   navigateToServiceProviderView('Electrician');
//                 }),
//               ],
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Drawer _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text(user.name),
//             accountEmail: Text(user.email ?? ''),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//             ),
//           ),
//           _buildDrawerItem(0, Icons.home, 'Home'),
//           _buildDrawerItem(1, Icons.search, 'Search'),
//           _buildDrawerItem(2, Icons.person, 'Profile'),
//           _buildDrawerItem(3, Icons.request_page_rounded, 'Request'),
//           _buildDrawerItem(4, Icons.adf_scanner_rounded, "FAQ's"),
//           _buildDrawerItem(5, Icons.settings, 'Settings'),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             selected: _selectedIndex == 6,
//             onTap: () async {
//               _onItemTapped(6);
//               final shouldLogout = await showLogOutDialog(context);
//               if (shouldLogout) {
//                 Navigator.of(context)
//                     .pushNamedAndRemoveUntil(loginRoute, (_) => false);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void navigateToServiceProviderView(String serviceName) {
//     Navigator.of(context).pushNamed(
//       serviceProviderRoute,
//       arguments: {'serviceName': serviceName},
//     );
//   }

//   ListTile _buildDrawerItem(int index, IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       selected: _selectedIndex == index,
//       onTap: () {
//         _onItemTapped(index);
//         Navigator.pop(context);
//       },
//     );
//   }
// }

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/utilities/show_logout_dialog.dart';
import 'package:homesahulat_fyp/views/become_service_provider_view.dart';
import 'package:homesahulat_fyp/views/user_profile_view.dart';
import 'package:homesahulat_fyp/widget/build_button.dart';
import 'dart:convert';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late User user = User(name: '', password: '', phone: '', email: '');
  late String token;
  bool isMounted = false;
  late List<Widget> _widgetOptions;

  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=869&q=80',
    'https://media.istockphoto.com/id/178126106/photo/hot-water-heater-service.jpg?s=612x612&w=0&k=20&c=dQDPH9tY01tOfw8Fts22QoiCaevnMpekRlktgsPgZ_E=',
    'https://plus.unsplash.com/premium_photo-1663091069400-7f298d3f60a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  ];

  @override
  void initState() {
    super.initState();
    token = Provider.of<TokenProvider>(context, listen: false).token;
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Move the initialization of _widgetOptions here
    _widgetOptions = <Widget>[
      buildHomeScreen(),
      const Text('Search'),
      const UserProfileView(), // Profile screen directly embedded
      const BecomeServiceProviderView(),
      const Text("FAQ's"),
      const Text('Settings'),
      const Text('Logout'),
    ];

    // Load data or perform other tasks if needed
    loadData();
  }

  Future<void> loadData() async {
    try {
      final loggedInUser = await getUser(token);
      if (isMounted) {
        setState(() {
          user = loggedInUser;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<User> getUser(String token) async {
    String apiUrl = getLoggedInUserUrl;
    final Uri uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        User user = User.fromJson(userData);
        return user;
      } else {
        print('Failed to load logged in user: ${response.statusCode}');
        return user;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          // Add a background image to the container
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _widgetOptions[_selectedIndex],
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

  Widget buildHomeScreen() {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: _imageUrls.map((url) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
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
              viewportFraction:
                  1.0, // Set to 1.0 to cover the entire screen width
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

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          _buildDrawerItem(0, Icons.home, 'Home'),
          _buildDrawerItem(1, Icons.search, 'Search'),
          _buildDrawerItem(2, Icons.person, 'Profile'),
          _buildDrawerItem(3, Icons.person_add, 'Become Service Provider'),
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
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }

  void navigateToServiceProviderView(String serviceName) {
    Navigator.of(context).pushNamed(
      serviceProviderRoute,
      arguments: {'serviceName': serviceName},
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
}
