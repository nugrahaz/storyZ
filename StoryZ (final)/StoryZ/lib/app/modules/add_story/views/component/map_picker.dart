import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/add_story/controllers/add_story_controller.dart';
import 'package:storyz/app/utils/utils.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key});

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  @override
  void initState() {
    super.initState();
    SharedMethod.systemBarColor(AppStyles.colors.white, AppStyles.colors.white);
  }

  @override
  Widget build(BuildContext context) {
    // String api = "AIzaSyAF4kMsq7i3KhdXMFkjRy3fbVI_llGLWOY";
    String api = "AIzaSyDWbksQu8AkCDCoAVIA_j2qUM1v5RrTGEA";

    final AddStoryController controller = AddStoryController.to;

    return WillPopScope(
      onWillPop: () {
        SharedMethod.systemBarColor(
            AppStyles.colors.transparent, AppStyles.colors.bgDark);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        backgroundColor: AppStyles.colors.bgDark,
        body: MapLocationPicker(
          hideMapTypeButton: true,
          hideBackButton: true,
          hideMoreOptions: true,
          hideSuggestionsOnKeyboardHide: false,
          minimum: const EdgeInsets.symmetric(horizontal: 12),
          bottomCardMargin:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          //
          apiKey: api,
          popOnNextButtonTaped: true,
          currentLatLng: LatLng(double.parse(controller.latitude),
              double.parse(controller.longitude)),
          onNext: (GeocodingResult? result) {
            if (result != null) {
              controller.latitude = result.geometry.location.lat.toString();
              controller.longitude = result.geometry.location.lng.toString();
            }
          },
          onSuggestionSelected: (PlacesDetailsResponse? result) {
            if (result != null) {
              setState(() {
                controller.latitude =
                    result.result.geometry!.location.lat.toString();
                controller.longitude =
                    result.result.geometry!.location.lng.toString();
              });
            }
          },
        ),
      ),
    );
  }
}
