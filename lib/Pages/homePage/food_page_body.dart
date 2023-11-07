import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/Pages/food/popular_food%20details.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/models/popular_products_model.dart';
import 'package:ecommerce/utils/app_constants.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/app%20column.dart';
import 'package:ecommerce/widgets/big_text.dart';
import 'package:ecommerce/widgets/icons_and_text.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_helper.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPage = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                // itemCount: 5,
                itemBuilder: (context, position) {
                  return _buildPageItem(position,
                      popularProducts.popularProductList[position]);
                }),
          )
              : CircularProgressIndicator(
            color: Colors.greenAccent,
          );
        }),

        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            // dotsCount: 5,
            position: _currentPage.toInt(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              )
            ],
          ),
        ),
        //list of food and images
        //recommended food page

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        RouteHelper.getRecommendedFood(index, "cartpage"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          width: Dimensions.listViewImageSize,
                          height: Dimensions.listViewImageSize,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.BASE_URL +
                                    AppConstants.UPLOAD_URL +
                                    recommendedProduct
                                        .recommendedProductList[index].img!,
                              ),
                            ),
                          ),
                        ),
                        //text section
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextCountSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                  Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: recommendedProduct
                                          .recommendedProductList[index]
                                          .name!),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                      text: 'With Natural Characteristics'),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconsAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Non-Veg",
                                          iconColor: Colors.redAccent),
                                      IconsAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.9Kms",
                                          iconColor: Colors.greenAccent),
                                      IconsAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: Colors.red)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
              : CircularProgressIndicator(
            color: Colors.greenAccent,
          );
        })
      ],
    );
  }

//
//   Widget _buildPageItem(int index, ProductModel popularProduct) {
//     Matrix4 matrix = new Matrix4.identity();
//     if (index == _currentPage.floor()) {
//       var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPage.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPage.floor() - 1) {
//       var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
//     }
//
//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Get.toNamed(RouteHelper.getPopularFood(index, "home"));
//             },
//             child: Container(
//               height: Dimensions.pageViewContainer,
//               margin: EdgeInsets.only(
//                   left: Dimensions.width10, right: Dimensions.width10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius30),
//                 color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
//                 image: DecorationImage(
//                     image: NetworkImage(
//                       AppConstants.BASE_URL +
//                           AppConstants.UPLOAD_URL +
//                           popularProduct.img!,
//                     ),
//                     fit: BoxFit.cover),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: Dimensions.pageViewTextContainer,
//               margin: EdgeInsets.only(
//                   left: Dimensions.width30,
//                   right: Dimensions.width30,
//                   bottom: Dimensions.width30),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimensions.radius20),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFFe8e8e8),
//                       blurRadius: 5.0,
//                       offset: Offset(0, 5),
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: Offset(-5, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: Offset(5, 0),
//                     ),
//                   ]),
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: Dimensions.height15,
//                     left: Dimensions.height15,
//                     right: Dimensions.height15),
//                 child: AppColumn(
//                   text: popularProduct.name!,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Widget _buildPageItem(int index, ProductModel popularProduct) {
//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currentPage.floor()) {
//       var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPage.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPage.floor() - 1) {
//       var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
//     }
//
//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Get.toNamed(RouteHelper.getPopularFood(index, "home"));
//             },
//             child: Container(
//               height: Dimensions.pageViewContainer,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width10,
//                 right: Dimensions.width10,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius30),
//                 color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     AppConstants.BASE_URL +
//                         AppConstants.UPLOAD_URL +
//                         popularProduct.img!,
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: Dimensions.pageViewTextContainer,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width30,
//                 right: Dimensions.width30,
//                 bottom: Dimensions.width30,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius20),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFFe8e8e8),
//                     blurRadius: 5.0,
//                     offset: Offset(0, 5),
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-5, 0),
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(5, 0),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.only(
//                   top: Dimensions.height15,
//                   left: Dimensions.height15,
//                   right: Dimensions.height15,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     BigText(
//                       text: popularProduct.name!,
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     SmallText(
//                       text: 'With Natural Characteristics',
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         IconsAndTextWidget(
//                           icon: Icons.circle_sharp,
//                           text: "Non-Veg",
//                           iconColor: Colors.redAccent,
//                         ),
//                         IconsAndTextWidget(
//                           icon: Icons.location_on,
//                           text: "1.9Kms",
//                           iconColor: Colors.greenAccent,
//                         ),
//                         IconsAndTextWidget(
//                           icon: Icons.access_time_rounded,
//                           text: "32min",
//                           iconColor: Colors.red,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPage.floor()) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.width30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProduct.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: 'With Natural Characteristics',
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconsAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: "Non-Veg",
                          iconColor: Colors.redAccent,
                        ),
                        IconsAndTextWidget(
                          icon: Icons.location_on,
                          text: "1.9Kms",
                          iconColor: Colors.greenAccent,
                        ),
                        IconsAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}