import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/add_story/views/component/google_map_view_model.dart';
import 'package:storyz/app/modules/list_story/controllers/list_story_controller.dart';
import 'package:storyz/app/modules/list_story/views/component/maps_page.dart';
import 'package:storyz/app/utils/utils.dart';

class DetailStoriesPage extends StatefulWidget {
  final String storyId;

  const DetailStoriesPage({super.key, required this.storyId});

  @override
  State<DetailStoriesPage> createState() => _DetailStoriesPageState();
}

class _DetailStoriesPageState extends State<DetailStoriesPage> {
  ListStoryController listStoryController = ListStoryController.to;

  // var arguments = Get.arguments;

  ////////
  final viewModel = GoogleMapViewModel();

  @override
  void initState() {
    listStoryController.fetchDetailStories(widget.storyId);
    // TODO: implement initState
    SharedMethod.systemBarColor(AppStyles.colors.white, AppStyles.colors.white);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => (listStoryController.isLoading.value == true)
            ? SpinKitRotatingCircle(
                color: AppStyles.colors.bgDark,
                size: 10.0 * SizeConfig.blockWidth,
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Padding(
                      padding: EdgeInsets.all(4.0 * SizeConfig.blockWidth),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                          tag: widget.storyId,
                          child: ExtendedImage.network(
                            height: 35.0 * SizeConfig.blockHeight,
                            width: 100.0 * SizeConfig.blockWidth,
                            listStoryController.story.photoUrl.toString(),
                            cache: true,
                            cacheRawData: true,
                            clearMemoryCacheIfFailed: true,
                            clearMemoryCacheWhenDispose: true,
                            enableMemoryCache: true,
                            fit: BoxFit.fill,
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.blockWidth * 3)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0 * SizeConfig.blockWidth,
                          vertical: 2.0 * SizeConfig.blockWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: AppStyles.textStyles.poppinsBold.copyWith(
                              fontSize: 3.8 * SizeConfig.blockWidth,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockWidth * 1.5,
                          ),
                          Text(
                            listStoryController.story.name.toString(),
                            style: AppStyles.textStyles.poppinsMedium.copyWith(
                                fontSize: SizeConfig.blockWidth * 3,
                                height: 1,
                                color:
                                    AppStyles.colors.bgDark.withOpacity(0.8)),
                          ),
                          SizedBox(height: 4.0 * SizeConfig.blockWidth),
                          Text(
                            "Description",
                            style: AppStyles.textStyles.poppinsBold.copyWith(
                              fontSize: 3.8 * SizeConfig.blockWidth,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockWidth * 1.5,
                          ),
                          Text(
                            listStoryController.story.description.toString(),
                            style: AppStyles.textStyles.poppinsMedium.copyWith(
                                fontSize: SizeConfig.blockWidth * 3,
                                height: 1,
                                color:
                                    AppStyles.colors.bgDark.withOpacity(0.8)),
                          ),
                          SizedBox(height: 4.0 * SizeConfig.blockWidth),
                          Text(
                            "Created at",
                            style: AppStyles.textStyles.poppinsBold.copyWith(
                              fontSize: 3.8 * SizeConfig.blockWidth,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockWidth * 1.5,
                          ),
                          Text(
                            DateFormat('EEEE, MMM d yyyy')
                                .format(listStoryController.story.createdAt!)
                                .toString(),
                            style: AppStyles.textStyles.poppinsMedium.copyWith(
                                fontSize: SizeConfig.blockWidth * 3,
                                height: 1,
                                color:
                                    AppStyles.colors.bgDark.withOpacity(0.8)),
                          ),
                          SizedBox(height: 4.0 * SizeConfig.blockWidth),
                          (listStoryController.story.lat == null ||
                                  listStoryController.story.lon == null)
                              ? const SizedBox()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location",
                                      style: AppStyles.textStyles.poppinsBold
                                          .copyWith(
                                        fontSize: 3.8 * SizeConfig.blockWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockWidth * 1.5,
                                    ),
                                    Text(
                                      listStoryController.address.value,
                                      style: AppStyles.textStyles.poppinsMedium
                                          .copyWith(
                                              fontSize:
                                                  SizeConfig.blockWidth * 3,
                                              height: 1.3,
                                              color: AppStyles.colors.bgDark
                                                  .withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.0 * SizeConfig.blockWidth,
                    ),
                    // Maps
                    (listStoryController.story.lat == null ||
                            listStoryController.story.lon == null)
                        ? const SizedBox()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0 * SizeConfig.blockWidth),
                            height: 25.0 * SizeConfig.blockHeight,
                            width: double.infinity,
                            child: GoogleMapWidget(
                              currentUserLocation: LatLng(
                                  listStoryController.story.lat!,
                                  listStoryController.story.lon!),
                              onMapCreated: (controller) {
                                viewModel.controller.complete(controller);
                              },
                            ),
                          )
                  ],
                ),
              )),
      ),
    );
  }
}
