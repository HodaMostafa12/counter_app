
import 'package:counter_app/apiApp/repository/model/user_model.dart';
import 'package:counter_app/apiApp/repository/repository.dart';
import 'package:counter_app/base/base_state.dart';
import 'package:counter_app/base/base_state_provider.dart';
import 'package:counter_app/base/base_viewmodel.dart';

final userViewmodelProvider = BaseStateProvider<UserViewState, UserViewModel>(
  (ref) => UserViewModel(ref.watch(userRepositoryProvider)),
);

class UserViewState {
  final List<UserModel> user;
  UserViewState(this.user);
}

class UserViewModel extends BaseViewModel<UserViewState> {
  final UserRepo repo;
  UserViewModel(this.repo) : super(BaseViewState(data: null));

  getUserData() async{
    try{
      isLoading = false;
      final response = await repo.getallUsers();
      if (response != null) {
        //if repo not = null
        data = UserViewState(response); //make user = data or token
        return response; // return DocModel
      } 
      data = UserViewState(response!);
    }catch(e){
      isLoading = false;
      error = BaseError(e.toString());
      print('########################### $e;;;;;;;;;;;;;;;;');
    }
  }
}
