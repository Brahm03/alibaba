import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static final String registrationURL =
      "https://api-service.fintechhub.uz/register/";
  static final String otpURl = "https://api-service.fintechhub.uz/otp-verify/";
  static final String loginURL = "https://api-service.fintechhub.uz/login/";

  static Future<String> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final response = await http.post(Uri.parse(registrationURL),
          body: {"username": username, "email": email, "password": password});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Registration ishladi ${response.statusCode}');
        print('');
        return json.decode(response.body)['otp'];
      } else {
        throw HttpException(response.body);
      }
    } on TimeoutException catch (__) {
      throw TimeoutException('Try again !');
    } on SocketException catch (_) {
      throw SocketException('Check your internet connection !');
    } on HttpException catch (error) {
      throw HttpException(error.message);
    } on FormatException catch (_) {
      throw FormatException('Something went wrong !');
    } catch (error) {
      throw Exception('Something went wrong !');
    }
  }

  static Future<void> otpConfirm(
      {required String email, required String code}) async {
    try {
      final response = await http
          .post(Uri.parse(otpURl), body: {"email": email, "code": code});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('OTP ishladi ${response.statusCode}');
      } else {
        throw HttpException(response.body);
      }
    } on TimeoutException catch (__) {
      throw TimeoutException('Try again !');
    } on SocketException catch (_) {
      throw SocketException('Check your internet connection !');
    } on HttpException catch (error) {
      throw HttpException(error.message);
    } on FormatException catch (_) {
      throw FormatException('Something went wrong !');
    } catch (error) {
      throw Exception('Something went wrong !');
    }
  }
}
