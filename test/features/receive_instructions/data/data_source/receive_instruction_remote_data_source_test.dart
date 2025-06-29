// Core testing imports
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/core/db_config/fake_shared_preferences_async.dart';
import 'package:momra/features/receive_instructions/data/data_source/receive_instruction_remote_data_source.dart';
import 'package:momra/injectables.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock class for SharedPreferences

void main() {
  // Initialize test environment
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({
      "basic": "Basic dXNlcjk5OTptaW5pc3Rlcg==",
      "token":
          "cf0f1806fc20f3d49990cf94f6b388d5b158b4b5cd5529b497d6ca568eb2a8442c3105e442dcb9047a0ea281a117ed69"
    });

    await dotenv.load(fileName: ".env");
    configureDependencies();
  });

  // Test group for AuthenticationRepository
  group('AuthenticationRepository', () {
    // Dependencies
    late TokenManager tokenManager;
    late DioClient dioClient;
    late ReceiveInstructionDataSource dataSource;
    late MockSharedPreferences mockSharedPreferences;

    // Setup before each test
    setUp(() async {
      mockSharedPreferences = MockSharedPreferences();
      tokenManager = TokenManager(mockSharedPreferences);
      dioClient = DioClient(tokenManager, "");
      dataSource = ReceiveInstructionDataSource(dioClient);
    });

    // Test cases
    test(' getMedia', () async {
      final result = await dataSource.getMedia(instructionsType: false);
      print(result);
    });
  });
}
