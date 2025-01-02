import 'package:counter_app/apiApp/repository/model/user_model.dart';
import 'package:counter_app/apiApp/repository/repository.dart';
import 'package:counter_app/data/remote/api_client.dart';
import 'package:counter_app/data/remote/apis/user.api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements APIClient {}

void main() {
  late UserRepo userRepo;
  late MockHTTPClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHTTPClient();
    userRepo = UserRepo(mockHttpClient);
  });

  group('User Repository -', () {
    group('getUser function', () {
      test(
          'return a user model when API call is successful and response format is correct',
          () async {
        //Arrange :Mock API response
        when(() => mockHttpClient.fetch<void, List<UserModel>>(
              api: UserAPI.getPost,
              mapper: any(named: 'mapper'),
              cache: any(named: 'cache'),
            )).thenAnswer((Invocation) async {
          return [
            UserModel(id: 1, name: 'Leanne Graham', email: 'Sincere@april.biz'),
          ];
        }

            //   (_) async => [
            //   UserModel(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
            // ]
            );
        //Act
        final users = await userRepo.getallUsers();

        //Asert
        expect(users, isA<List<UserModel>>());
        expect(users?.length, 1);
        expect(users?.first.name, 'Leanne Graham');
      });
      test('throws an exption when apI call fails', () async {
        when(() => mockHttpClient.fetch<void, List<UserModel>>(
              api: UserAPI.getPost,
              mapper: any(named: 'mapper'),
              cache: any(named: 'cache'),
            )).thenThrow(Exception('API Error'));
        final user = userRepo.getallUsers();
        await expectLater(() => user, throwsA(isA<Exception>()));
      });
    });
  });
}
