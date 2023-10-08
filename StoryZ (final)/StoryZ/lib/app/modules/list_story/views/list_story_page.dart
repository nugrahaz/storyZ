import 'package:delayed_widget/delayed_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/list_story/controllers/list_story_controller.dart';
import 'package:storyz/app/modules/main_page/controllers/home_controller.dart';
import 'package:storyz/app/utils/utils.dart';

class ListStoryPage extends StatefulWidget {
  const ListStoryPage({super.key});

  @override
  State<ListStoryPage> createState() => _ListStoryPageState();
}

class _ListStoryPageState extends State<ListStoryPage> {
  final HomeController homeController = HomeController.to;
  final ListStoryController stateList = Get.put(ListStoryController());

  // final Future myFuture = ApiService()
  //     .getListStory(token: StorageServices().getUserInfo().token.toString());

  //
  late ScrollController scrollController;

  Future onRefresh() async {
    stateList.refreshData();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll) {
      stateList.getList();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();
    stateList.getList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(onScroll);
    return Obx(
      () => AnimatedContainer(
          transform: Matrix4.translationValues(
              homeController.xOffset, homeController.yOffset, 0)
            ..scale(homeController.getDrawerIsOpen ? 0.85 : 1.00)
            ..rotateZ(homeController.getDrawerIsOpen ? -50 : 0),
          duration: const Duration(milliseconds: 230),
          decoration: BoxDecoration(
              borderRadius: homeController.getDrawerIsOpen
                  ? BorderRadius.circular(24)
                  : BorderRadius.circular(0),
              color: Colors.white),
          child: Container(
            margin: EdgeInsets.only(
              top: 4.0 * SizeConfig.blockWidth,
              left: SizeConfig.blockWidth * 6,
              right: SizeConfig.blockWidth * 6,
            ),
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: stateList.hasMore.value
                          ? stateList.listStory.length + 1
                          : stateList.listStory.length,
                      itemBuilder: (context, index) {
                        if (index < stateList.listStory.length) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                    AppRoutes.detailStoriesPage,
                                    extra: stateList.listStory[index].id
                                        .toString());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 4.0 * SizeConfig.blockWidth),
                                height: 60.0 * SizeConfig.blockWidth,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppStyles.colors.bgDark,
                                        width: 2)),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: ExtendedImage.network(
                                          stateList.listStory[index].photoUrl
                                              .toString(),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      AppStyles.colors.bgDark,
                                                  width: 2)),
                                          fit: BoxFit.fitWidth,
                                          width: double.infinity,
                                          cache: true,
                                          cacheRawData: true,
                                          clearMemoryCacheIfFailed: true,
                                          clearMemoryCacheWhenDispose: true,
                                          enableMemoryCache: true,
                                          loadStateChanged:
                                              (ExtendedImageState state) {
                                            switch (
                                                state.extendedImageLoadState) {
                                              case LoadState.loading:
                                                return const Center(
                                                    child: Text("-"));

                                              case LoadState.completed:
                                                return GestureDetector(
                                                  onTap: () {
                                                    context.pushNamed(
                                                        AppRoutes
                                                            .detailStoriesPage,
                                                        extra: stateList
                                                            .listStory[index].id
                                                            .toString());

                                                    // Get.toNamed(
                                                    //     AppRoutes
                                                    //         .detailStoriesPage,
                                                    //     arguments: story.id);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: AppStyles
                                                            .colors.white,
                                                        shape: BoxShape.circle),
                                                    child: ExtendedRawImage(
                                                      fit: BoxFit.fitWidth,
                                                      image: state
                                                          .extendedImageInfo
                                                          ?.image,
                                                    ),
                                                  ),
                                                );

                                              case LoadState.failed:
                                                return GestureDetector(
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.0 *
                                                                  SizeConfig
                                                                      .blockWidth),
                                                      child: Text(
                                                        "Load failed",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppStyles
                                                                .colors.bgDark),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    state.reLoadImage();
                                                  },
                                                );
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            2.0 * SizeConfig.blockWidth),
                                        child: Center(
                                          child: Text(
                                            stateList.listStory[index].name
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 4.5 *
                                                    SizeConfig.blockWidth),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                      }),
                ),
                DelayedWidget(
                  delayDuration: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(seconds: 1),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if (homeController.getDrawerIsOpen == true) {
                          homeController.drawerIsOpen(
                              false,
                              AppStyles.colors.transparent,
                              AppStyles.colors.white);
                        } else {
                          homeController.drawerIsOpen(
                            true,
                            AppStyles.colors.transparent,
                            AppStyles.colors.bgDark,
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 7.5 * SizeConfig.blockWidth),
                        padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
                        // height: SizeConfig.blockWidth * 15,
                        decoration: BoxDecoration(
                            color: AppStyles.colors.bgDark,
                            shape: BoxShape.circle),
                        child: Icon(
                          homeController.getDrawerIsOpen == false
                              ? Icons.menu
                              : Icons.close_sharp,
                          color: AppStyles.colors.white,
                          size: SizeConfig.blockWidth * 9,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
//
// FutureBuilder<dynamic>(
//   future: myFuture,
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//           child: SpinKitWave(
//         size: SizeConfig.blockWidth * 6,
//         color: AppStyles.colors.bgDark,
//       ));
//     } else if (snapshot.hasError) {
//       return Center(child: Text('Error: ${snapshot.error}'));
//     } else if (snapshot.hasData) {
//       final List<ListStory> stories = snapshot.data!;
//       return ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         padding:
//             EdgeInsets.only(top: SizeConfig.blockWidth * 6),
//         // itemCount: 3,
//         itemCount: stories.length,
//         itemBuilder: (context, index) {
//           final story = stories[index];
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: GestureDetector(
//               onTap: () {
//                 GoRouter.of(context).pushNamed(
//                     AppRoutes.detailStoriesPage,
//                     extra: story.id);
//               },
//               child: Container(
//                 margin: EdgeInsets.only(
//                     bottom: 4.0 * SizeConfig.blockWidth),
//                 height: 60.0 * SizeConfig.blockWidth,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                         color: AppStyles.colors.bgDark,
//                         width: 2)),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Flexible(
//                         child: ExtendedImage.network(
//                           story.photoUrl.toString(),
//                           border: Border(
//                               bottom: BorderSide(
//                                   color:
//                                       AppStyles.colors.bgDark,
//                                   width: 2)),
//                           fit: BoxFit.fitWidth,
//                           width: double.infinity,
//                           cache: true,
//                           cacheRawData: true,
//                           clearMemoryCacheIfFailed: true,
//                           clearMemoryCacheWhenDispose: true,
//                           enableMemoryCache: true,
//                           loadStateChanged:
//                               (ExtendedImageState state) {
//                             switch (
//                                 state.extendedImageLoadState) {
//                               case LoadState.loading:
//                                 return const Center(
//                                     child: Text("-"));
//
//                               case LoadState.completed:
//                                 return GestureDetector(
//                                   onTap: () {
//                                     context.pushNamed(
//                                         AppRoutes
//                                             .detailStoriesPage,
//                                         extra: story.id);
//
//                                     // Get.toNamed(
//                                     //     AppRoutes
//                                     //         .detailStoriesPage,
//                                     //     arguments: story.id);
//                                   },
//                                   child: Container(
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                         color: AppStyles
//                                             .colors.white,
//                                         shape: BoxShape.circle),
//                                     child: Hero(
//                                       tag: story.id.toString(),
//                                       child: ExtendedRawImage(
//                                         fit: BoxFit.fitWidth,
//                                         image: state
//                                             .extendedImageInfo
//                                             ?.image,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//
//                               case LoadState.failed:
//                                 return GestureDetector(
//                                   child: Center(
//                                     child: Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(
//                                               horizontal: 2.0 *
//                                                   SizeConfig
//                                                       .blockWidth),
//                                       child: Text(
//                                         "Load failed",
//                                         textAlign:
//                                             TextAlign.center,
//                                         style: TextStyle(
//                                             fontWeight:
//                                                 FontWeight.bold,
//                                             color: AppStyles
//                                                 .colors.bgDark),
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     state.reLoadImage();
//                                   },
//                                 );
//                             }
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(
//                             2.0 * SizeConfig.blockWidth),
//                         child: Center(
//                           child: Text(
//                             story.name.toString(),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 4.5 *
//                                     SizeConfig.blockWidth),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     } else {
//       return const Center(child: Text('No data available.'));
//     }
//   },
// ),
