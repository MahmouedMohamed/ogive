
import 'dart:core';

class User{
  String ID;
  String name;
  String user_name;
  String email;
//  String password;
  DateTime email_verified_at;
  DateTime created_at;
  DateTime updated_at;
//  public String hashPassword(String password) {
//    return String.valueOf(password.hashCode());
//  }
  User(this.ID, this.name, this.user_name, this.email, this.email_verified_at,this.created_at, this.updated_at);

  setID(ID) {
    this.ID = ID;
  }

  setEmail(email) {
    this.email = email;
  }

  setName(name) {
    this.name = name;
  }

  setPassword(password) {
//    this.password = hashPassword(password);
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

//  getpassword() {
//    return password ;
//  }


//  getPassword() {
//    return password;
//  }

  getUser_name() {
    return user_name;
  }

  setUser_name(String user_name) {
    this.user_name = user_name;
  }

  getEmail_verified_at() {
    return email_verified_at;
  }

  setEmail_verified_at(DateTime email_verified_at) {
    this.email_verified_at = email_verified_at;
  }

  getCreated_at() {
    return created_at;
  }

  setCreated_at(DateTime created_at) {
    this.created_at = created_at;
  }

  getUpdated_at() {
    return updated_at;
  }

  setUpdated_at(DateTime updated_at) {
    this.updated_at = updated_at;
  }

  toList() {
    return [
      ID,
      name,
      user_name,
      email,
      email_verified_at.toString(),
      created_at.toString(),
      updated_at.toString(),
    ];
  }
}