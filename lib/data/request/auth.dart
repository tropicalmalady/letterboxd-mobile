class SignUpRequest {
  String username;
  String email;
  String password;

  SignUpRequest(this.username, this.email, this.password);
}

class UsernameCheckRequest {
  String username;
  UsernameCheckRequest(this.username);
}

class SignInRequest {
  String usernameOrEmail;
  String password;

  SignInRequest(this.usernameOrEmail, this.password);
}
