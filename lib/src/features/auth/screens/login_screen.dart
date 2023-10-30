import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/core/componants/custom_button.dart';
import 'package:task/src/core/constants/assets.dart';
import 'package:task/src/core/constants/styles.dart';
import 'package:task/src/core/router/app_router_names.dart';
import 'package:task/src/features/auth/auth_cubit/auth_cubit.dart';
import 'package:task/src/features/auth/screens/otp_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/const_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  bool isActivate = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingVerifyPhoneState) {
              logWarning("Loooooooooding");
            }
            if (state is SuccessVerifyPhoneState) {
              Navigator.pushNamed(context, AppRouterNames.rOTP);
            }
            if (state is ErrorVerifyPhoneState) {
              logError("ERRRRRRRROR");
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: isActivate
                  ? AppBar(
                      title: const Text("تسجيل الدخول"),
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            isActivate = false;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    )
                  : AppBar(),
              body: Opacity(
                opacity: isActivate ? 0.0 : 0.1,
                child: Image.asset(
                  AppAssets.imgLogo,
                  width: 350.0,
                ),
              ),
              extendBody: true,
              bottomSheet: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.socialWhite),
                        bottom: BorderSide(color: AppColors.socialWhite),
                      ),
                      color: Colors.transparent,
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: AppStyles.textStyle16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.socialWhite),
                        bottom: BorderSide(color: AppColors.socialWhite),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ادخل رقم الهاتف',
                          style: AppStyles.textStyle12
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: isActivate
                                  ? AppColors.primaryColor
                                  : AppColors.lightBlack,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: AppStyles.textStyle14,
                                  decoration: InputDecoration(
                                    hintText: "1xx xxx xxxx",
                                    hintStyle: AppStyles.textStyle14
                                        .copyWith(color: AppColors.lightGrey3),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                  ),
                                  cursorColor: AppColors.black,
                                  controller: controller,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your phone number!";
                                    } else if (value.length < 11) {
                                      return "Too short phone number";
                                    } else if (value.length > 11) {
                                      return "phone number invaled";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {},
                                  onTap: () {
                                    setState(() {
                                      isActivate = true;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 2.0,
                                height: 56.0,
                                color: isActivate
                                    ? AppColors.primaryColor
                                    : AppColors.lightBlack,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  '${generateCountryFlag()} +20',
                                  style: AppStyles.textStyle16.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                  if (!isActivate)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text:
                                    'استخدامك لهاذا التطبيق يعني موافقتك علي ',
                                style: AppStyles.textStyle10,
                              ),
                              TextSpan(
                                text: 'سياسة وشروط الأستخدام',
                                style: AppStyles.textStyle10.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (isActivate)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 32.0),
                          child: CustomButton(
                            label: "متابعة",
                            onTap: () {
                              AuthCubit.get(context)
                                  .verifyPhone(phone: controller.text);
                            },
                          ),
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
