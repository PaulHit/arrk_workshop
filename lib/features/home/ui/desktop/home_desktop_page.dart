import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:arrk_workshop/models/house_model.dart';
import 'package:arrk_workshop/utils/common/constants.dart';
import 'package:arrk_workshop/utils/widgets/custom_button.dart';
import '../mobile/filter_widget.dart';
import '../mobile/house_ad_widget.dart';

class HomeDesktopPage extends StatefulWidget {
  @override
  State<HomeDesktopPage> createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends State<HomeDesktopPage> {
  final filterList = ['<\$100.000', '1 bedroom', '2 bedrooms', '2 bathrooms'];

  String activeFilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 50),
            child: Row(
              children: [
                CustomButtonWidget(
                  icon: Icons.menu,
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Imobiliare',
                      style: GoogleFonts.manrope(
                        fontSize: 36,
                        color: ColorConstant.kBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CustomButtonWidget(
                    icon: Icons.refresh,
                    iconColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'City',
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: ColorConstant.kGreyColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Cluj-Napoca',
            style: GoogleFonts.manrope(
              fontSize: 36,
              color: ColorConstant.kBlackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(color: ColorConstant.kGreyColor, thickness: 0.2),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Filters:',
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filterList
                          .map((filter) => FilterWidget(
                                filterTxt: filter,
                                isActive: activeFilter == filter,
                                onBtnTap: () {
                                  setState(() {
                                    activeFilter =
                                        activeFilter == filter ? '' : filter;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: Constants.houseList.length,
              itemBuilder: (context, index) {
                House house = Constants.houseList[index];
                return isFiltered(house.price, house.bedrooms, house.bathrooms)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: HouseAdWidget(
                          house: house,
                          imgPathIndex: index,
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isFiltered(price, bedrooms, bathrooms) {
    if (activeFilter.isEmpty) return true;
    if (activeFilter.contains('bedroom')) {
      if (activeFilter[0] == '1' && bedrooms == 1) {
        return true;
      } else if (activeFilter[0] == '2' && bedrooms == 2) {
        return true;
      }
    }
    if (activeFilter.contains('bath')) {
      if (activeFilter[0] == '1' && bathrooms == 1) {
        return true;
      } else if (activeFilter[0] == '2' && bathrooms == 2) {
        return true;
      }
    }
    if (activeFilter.contains('\$')) {
      if (price < 100000) {
        return true;
      }
    }
    return false;
  }
}
