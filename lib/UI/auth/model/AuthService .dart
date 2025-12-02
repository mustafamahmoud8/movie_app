import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../main_layer/tabs/profileTab/model/models/profile_response_model.dart';
import '../../main_layer/tabs/profileTab/model/network/profile_api.dart';
import '../../main_layer/tabs/profileTab/view_model/providers/avatar_bottom_sheet_provider.dart';
import '../view_model/providers/token_provider.dart';

class AuthService {
  final String baseUrl = "https://route-movie-apis.vercel.app";

  Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    final data = _processResponse(response);
    if (data.containsKey('data')) {
      final String token = data['data'];
      context.read<TokenProvider>().token = token;
    }

    ProfileData? profileData = await ProfileApi.getProfile(context);
    context.read<AvatarBottomSheetProvider>().selectedIndex =
        profileData?.avaterId ?? 7;
    context.read<AvatarBottomSheetProvider>().avatarId =
        profileData?.avaterId ?? 7;
    context.read<AvatarBottomSheetProvider>().initialAvatar();

    return data;
  }

  Future<Map<String, dynamic>> register(
      BuildContext context,
      String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avatarId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "confirmPassword": confirmPassword,
        'avaterId': avatarId,
      }),
    );
    context.read<AvatarBottomSheetProvider>().selectedIndex = avatarId;
    context.read<AvatarBottomSheetProvider>().avatarId = avatarId;
    context.read<AvatarBottomSheetProvider>().initialAvatar();
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> resetpassword(
      String email, BuildContext context) async {
    final token = context.watch<TokenProvider>().token;
    if (token == null) throw Exception('Token not found, please login first');

    final response = await http.patch(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"email": email}),
    );

    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message'] ?? 'Request failed');
    }
  }
}
