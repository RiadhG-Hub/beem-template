import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/core/router/router.dart';
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';

import '../../../../injectables.dart';
import '../../../send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _OTPController = TextEditingController();
  @override
  void dispose() {
    _OTPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحقق من OTP")),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            // Navigate to another page
            final UserType? userType =
                context.read<AuthenticationBloc>().userType;
            final collectionCubit = getIt.get<CollectInstructionCubit>();
            collectionCubit.advisors =
                context.read<AuthenticationBloc>().user?.usersList ?? [];
            if (userType == UserType.minister) {
              context.goNamed(AppRoutes.sendInstructionPage);
            } else if (userType == UserType.advisor) {
              context.goNamed(AppRoutes.receiveInstructionPage);
            } else if (userType == UserType.unknown) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("خطأ"),
                  content: const Text("نوع المستخدم غير معرف"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("حسناً"),
                    ),
                  ],
                ),
              );
            }
          } else if (state is VerifyOtpFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is VerifyOtpLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: _OTPController,
                  decoration: const InputDecoration(
                    labelText: "أدخل رمز ",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (state is VerifyOtpFailed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    final input = _OTPController.text.trim();
                    context.read<AuthenticationBloc>().add(
                          VerifyOtpEvent(input),
                        );
                  },
                  child: const Text("تحقق"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
