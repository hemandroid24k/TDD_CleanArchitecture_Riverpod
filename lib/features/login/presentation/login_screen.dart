import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_architecture_riverpod/core/constants/app_routes.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/injection/login_usecase_injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/widgets/input_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputTextFieldWidget(
                    key: const Key('username'),
                    inputTextEditingController: userNameTextController,
                    labelText: 'username',
                    obscureText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextFieldWidget(
                      key: const Key('password'),
                      inputTextEditingController: passwordTextController,
                      labelText: 'password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final UiState<LoginEntity> result = await ref.watch(postLoginFlowFutureProvider(
                            {"username": userNameTextController.text, "password": passwordTextController.text}).future);
                        if (result.success != null) {
                          final router = ref.watch(routerProvider);
                          router.go(AppRoutes().homePage);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
