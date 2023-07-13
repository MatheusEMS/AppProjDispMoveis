import '../db_helper/repository.dart';
import '../model/users.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }

  //SaveUser
  SaveUser(Users user) async {
    return await _repository.InsertData("users", user.userMap());
  }

  ReadOneUser(String email) async {
    return await _repository.readDataById("users", email);
  }

  //Read all Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  UpdateUser(Users user) async {
    return await _repository.updateData('users', user.userMap());
  }
}
