class Friend {
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;

  Friend({
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
  });

  Friend.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailId'] = emailId;
    data['mobileNumber'] = mobileNumber;
    return data;
  }
}
