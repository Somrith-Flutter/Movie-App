import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/widgets/back_widget.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isPhoneTabSelected = true;
  final auth = Get.put(AuthController(repository: AuthRepository()));
  final _formKey = GlobalKey<FormState>();
  bool _isToggle = true;
  bool _isContinous = false;
  late PageController _pageController;

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _toggleTextVisibility() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  void _onTabTap(bool isPhoneSelected) {
    setState(() {
      isPhoneTabSelected = isPhoneSelected;
      _pageController.animateToPage(
        isPhoneTabSelected ? 0 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetBuilder<AuthController>(
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Enter your email or phone number',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onTabTap(true),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPhoneTabSelected
                                    ? Colors.grey[800]
                                    : Colors.red,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Phone',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onTabTap(false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPhoneTabSelected
                                    ? Colors.red
                                    : Colors.grey[800],
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            isPhoneTabSelected = index == 0;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              buildPhoneNumberInput(),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            if (logic.password.text.isEmpty) {
                                              _isContinous = true;
                                              setState(() {});
                                              return;
                                            }
                                            await logic.loginController(
                                                type: "phone");
                                            if (logic.status ==
                                                BaseStatusEnum.failure) {
                                              IconSnackBar.show(
                                                context,
                                                snackBarType: SnackBarType.fail,
                                                label: 'Something went wrong!',
                                                snackBarStyle:
                                                    const SnackBarStyle(
                                                  labelTextStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                              return;
                                            }
                                            if (logic.status ==
                                                BaseStatusEnum.success) {
                                              await EasyLoading.dismiss();
                                              Future.delayed(const Duration(
                                                  milliseconds: 100));
                                              logic.clear();
                                              EasyLoading.showSuccess(
                                                  'Success!');
                                            } else {
                                              EasyLoading.show(
                                                  status: 'Logging in...');
                                            }
                                          }
                                        } catch (_) {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: !_isContinous
                                          ? const Text(
                                              'Continue',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              buildEmailInput(),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            await logic.loginController(
                                                type: "email");
                                            if (logic.status ==
                                                BaseStatusEnum.failure) {
                                              IconSnackBar.show(
                                                context,
                                                snackBarType: SnackBarType.fail,
                                                label: 'Something went wrong!',
                                                snackBarStyle:
                                                    const SnackBarStyle(
                                                  labelTextStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                              return;
                                            }
                                            if (logic.status ==
                                                BaseStatusEnum.success) {
                                              await EasyLoading.dismiss();
                                              Future.delayed(const Duration(
                                                  milliseconds: 100));
                                              logic.clear();
                                              EasyLoading.showSuccess(
                                                  'Success!');
                                            } else {
                                              EasyLoading.show(
                                                  status: 'Logging in...');
                                            }
                                          }
                                        } catch (_) {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPhoneNumberInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(
                AssetPath.flagkhmer,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                '+855',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: _validatePhoneNumber,
                  controller: auth.number,
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    hintStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Visibility(
          visible: _isContinous,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    obscureText: _isToggle,
                    validator: _validatePassword,
                    controller: auth.password,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: _toggleTextVisibility,
                  child: Icon(
                    _isToggle ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmailInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.person, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: auth.email,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  obscureText: _isToggle,
                  validator: _validatePassword,
                  controller: auth.password,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: _toggleTextVisibility,
                child: Icon(
                  _isToggle ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
