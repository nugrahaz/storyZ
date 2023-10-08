class Endpoints {
  static const baseUrl = "https://story-api.dicoding.dev/v1";

  //
  static var login = "$baseUrl/login";
  static var registration = "$baseUrl/register";
  static var getListStories = "$baseUrl/stories";
  static var getStoriesDetail = "$baseUrl/stories/"; //id
  static var postStories = "$baseUrl/stories";
}
