class User {
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? password;

  User({
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.password
  });

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailId'] = emailId;
    data['mobileNumber'] = mobileNumber;
    data['password'] = password;
    return data;
  }
}
