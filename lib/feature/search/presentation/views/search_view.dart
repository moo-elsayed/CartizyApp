import 'dart:async';
import 'package:cartizy_app_nti/core/helpers/app_assets.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/widgets/text_form_field_helper.dart';
import 'package:cartizy_app_nti/feature/search/presentation/managers/search_cubit/search_cubit.dart';
import 'package:cartizy_app_nti/feature/search/presentation/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/widgets/app_toasts.dart';
import '../../../../core/widgets/products_grid_view.dart';
import '../widgets/search_placeholder_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;
  Timer? _debounce;

  void _buildOnChanged(String? text) {
    if (text != null && text.trim().isNotEmpty) {
      _search(text);
    } else {
      setState(() {});
    }
  }

  void _search(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (_searchController.text.trim() == query.trim() && query.isNotEmpty) {
        context.read<SearchCubit>().searchProducts(query);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return TextFormFieldHelper(
                      controller: _searchController,
                      hint: 'Search for your products',
                      prefixIcon: SvgPicture.asset(
                        AppAssets.iconSearch,
                        height: 24.h,
                        width: 24.w,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: EdgeInsets.all(12.r),
                      borderRadius: BorderRadius.circular(10.r),
                      borderColor: ColorsManager.color212121,
                      action: TextInputAction.search,
                      onChanged: _buildOnChanged,
                      suffixWidget: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color: ColorsManager.color6E6A7C,
                                size: 22.r,
                              ),
                            )
                          : null,
                    );
                  },
                ),
              ),

              BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state is SearchFailure) {
                    AppToast.showToast(
                      context: context,
                      title: 'Error',
                      description: state.errorMessage,
                      type: ToastificationType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (_searchController.text.isEmpty) {
                    return const SearchPlaceholderWidget(
                      text: 'search for products',
                    );
                  } else {
                    if (state is SearchSuccess) {
                      if (state.products.isEmpty) {
                        return const SearchPlaceholderWidget(
                          text: 'No products found',
                        );
                      } else {
                        return Expanded(
                          child: ProductsGridView(
                            products: state.products,
                            onTap: (product) {
                              context.pushNamed(
                                Routes.productView,
                                arguments: product,
                              );
                            },
                            onToggleFavorite: (product) {
                              // context.read<FavoriteCubit>().toggleFavorite(
                              //   product.id,
                              // );
                            },
                          ),
                        );
                      }
                    } else if (state is SearchLoading) {
                      return Expanded(
                        child: ProductsGridView(
                          loading: true,
                          onTap: (product) {},
                          onToggleFavorite: (ProductEntity product) {},
                        ),
                      );
                    } else {
                      return const SearchPlaceholderWidget(
                        text: 'Error, please try again later',
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
