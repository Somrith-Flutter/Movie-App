import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

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

  String? _emialValidated(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _passwordValidated(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _toggleText() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  void _onTabTap(bool isPhoneSelected) {
    setState(() {
      isPhoneTabSelected = !isPhoneSelected;
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
                    TextWidget(
                      S.of(context).login,
                      size: 24,
                    ),
                    const Gap(16),
                    const TextWidget(
                      'អាស័យដ្ឋានអ៊ីមែលរបស់អ្នក ឬលេខទូរស័ព្ទរបស់អ្នក',
                      size: 16,
                    ),
                    const Gap(32),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _onTabTap(true);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPhoneTabSelected
                                    ? Colors.grey[800]
                                    : Colors.red,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: TextWidget(
                                    S.of(context).email,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _onTabTap(false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPhoneTabSelected
                                    ? Colors.red
                                    : Colors.grey[800],
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: TextWidget(
                                    S.of(context).phone_number,
                                    size: 16,
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
                                            if(logic.password.text.isEmpty){
                                              _isContinous = true;
                                              setState(() {});
                                              return;
                                            }

                                            await logic.loginController(
                                                type: "phone");

                                            if (logic.status ==
                                                BaseStatusEnum.success) {
                                              await EasyLoading.dismiss();
                                              Future.delayed(const Duration(
                                                  microseconds: 100));
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
                                      child: !_isContinous ? TextWidget(
                                        S.of(context).continous,
                                        size: 16,
                                      ) : TextWidget(
                                        S.of(context).login,
                                        size: 16,
                                      )
                                    )
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
                                                BaseStatusEnum.success) {
                                              await EasyLoading.dismiss();
                                              Future.delayed(const Duration(
                                                  microseconds: 100));
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
                                      child: TextWidget(
                                        S.of(context).login,
                                        size: 16,
                                      )
                                    )
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
              const Gap(8),
              const TextWidget(
                '+855',
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) => _validatePhoneNumber(value),
                  controller: auth.number,
                  decoration: InputDecoration(
                    hintText: S.of(context).phone_number,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Khmer',
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const Gap(18),
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
                    obscureText: _isToggle ? true : false,
                    validator: (value) => _passwordValidated(value),
                    controller: auth.password,
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Khmer',
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                    onTap: () => _toggleText(),
                    child: Icon(
                        _isToggle ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white)),
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
                  validator: (value) => _emialValidated(value),
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Khmer',
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const Gap(18),
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
                  obscureText: _isToggle ? true : false,
                  validator: (value) => _passwordValidated(value),
                  controller: auth.password,
                  decoration: InputDecoration(
                    hintText: S.of(context).password,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Khmer',
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              GestureDetector(
                  onTap: () => _toggleText(),
                  child: Icon(
                      _isToggle ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
