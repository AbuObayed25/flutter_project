class UserModel {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;
  String? Phone;
  String? createdDate;
  String? photo;
  String? Password;

  UserModel(
      {this.sId,
      this.email,
      this.firstName,
      this.lastName,
      this.Phone,
      //this.createdDate,
      this.Password,
      this.photo});

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    Phone = json['mobile'];
    //createdDate = json['createdDate'];
    Password = json['password'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = Phone;
    //data['createdDate'] = createdDate;
    data['password'] = Password;
    data['photo'] = photo;
    return data;
  }
}

class Password {}
