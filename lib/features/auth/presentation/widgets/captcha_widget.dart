import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';

class CaptchaWidget extends StatelessWidget {
  final String base64String;

  const CaptchaWidget({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    String trimmed = base64String.substring(4);
    Uint8List bytes = base64Decode(trimmed);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is GenerateCaptchaLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GenerateCaptchaFailed) {
          return Center(
            child: Text(AuthDataSource.unknownIssue),
          );
        } else if (state is GenerateCaptchaSuccess) {
          String trimmedFromState =
              state.generateCaptchaModel.CaptchaString.substring(4);
          Uint8List bytesFromState = base64Decode(trimmedFromState);
          return Image.memory(
            bytesFromState,
            fit: BoxFit.contain,
          );
        }

        return Image.memory(
          bytes,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
