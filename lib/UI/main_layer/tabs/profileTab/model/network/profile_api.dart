import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/UI/auth/view_model/providers/token_provider.dart';

import '../../view_model/providers/avatar_bottom_sheet_provider.dart';
import '../models/profile_response_model.dart';

class ProfileApi {
  static final String baseUrl = "https://route-movie-apis.vercel.app";

  static Future<ProfileData?> getProfile(BuildContext context) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.parse('$baseUrl/profile');
    http.Response response = await http.get(
      uri,
      headers: {
        if (token != null) "Authorization": "Bearer $token",
      },
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    ProfileResponseModel data = ProfileResponseModel.fromJson(jsonResponse);
    if (response.statusCode == 200) {
      return data.data;
    } else {
      throw data.message ?? 'something went wrong';
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
      BuildContext context, String name, String phone) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.parse('$baseUrl/profile');
    http.Response response = await http.patch(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        // "password": password,
        "phone": phone,
        'avaterId': context.read<AvatarBottomSheetProvider>().avatarId,
      }),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      throw jsonResponse['message'] ?? 'Request failed';
    }
  }

  static Future<String> resetPassword(
      BuildContext context, String oldPassword, String newPassword) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.parse('$baseUrl/auth/reset-password');
    http.Response response = await http.patch(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body:
          jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword}),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse['message'];
    } else {
      throw jsonResponse['message'] ?? 'Request failed';
    }
  }

  static Future<Map<String, dynamic>> deleteProfile(
      BuildContext context) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.parse('$baseUrl/profile');
    http.Response response = await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      throw jsonResponse['message'] ?? 'Request failed';
    }
  }
}
