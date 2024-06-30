class User {
  int? id;
  String? name;
  String? email;
  String? password;

  User(this.id, this.name, this.email, this.password);

  User.fromMap(Map map) {
    this.id = map["id"];
    this.name = map["name"];
    this.email = map["email"];
    this.password = map["password"];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "name": this.name,
      "email": this.email,
      "password": this.password
    };
    
    if (this.id != null) {
      map["id"] = this.id;
    }
    
    return map; 
  }
}