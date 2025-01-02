

import 'package:counter_app/apiApp/repository/model/user_model.dart';
import 'package:counter_app/data/remote/api_client.dart';
import 'package:counter_app/data/remote/apis/user.api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider =
    Provider((ref) => UserRepo(ref.watch(apiClientProvider)));

class UserRepo {
  APIClient apiClient;
  UserRepo(this.apiClient);

  Future<List<UserModel>?> getallUsers() async {
    final response = await apiClient.fetch<void, List<UserModel>>(
      api: UserAPI.getPost,
      mapper: (json) {
        if (json is List) {
          return json.map((e) => UserModel.fromJson(e)).toList();
        } else if (json is Map<String, dynamic> && json['data'] is List) {
          return (json['data'] as List)
              .map((e) => UserModel.fromJson(e))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      },
      cache: true,
    );
    return response;
  }


}
