import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/AppColors.dart';
import '../../Common/presentation/widgets/SvgIcon.dart';
import '../data/models/cargo-categoriesModel.dart';
import '../presentation/widgets/top_bottom_model.dart';

class SelectCargoCategoryModal extends StatelessWidget {
  //final List<CargoCategoryModel> cargocategories;

  List<CargoCategoryModel> cargocategories = [
    CargoCategoryModel(
      id: 1,
      nameAr: 'فئة الشحن 1',
      nameEn: 'Cargo Category 1',
      image: 'assets/images/category1.png',
    ),
    CargoCategoryModel(
      id: 2,
      nameAr: 'فئة الشحن 2',
      nameEn: 'Cargo Category 2',
      image: 'assets/images/category2.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),
    CargoCategoryModel(
      id: 3,
      nameAr: 'فئة الشحن 3',
      nameEn: 'Cargo Category 3',
      image: 'assets/images/category3.png',
    ),

    // Add more categories as needed
  ];

  SelectCargoCategoryModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TopBottomModel(),
        const Text(
          "Choose the size of the truck",
          style: TextStyle(
            color: Color(0xff191D31),
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 23.4 / 20,
          ),
        ),
        const Gap(12),
        //هنعملها wrap ب
        //selector علشان نعرف ايه هو الي  هيبقي اخضر وايه هو الي هيبقي ابيض
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: cargocategories.map((sizeTrack) {
                return clickbottomshteetItem(
                  cargo: sizeTrack,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class clickbottomshteetItem extends StatelessWidget {
  final bool isSelected;
  final CargoCategoryModel cargo;
  const clickbottomshteetItem({
    Key? key,
    this.isSelected = false,
    required this.cargo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.green : AppColor.bordercolor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F4F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgIcon(asset: cargo.image),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    cargo.nameEn,
                    style: TextStyle(
                      color: AppColor.blacktext,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 18.2 / 20,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
