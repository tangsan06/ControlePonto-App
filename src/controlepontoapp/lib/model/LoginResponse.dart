class LoginResponse {
  final String status;
  final String id;
  final String name;
  final String email;
  final String authToken;

  LoginResponse({this.status, this.id, this.name, this.email, this.authToken});

  // converte o formato JSON para um objeto "Pessoa"
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        status: json['status'] as String,
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        authToken: json['authToken'] as String);
  }
}
