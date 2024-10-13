import 'package:cached_network_image/cached_network_image.dart';
import 'package:eram_express/features/Common/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/AppColors.dart';
import '../../../core/utils/logger.dart';
import '../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../data/models/cargo-categoriesModel.dart';
import '../data/models/cargo-subcategoryModel.dart';
import '../presentation/views/ShippingFormCubit.dart';
import '../presentation/views/ShippingFormState.dart';
import '../presentation/widgets/top_bottom_model.dart';
/*
class SelectSubCargoCategoryModal extends StatelessWidget {
  final List<CargoSubCategoryModel> cargocategories;
  final ShippingFormCubit cubit;

  SelectSubCargoCategoryModal({
    required this.cargocategories,
    required this.cubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: cubit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TopBottomModel(),
            const Text(
              "Select the load type",
              style: TextStyle(
                color: Color(0xff191D31),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 23.4 / 20,
              ),
            ),
            const Gap(12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: cargocategories.map((cargo) {
                    return BlocSelector<ShippingFormCubit, ShippingFormState,
                        bool>(
                      selector: (state) => state.truckSize == cargo,
                      builder: (context, isSelected) {
                        return clickbottomshteetItem(
                          cargo: cargo,
                          isSelected: isSelected,
                          onTap: () {
                            cubit
                            //Navigator.of(context).pop(cargo);
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ));
  }
}

class clickbottomshteetItem extends StatelessWidget {
  final bool isSelected;
  final CargoSubCategoryModel cargo;
  final VoidCallback onTap;
  const clickbottomshteetItem({
    Key? key,
    this.isSelected = false,
    required this.onTap,
    required this.cargo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: InkWell(
          onTap: onTap,
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
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F4F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: cargo.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Column(
                    children: [
                      Text(
                        cargo.nameEn,
                        style: TextStyle(
                          color: AppColor.blacktext,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 18.2 / 20,
                        ),
                      ),
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
                  )
                ])),
          ),
        ));
  }
}
*/

class SelectSubCargoCategoryModal extends StatelessWidget {
  final ShippingFormCubit cubit;
  const SelectSubCargoCategoryModal({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: cubit,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TopBottomModel(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Select the load type",
                  style: TextStyle(
                    color: Color(0xff191D31),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 23.4 / 18,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: BlocBuilder<ShippingFormCubit, ShippingFormState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.cargoSubCategories == null) {
                      return const Center(
                          child: Text('No categories available'));
                    } else {
                      return SingleChildScrollView(
                          child: Column(
                        children: state.cargoSubCategories!.map((cargo) {
                          return BlocSelector<ShippingFormCubit,
                              ShippingFormState, bool>(
                            selector: (state) => state.truckSize == cargo,
                            builder: (context, isSelected) {
                              return ClickBottomSheetItem(
                                  imageUrl: cargo.image,
                                  isSelected: isSelected,
                                  onTap: () {
                                    Navigator.of(context).pop(cargo);
                                  },
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cargo.nameEn,
                                        style: TextStyle(
                                          color: AppColor.blacktext,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 18.2 / 20,
                                        ),
                                      ),
                                      Text(
                                        cargo.capacity.toString(),
                                        style: TextStyle(
                                          color: AppColor.ligthText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 15.2 / 14,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        }).toList(),
                      ));
                    }
                  },
                ),
              ),
            ]));
  }
}
