import 'dart:core';

class User {
  String ID;
  String name;
  String email;
  DateTime created_at;
  User(this.ID, this.name, this.email, this.created_at);

  setID(ID) {
    this.ID = ID;
  }

  setEmail(email) {
    this.email = email;
  }

  setName(name) {
    this.name = name;
  }

  getID() {
    return ID;
  }

  getEmail() {
    return email;
  }

  getName() {
    return name;
  }

  getCreated_at() {
    return created_at;
  }

  setCreated_at(DateTime created_at) {
    this.created_at = created_at;
  }

  toList() {
    return [
      ID,
      name,
      email,
      created_at.toString(),
    ];
  }
}
