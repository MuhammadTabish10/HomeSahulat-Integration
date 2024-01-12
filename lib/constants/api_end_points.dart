const String baseURL = 'http://192.168.0.105:8080/api/';
// const String baseURL = 'http://localhost:8080/api/';
// const String baseURL = 'https://api.homesahulat.stepwaysoftwares.com/api/';

String signUpUrl = '${baseURL}signup';
String loginUrl = '${baseURL}login';
String getLoggedInUserUrl = '${baseURL}user/logged-in';
String bookUrl = '${baseURL}booking';
String createServiceProviderUrl = '${baseURL}service-provider';
String addLocationUrl = '${baseURL}location';
String getBookingsByLoggedInUserUrl = '${baseURL}booking/by-logged-in-user';

String updateBookingStatusUrl(int id, String status){
    return '${baseURL}booking/$id/status/$status';
}

String getAllBookingsByServiceProviderIdUrl(int id) {
  return '${baseURL}booking/serviceProvider/$id';
}

String uploadCnicImageUrl(int id) {
  return '${baseURL}service-provider/$id/upload';
}

String getServiceByNameUrl(String name) {
  return '${baseURL}service/name/$name';
}

String updateLocationUrl(int id) {
  return '${baseURL}location/$id';
}

String verifyServiceProviderUrl(int id) {
  return '${baseURL}service-provider/user/$id/check-verify';
}

String updateUserUrl(int id) {
  return '${baseURL}user/$id';
}

String getServiceProviderByUserIdUrl(int id) {
  return '${baseURL}service-provider/user/$id';
}

String getAllReviewsByServiceProviderIdUrl(int id) {
  return '${baseURL}review/service-provider/$id';
}

String getOtpVerificationUrl(String id, String otp) {
  return '${baseURL}signup/user/$id/otp-verification/$otp';
}

String resendOtpUrl(String id) {
  return '${baseURL}signup/resend-otp/user/$id';
}

String getAllServiceProvidersByServiceUrl(String service) {
  return '${baseURL}service-provider/service/$service';
}

String forgotPasswordUrl(String email) {
  return '${baseURL}user/forgot-password?email=$email';
}

String resetPasswordUrl(String email, String resetCode, String newPassword) {
  return '${baseURL}user/reset-password?email=$email&resetCode=$resetCode&newPassword=$newPassword';
}
