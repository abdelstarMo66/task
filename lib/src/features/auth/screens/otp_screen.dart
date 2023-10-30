import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/src/core/componants/custom_button.dart';
import 'package:task/src/core/constants/colors.dart';
import 'package:task/src/core/constants/styles.dart';
import 'package:task/src/core/router/app_router_names.dart';
import 'package:task/src/features/auth/auth_cubit/auth_cubit.dart';
import 'package:task/src/features/auth/screens/create_user_screen.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/const_methods.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool active = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("رمز التحقق"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogo2,
                    width: 170.0,
                  ),
                  const SizedBox(height: 32.0),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      controller: controller,
                      mainAxisAlignment: MainAxisAlignment.center,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 12.0),
                      appContext: context,
                      autoFocus: true,
                      cursorColor: AppColors.black,
                      keyboardType: TextInputType.number,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 56,
                        fieldWidth: 56,
                        borderWidth: 1.0,
                        selectedBorderWidth: 1.0,
                        activeBorderWidth: 1.0,
                        inactiveBorderWidth: 1.0,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.primaryColor,
                        selectedColor: AppColors.primaryColor,
                        activeFillColor: AppColors.primaryColor.withOpacity(
                            0.05),
                        inactiveFillColor:
                        AppColors.primaryColor.withOpacity(0.05),
                        selectedFillColor:
                        AppColors.primaryColor.withOpacity(0.05),
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: AppColors.white,
                      enableActiveFill: true,
                      onChanged: (value) {
                        var val = value.split("");
                        setState(() {
                          if (val.length > 3) {
                            active = true;
                          } else {
                            active = false;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    ' ادخل رمز التحقق المكون من 4 ارقام',
                    style: AppStyles.textStyle12.copyWith(
                      color: const Color(0xFF4F4F4F),
                      letterSpacing: 0.40,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoadingVerifyOTPState) {
                        logWarning("Loooooooooding");
                      }
                      if (state is SuccessVerifyOTPState) {
                        Navigator.pushNamed(
                            context, AppRouterNames.rCreateUser);
                      }
                      if (state is ErrorVerifyOTPState) {
                        logError("ERRRRRRRROR");
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        label: "تاكيد",
                        activate: active,
                        onTap: () {
                          AuthCubit.get(context).verifyOtp(
                              otp: controller.text);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    '00:60',
                    style: AppStyles.textStyle14.copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'هل حصلت علي رمز التحقق؟ ',
                        style: AppStyles.textStyle12.copyWith(
                          color: AppColors.darkGrey,
                          letterSpacing: 0.40,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'اعادة ارسال',
                          style: AppStyles.textStyle12.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
