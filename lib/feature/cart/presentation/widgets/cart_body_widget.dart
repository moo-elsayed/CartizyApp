import 'package:cartizy_app_nti/feature/cart/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/custom_price.dart';
import '../../../../core/entities/product_entity.dart';

class CartBodyWidget extends StatefulWidget {
  const CartBodyWidget({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  State<CartBodyWidget> createState() => _CartBodyWidgetState();
}

class _CartBodyWidgetState extends State<CartBodyWidget> {
  late int totalPrice = widget.products
      .map((e) => e.price)
      .reduce((value, element) => value + element);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ProductItem(
                product: widget.products[index],
                onSumChanged: ({required currentSum, required previousSum}) {
                  setState(() {
                    totalPrice -= previousSum;
                    totalPrice += currentSum;
                  });
                },
              ),
              separatorBuilder: (context, index) => Gap(20.h),
              itemCount: widget.products.length,
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStylesManager.font14color212121Bold,
                    ),
                    CustomPrice(price: totalPrice),
                  ],
                ),
                Divider(
                  color: ColorsManager.colorC6C6C6,
                  endIndent: 3.w,
                  indent: 3.w,
                ),
                CustomMaterialButton(
                  onPressed: () {},
                  text: 'Checkout',
                  maxWidth: true,
                  color: ColorsManager.color212121,
                  borderRadius: BorderRadius.circular(8.r),
                  textStyle: TextStylesManager.font16WhiteMedium,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
