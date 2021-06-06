class LoginResponse {
  final String status;
  final String id;
  final String name;
  final String email;
  final String authToken;
  final String info;

  LoginResponse(
      {this.status, this.id, this.name, this.email, this.authToken, this.info});

  // converte o formato JSON para um objeto "Pessoa"
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        status: json['status'].toString(),
        id: json['id'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
        authToken: json['authToken'].toString(),
        info: json['info'].toString());
  }
}
