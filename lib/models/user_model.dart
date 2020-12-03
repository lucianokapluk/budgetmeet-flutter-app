class UserBud {
  String displayName;
  String email;
  String photoURL;
  String uid;

  UserBud({this.displayName, this.email, this.photoURL, this.uid});

  UserBud.fromJsonMap(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
    uid = json['uid'];
  }
}
