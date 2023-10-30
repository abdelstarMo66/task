import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/core/componants/custom_button.dart';
import 'package:task/src/features/auth/auth_cubit/auth_cubit.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/const_methods.dart';
import '../../../core/constants/styles.dart';
import '../../../core/router/app_router_names.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isMale = true;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    nameController.text = "عبدالرحمن محمد";
    dateController.text = "01/03/1997";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingRegisterState) {
              logWarning("Loooooooooding");
            }
            if (state is SuccessRegisterState) {
              Navigator.pushNamed(context, AppRouterNames.rHome);
            }
            if (state is ErrorRegisterState) {
              logError("ERRRRRRRROR");
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              extendBody: true,
              bottomSheet: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 25.0),
                child: CustomButton(
                  label: "متابعه",
                  activate: checkedValue,
                  onTap: () {
                    AuthCubit.get(context).register(
                      user: UserModel(
                          name: nameController.text,
                          nickName: "mmm",
                          birth: dateController.text,
                          email: "mohamed@email.com"),
                    );
                  },
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  const Text(
                    'سعيدون بلقائك!',
                    style: AppStyles.textStyle24,
                  ),
                  const SizedBox(height: 50.0),
                  CustomFormItem(
                    controller: nameController,
                    inputType: TextInputType.name,
                    label: "الاسم",
                  ),
                  const SizedBox(height: 16.0),
                  CustomFormItem(
                    controller: dateController,
                    inputType: TextInputType.datetime,
                    label: "تاريخ الميلاد",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.date_range_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    'ما هو جنسك؟',
                    style: AppStyles.textStyle12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ذكر',
                                style: AppStyles.textStyle14.copyWith(
                                  color: isMale
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.male,
                                color:
                                    isMale ? AppColors.white : AppColors.black,
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              isMale = true;
                            });
                          },
                          activate: isMale,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: CustomButton(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'انثي',
                                style: AppStyles.textStyle14.copyWith(
                                  color: !isMale
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.female,
                                color:
                                    !isMale ? AppColors.white : AppColors.black,
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              isMale = false;
                            });
                          },
                          activate: !isMale,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44.0),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkedValue = !checkedValue;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: checkedValue
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF2AC59E),
                                )
                              : const Icon(
                                  Icons.radio_button_unchecked_outlined,
                                  color: AppColors.lightBlack,
                                ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ' اوافق علي ',
                              style: AppStyles.textStyle12.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'الشروط و الأحكام .',
                              style: AppStyles.textStyle12.copyWith(
                                color: const Color(0xFF2AC59E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomFormItem extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String label;
  final Widget? suffixIcon;
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
  );

  CustomFormItem({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.label,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.textStyle12.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder: border,
            border: border,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
