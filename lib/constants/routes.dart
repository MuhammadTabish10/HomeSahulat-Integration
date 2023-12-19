import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/views/booking_confirmed_view.dart';
import 'package:homesahulat_fyp/views/booking_view.dart';
import 'package:homesahulat_fyp/views/chat_view.dart';
import 'package:homesahulat_fyp/views/forgot_password_view.dart';
import 'package:homesahulat_fyp/views/login_view.dart';
import 'package:homesahulat_fyp/views/otp_verification_view.dart';
import 'package:homesahulat_fyp/views/register_view.dart';
import 'package:homesahulat_fyp/views/home_view.dart';
import 'package:homesahulat_fyp/views/service_provider_profile.dart';
import 'package:homesahulat_fyp/views/service_provider_view.dart';
import 'package:homesahulat_fyp/views/user_profile_view.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
const String homeRoute = '/home';
const String emailVerifyRoute = '/verifyEmail';
const String serviceProviderRoute = '/serviceProvider';
const String bookingRoute = '/booking';
const String bookingConfirmedRoute = '/bookingConfirmed';
const String chatRoute = '/chat';
const String serviceProviderProfileRoute = '/serviceProviderProfile';
const String otpVerificationRoute = '/otpVerification';
const String userProfileRoute = '/userProfile';
const String forgotPasswordRoute = '/forgotPassword';

final Map<String, WidgetBuilder> routes = {
  loginRoute: (context) => const LoginView(),
  registerRoute: (context) => const RegisterView(),
  homeRoute: (context) => const HomeView(),
  serviceProviderRoute: (context) => const ServiceProviderView(),
  serviceProviderProfileRoute: (context) => const ServiceProviderProfileView(),
  chatRoute: (context) => const ChatView(),
  bookingRoute: (context) => const BookingView(),
  bookingConfirmedRoute: (context) => const BookingConfirmedView(),
  otpVerificationRoute: (context) => const OTPVerificationScreen(),
  userProfileRoute: (context) => const UserProfileView(),
  forgotPasswordRoute: (context) => ForgotPasswordScreen(),
};
