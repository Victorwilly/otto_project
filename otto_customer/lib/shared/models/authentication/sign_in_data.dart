class SignInData {
  String email, password;

  SignInData({this.email = "", this.password = ""});
}

class SignUpData {
  final String fName, lName, mName, tel, email, password;

  SignUpData(
      {this.email = "",
      this.lName = "",
      this.tel = "",
      this.fName = "",
      this.password = "",
      this.mName = ""});
}

class ForgotPasswordData {
  final String email;

  ForgotPasswordData({
    this.email = "",
  });
}

class OtpData {
  final String otp;
  final String email;

  OtpData({this.otp = "", this.email = ""});
}

class ResetPasswordData {
  final String email, otp;

  ResetPasswordData({this.otp = "", this.email = ""});
}
