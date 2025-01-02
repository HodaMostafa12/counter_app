import 'base.api.dart';

enum UserAPI implements API {
  getPost(path: "/users/1", method: Method.get);
  // postPost(path: "/api/login/customer", method: Method.post);

  const UserAPI({
    required this.path,
    required this.method,
  });
  @override
  final String path;
  @override
  final Method method;
}
