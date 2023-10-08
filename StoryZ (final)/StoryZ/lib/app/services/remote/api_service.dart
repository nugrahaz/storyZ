import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:storyz/app/models/login_model.dart';
import 'package:storyz/app/models/login_response_model.dart';
import 'package:storyz/app/models/request_add_story.dart';
import 'package:storyz/app/models/response_api.dart';
import 'package:storyz/app/models/response_get_detail_story_model.dart';
import 'package:storyz/app/models/story_model.dart';
import 'package:storyz/app/services/remote/api_base_helper.dart';
import 'package:storyz/app/services/remote/endpoints.dart';

import '../../models/registration_model.dart';

class ApiService {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<LoginResponseModel> login({required LoginModel loginModel}) async {
    try {
      var response = await _helper.post(
        url: Endpoints.login,
        body: {
          'email': loginModel.email,
          'password': loginModel.password,
        },
        header: headers,
      );

      if (response == null) {
        throw Exception('Failed -  Response Api Login null');
      } else {
        return LoginResponseModel.fromJson(response);
      }
    } catch (error) {
      return LoginResponseModel(error: true, message: error.toString());
    }
  }

  Future<ResponseApi> registration(
      {required RegistrationModel registrationModel}) async {
    var response = await _helper.post(
        url: Endpoints.registration,
        body: {
          'name': registrationModel.name,
          'email': registrationModel.email,
          'password': registrationModel.password
        },
        header: headers);

    if (response == null) {
      throw Exception('Failed -  Response Api Registration null');
    } else {
      return ResponseApi.fromJson(response);
    }
  }

  // Future<List<ListStory>> getListStory({required String token}) async {
  //   var response = await _helper.get(url: Endpoints.getListStories, header: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   });
  //
  //   final List<dynamic> storiesJson = response['listStory'];
  //   final List<ListStory> stories = storiesJson.map((storyJson) {
  //     return ListStory.fromJson(storyJson);
  //   }).toList();
  //
  //   return stories;
  // }

  Future<List<StoryModel>> getListStoryX(
      {required String token, required int page, required int limit}) async {
    Uri url = Uri.parse(
        "https://story-api.dicoding.dev/v1/stories?page=$page&limit=$limit");
    var response = await _helper.get(url: url.toString(), header: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    final List<dynamic> storiesJson = response['listStory'];
    final List<StoryModel> stories = storiesJson.map((storyJson) {
      return StoryModel.fromJson(storyJson);
    }).toList();
    return stories;
  }

  Future<GetDetailStoryResult> getStoryDetail(
      {required String storyId, required String token}) async {
    var response = await _helper.get(
        url: Endpoints.getStoriesDetail + storyId,
        header: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response == null) {
      throw Exception('Failed -  Response Api Detail_Story null');
    } else {
      return GetDetailStoryResult.fromJson(response);
    }
  }

  Future<ResponseApi> postStory(
      {required String token, required AddStoryRequest story}) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(Endpoints.postStories));
      request.headers.addAll(headers);

      request.fields['lat'] = story.lat.toString();
      request.fields['lon'] = story.lon.toString();
      request.fields['description'] = story.description.toString();
      final file = await http.MultipartFile.fromPath(
        'photo',
        story.photoUrl!,
      ); // Adjust content type as needed

      request.files.add(file);

      final response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final responseData = json.decode(responseBody);
        return ResponseApi.fromJson(responseData);
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}, with : ${response.stream.bytesToString()}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
