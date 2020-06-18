class User {
  String id;
  String name;
  String userName;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  User(this.id, this.name, this.userName, this.email, this.emailVerifiedAt,
      this.createdAt, this.updatedAt);

  setId(id) {
    this.id = id;
  }
  getId() {
    return id;
  }

  setEmail(email) {
    this.email = email;
  }
  getEmail() {
    return email;
  }

  setName(name) {
    this.name = name;
  }
  getName() {
    return name;
  }

  setUserName(String userName) {
    this.userName = userName;
  }
  getUserName() {
    return userName;
  }

  setEmailVerifiedAt(DateTime emailVerifiedAt) {
    this.emailVerifiedAt = emailVerifiedAt;
  }
  getEmailVerifiedAt() {
    return emailVerifiedAt;
  }

  setCreatedAt(DateTime createdAt) {
    this.createdAt = createdAt;
  }
  getCreatedAt() {
    return createdAt;
  }

  setUpdatedAt(DateTime updatedAt) {
    this.updatedAt = updatedAt;
  }
  getUpdatedAt() {
    return updatedAt;
  }

  toList() {
    return [
      id,
      name,
      userName,
      email,
      emailVerifiedAt.toString(),
      createdAt.toString(),
      updatedAt.toString(),
    ];
  }
}
