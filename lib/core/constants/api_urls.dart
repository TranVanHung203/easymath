class AuthApiUrls {
  AuthApiUrls._();

  static const String login = '/auth/login'; //
  static const String signup = '/auth/register';
  static const String sendEmail = '/auth/resend-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/update-password';
  static const String resendOtp = '/auth/resend-otp';
  static const String verificationOtp = '/auth/verify-otp'; //
  static const String checkEmailPhone = '/auth/check-email-phone';
  static const String getAuth = '/auth/get-user/';
  static const String refresh = '/auth/refresh-token';
}

class RoadmapApiUrls {
  RoadmapApiUrls._();
  static const String getRoadmaps = '/chapters';
}

class VideoApiUrls {
  VideoApiUrls._();
  static const String getVideo = '/videos';
}

class ActivitiesApiUrls {
  ActivitiesApiUrls._();
  static const String postActivities = '/activities';
}

class ProgressApiUrls {
  ProgressApiUrls._();
  static const String getProgress = '/progress';
}
