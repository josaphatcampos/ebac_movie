
import 'package:http/http.dart';
import 'package:pre_projeto/common/model/user_model.dart';
import 'package:pre_projeto/common/sistem/utils.dart';

class LoginRepository{
  static Client client = Client();

  LoginRepository();

  Map<String, dynamic> getLogin(String nickname, String pass){
    if(nickname == 'jocampos' && pass == '123'){
      Utils.globalUser = User(nickName: nickname, firstName: "Josaphat", lastName: "Campos", password: pass);

      return Utils.globalUser!.toMap();
    }

    throw Exception();
  }
}