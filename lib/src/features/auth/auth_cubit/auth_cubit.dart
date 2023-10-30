import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/core/constants/cache_keys.dart';
import 'package:task/src/core/constants/const_methods.dart';
import 'package:task/src/core/constants/end_points.dart';
import 'package:task/src/core/services/cache_helper.dart';
import 'package:task/src/core/services/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  void verifyPhone({required String phone}) async {
    emit(LoadingVerifyPhoneState());

    await DioHelper.postData(url: EndPoints.epVerifyPhone, body: {
      'phone': phone,
      'type': 'user',
      'dial_code': '+20',
    }).then((value) {
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckApiToken,
        value: value.data['data']['token'],
      );

      logSuccess(value.data.toString());
      emit(SuccessVerifyPhoneState());
    }).catchError((error) {
      logError(error);
      emit(ErrorVerifyPhoneState());
    });
  }

  void verifyOtp({required String otp}) async {
    emit(LoadingVerifyOTPState());

    await DioHelper.postData(
      url: EndPoints.epVerifyOtp,
      body: {
        'otp': otp,
      },
      token: CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckApiToken),
    ).then((value) {
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckApiToken,
        value: value.data['data']['token'],
      );

      logSuccess(value.data.toString());
      emit(SuccessVerifyOTPState());
    }).catchError((error) {
      logError(error);
      emit(ErrorVerifyOTPState());
    });
  }

  void register({required UserModel user}) async {
    emit(LoadingRegisterState());

    await DioHelper.postData(
      url: EndPoints.epRegister,
      body: {
        'name': user.name,
        'nickName': user.nickName,
        'birth': user.birth,
        'email': user.email,
        'userDetails[type]': 'user',
      },
      token: CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckApiToken),
    ).then((value) {
      logSuccess(value.data.toString());
      emit(SuccessRegisterState());
    }).catchError((error) {
      logError(error.toString());
      emit(ErrorRegisterState());
    });
  }
}

class UserModel {
  String name;
  String nickName;
  String birth;
  String email;

  UserModel({
    required this.name,
    required this.nickName,
    required this.birth,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      nickName: json["nickName"],
      birth: json["birth"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "nickName": nickName,
      "birth": birth,
      "email": email,
    };
  }
}
