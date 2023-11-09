// const String baseURL = 'http://192.168.1.227:8080/api/';
const String baseURL = 'http://localhost:8080/api/';

String signUp = '${baseURL}signup';

String getOtpVerificationUrl(String id, String otp) {
  return '${baseURL}signup/user/$id/otp-verification/$otp';
}

String resendOtpUrl(String id) {
  return '${baseURL}signup/resend-otp/user/$id';
}
