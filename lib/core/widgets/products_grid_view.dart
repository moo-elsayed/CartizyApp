import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_fading_widget.dart';
import '../../feature/home/presentation/widgets/custom_product.dart';
import 'loading/loading_product.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, this.products, this.loading = false});

  final List<ProductEntity>? products;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30.w,
        childAspectRatio: 0.6,
      ),
      itemCount: products == null ? 8 : products!.length,
      itemBuilder: (context, index) {
        if (loading) {
          return const CustomFadingWidget(child: LoadingProduct());
        } else {
          var product = products![index];
          return CustomProduct(product: product);
        }
      },
    );
  }
}
