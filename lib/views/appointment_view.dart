// import 'package:flutter/material.dart';
// import 'package:homesahulat_fyp/models/booking.dart';


// class AppointmentScreen extends StatelessWidget {
//   final List<?> confirmedAppointments;
//   final List<Appointment> pendingAppointments;
//   final List<Appointment> rejectedAppointments;

//   AppointmentScreen({
//     required this.confirmedAppointments,
//     required this.pendingAppointments,
//     required this.rejectedAppointments,
//   });

//  @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Appointments'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildSection('Confirmed Appointments', confirmedAppointments),
//                 _buildSection('Pending Appointments', pendingAppointments),
//                 _buildSection('Rejected Appointments', rejectedAppointments),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, List<Booking> bookings) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         bookings.isEmpty
//             ? const Text('No appointments in this category.')
//             : Column(
//                 children: bookings
//                     .map((booking) => _buildAppointmentCard(booking))
//                     .toList(),
//               ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildAppointmentCard(Booking booking) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text("Hello"),
//         subtitle: Text('Date: ${_formatDateTime(booking.appointmentDate)}'),
//         trailing: _buildStatusChip(booking.bookingStatus),
//       ),
//     );
//   }

//   Widget _buildStatusChip(String? status) {
//     Color chipColor;
//     switch (status) {
//       case 'Confirmed':
//         chipColor = Colors.green;
//         break;
//       case 'Pending':
//         chipColor = Colors.orange;
//         break;
//       case 'Rejected':
//         chipColor = Colors.red;
//         break;
//       default:
//         chipColor = Colors.grey;
//     }

//     return Chip(
//       backgroundColor: chipColor,
//       label: Text(
//         status!,
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   String _formatDateTime(DateTime dateTime) {
//     // You can format the DateTime object as per your requirement
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//   }
// }