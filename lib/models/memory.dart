import 'like.dart';

class Memory {
  String id;
  String userId;
  String personName;
  DateTime birthDate;
  DateTime deathDate;
  String lifeStory;
  String imageLink;
  List<Like> likes;
  Memory(this.id, this.userId, this.personName, this.birthDate, this.deathDate,
      this.lifeStory, this.imageLink, this.likes);
  getId() {
    return id;
  }

  getUserId() {
    return userId;
  }

  getPersonName() {
    return personName;
  }

  getBirthDate() {
    return birthDate;
  }

  getDeathDate() {
    return deathDate;
  }

  getLifeStory() {
    return lifeStory;
  }

  getImageLink() {
    return imageLink;
  }
  inIn(userId){
    for(int i=0;i<likes.length;i++){
      if(likes[i].userId==userId){
        return true;
      }
    }
    return false;
  }
}
