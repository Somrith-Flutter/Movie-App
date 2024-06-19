import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/bottom_navigation.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, this.isFromRegister});
  final bool? isFromRegister;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController auth = Get.find();
  final _formKey = GlobalKey<FormState>();
  late PageController _pageController;

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).ms_phone_number_required;
    } else if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
      return S.of(context).ms_valid_phone;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).ms_valid_email;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).ms_valid_pass;
    }
    return null;
  }

  void _toggleTextVisibility() {
    setState(() {
      auth.isToggle = !auth.isToggle;
    });
  }

  void _onTabTap(bool isPhoneSelected) {
    setState(() {
      auth.isPhoneTabSelected = isPhoneSelected;
      _pageController.animateToPage(
        auth.isPhoneTabSelected ? 0 : 1,
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
            appBar: widget.isFromRegister != true ? AppBar(
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
            ) : AppBar(
              automaticallyImplyLeading: false,
            ),
            body: _buildBody(context, logic)
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, logic){
    return Padding(
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
            const SizedBox(height: 16),
            TextWidget(
              S.of(context).ms_login,
              size: 16,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTap(false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: auth.isPhoneTabSelected
                            ? Colors.grey[800]
                            : Colors.red,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                    onTap: () => _onTabTap(true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: auth.isPhoneTabSelected
                            ? Colors.red
                            : Colors.grey[800],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                    auth.isPhoneTabSelected = index == 0;
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
                                        auth.isContinous = true;
                                        setState(() {});
                                        return;
                                      }

                                      EasyLoading.show(status: S.of(context).login_process);
                                      await logic.loginController(
                                          type: "phone");
                                      if (logic.status ==
                                          BaseStatusEnum.failure) {
                                        await EasyLoading.dismiss();
                                        IconSnackBar.show(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          snackBarType:
                                              SnackBarType.fail,
                                          label: S.of(context).ms_error,
                                          snackBarStyle:
                                              const SnackBarStyle(
                                            labelTextStyle: TextStyle(
                                                color: Colors.white),
                                          ),
                                        );
                                        return;
                                      }

                                      if (logic.status == BaseStatusEnum.success) {
                                        await EasyLoading.dismiss();
                                        Future.delayed(const Duration(milliseconds: 100));
                                        logic.clear();
                                        EasyLoading.showSuccess(S.of(context).ms_sucess);
                                        // ignore: use_build_context_synchronously
                                        AppRoute.route.pushReplacement(context, const BottomNavigation());
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
                                child: auth.isContinous
                                    ? TextWidget(
                                        S.of(context).login,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : TextWidget(
                                        S.of(context).continues,
                                        size: 16,
                                        color: Colors.white,
                                      )),
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
                                    EasyLoading.show(
                                        status: S.of(context).login_process);
                                    await logic.loginController(
                                        type: "email");

                                    if (logic.status ==
                                        BaseStatusEnum.failure) {
                                      await EasyLoading.dismiss();
                                      IconSnackBar.show(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        snackBarType: SnackBarType.fail,
                                        label: S.of(context).ms_error,
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
                                      EasyLoading.showSuccess(S.of(context).ms_sucess);
                                      // ignore: use_build_context_synchronously
                                      AppRoute.route.pushReplacement(context, const BottomNavigation());
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
                                color: Colors.white,
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
                  decoration: InputDecoration(
                    hintText: S.of(context).phone_number,
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
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
          visible: auth.isContinous,
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
                    obscureText: auth.isToggle,
                    validator: _validatePassword,
                    controller: auth.password,
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: _toggleTextVisibility,
                  child: Icon(
                    auth.isToggle ? Icons.visibility_off : Icons.visibility,
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
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
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
                  obscureText: auth.isToggle,
                  validator: _validatePassword,
                  controller: auth.password,
                  decoration: InputDecoration(
                    hintText: S.of(context).password,
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: _toggleTextVisibility,
                child: Icon(
                  auth.isToggle ? Icons.visibility_off : Icons.visibility,
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
