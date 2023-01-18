import 'package:get/get.dart';
import 'package:testappfirst/data/repository/auth_repo.dart';
import 'package:testappfirst/models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  registration(SignUpBody signUpBody) async {
    _isLoading=true;
    Response response = await authRepo.registration(signUpBody);
    if(response.statusCode==200){
        authRepo.saveUserToken(response.body["token"]);

    }
    else{

    }
  }
}