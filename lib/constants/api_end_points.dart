// const String baseURL = 'http://192.168.1.227:8080/api/';
const String baseURL = 'http://localhost:8080/api/';
// const String baseURL = 'https://api.homesahulat.stepwaysoftwares.com/api/';

String signUpUrl = '${baseURL}signup';
String loginUrl = '${baseURL}login';
String getLoggedInUserUrl = '${baseURL}user/logged-in';

String getOtpVerificationUrl(String id, String otp) {
  return '${baseURL}signup/user/$id/otp-verification/$otp';
}

String resendOtpUrl(String id) {
  return '${baseURL}signup/resend-otp/user/$id';
}

String getAllServiceProvidersByServiceUrl(String service) {
  return '${baseURL}service-provider/service/$service';
}
