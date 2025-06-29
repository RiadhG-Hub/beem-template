import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/auth/data/models/generate_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_captcha_model.dart';
import 'package:momra/features/auth/data/models/verify_o_t_p_model.dart';
import 'package:momra/features/auth/data/repositories/auth_repository_impl.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepositoryImpl authRepository;
  GenerateCaptchaModel? generateCaptchaResult;
  VerifyCaptchaModel? verifyCaptchaModelResult;
  VerifyOTPModel? verifyOTPResult;
  final AuthModel tempAuthModel = AuthModel(
    firstName: '12V7zpmOeY4XiwGB330zEVxPjihRUaGrGGxmClpSymo=',
    lastName: 'shWDVBEWml527umimIP0plusg==',
    errorMessage: null,
    status: 1,
    customActions: null,
    annotationsTemplate: null,
    inbox: null,
    logo: null,
    serviceType: 'JavaService',
    token:
        '341f4f880cff852b8ea4b4f894160a7b1f36f658249155072acdc8a2210a422f8cb6250e627aff666d4ad0942253e981',
    signature: null,
    signatureId: null,
    transferData: null,
    sections: null,
    searchRecipients: null,
    userDetails: null,
    userId: 108740,
    departmentName: null,
    voiceNoteMaximumDuration: null,
    visualTrackingURL: null,
    userGctId: null,
    structureId: null,
    inboxesOrder: null,
    inboxesType: null,
    bamUrl: null,
    usertype: 'minister',
    showDelegation: false,
    showOffline: false,
    showReports: false,
    showBAM: false,
    advancedSearchString: null,
    advancedSearchInboxType: null,
    departmentsList: null,
    usersList: [
      UserItem(
        id: 't0plusplusr7gp/4LpjVXBiQvtew==',
        value: 'DLIMo5lVmFHkatfAEx8aIzfUMQVtZiz8PAdsq9wrrfI=',
      ),
      UserItem(
        id: 'M2eHPGf6lAm22JMAV6fuYg==',
        value: 'Y8GQxtRAXSeP1faTOL4LmQ==',
      ),
    ],
    signatures: null,
    allDynamicImages: null,
    captchaString: null,
    digitalSignature: null,
  );

  UserType? userType;
  AuthModel? user;
  String? captcha;
  String? otp;
  String? userName;
  String? password;
  final TokenManager tokenManager;
  AuthenticationBloc(this.authRepository, this.tokenManager)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      switch (event) {
        case GenerateCaptchaEvent():
          {
            emit(GenerateCaptchaLoading());
            if (event.userName != null && event.password != null) {
              userName = event.userName;
              password = event.password;
            }

            final result = await authRepository.generateCaptcha(
              password: password!,
              userName: userName!,
              failedAttempts: 1,
              rememberMe: event.rememberMe,
            );
            result.fold((left) {
              emit(GenerateCaptchaFailed(left.toString()));
            }, (right) {
              generateCaptchaResult = right;
              emit(GenerateCaptchaSuccess(right));
            });
          }
        case VerifyCaptchaEvent():
          {
            emit(VerifyCaptchaLoading());
            final result =
                await authRepository.verifyCaptcha(captcha: event.captcha);
            result.fold((left) {
              emit(VerifyCaptchaFailed(left.toString()));
            }, (right) {
              verifyCaptchaModelResult = right;
              captcha = event.captcha;
              emit(VerifyCaptchaSuccess(right));
            });
          }
        case VerifyOtpEvent():
          emit(VerifyOtpLoading());
          Map<String, dynamic> body = {
            "initializeData": true,
            "ipAddress": "192.168.1.4",
            "isOtpEnabled": true,
            "language": "ar",
            "macAddress": "7D5BE193-F963-4FBB-850C-3EEE742B38EA",
            "machineName": "iPhone 16 Pro Max"
          };

          final result =
              await authRepository.verifyOtp(otp: event.otp, attempts: 0);

          if (result.isLeft()) {
            emit(VerifyOtpFailed(AuthDataSource.checkEnteredInfo));
          } else {
            final authenticationResult = await authRepository.authenticate(
                captcha: captcha ?? '', otp: event.otp, loginDetails: body);

            authenticationResult.fold((left) {
              emit(VerifyOtpFailed(left.toString()));
            }, (right) {
              if (right.usertype == "minister") {
                userType = UserType.minister;
              } else if (right.usertype == "advisor") {
                userType = UserType.advisor;
              } else {
                userType = UserType.unknown;
              }
              user = right;
              tokenManager.saveToken(right.token!);
            });
            result.fold((left) {
              emit(VerifyOtpFailed(left.toString()));
            }, (right) {
              verifyOTPResult = right;

              emit(VerifyOtpSuccess(right));
            });
          }

        case AuthenticateEvent():
          // TODO: Handle this case.
          throw UnimplementedError();
        case GenerateOtpEvent():
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }
}
