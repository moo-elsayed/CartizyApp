import 'dart:developer';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/core/widgets/custom_fading_widget.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/home_cubit/home_cubit.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/home_app_bar.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/loading/loading_tab_item_widget.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/products_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  bool isTabControllerInitialized = false;

  void _initTabController(GetAllCategoriesSuccess state) {
    if (isTabControllerInitialized) {
      _tabController.dispose();
    }
    _tabController = TabController(
      length: state.categories.length,
      vsync: this,
    );

    isTabControllerInitialized = true;

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging &&
          _tabController.index != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
          _getProducts(_selectedTabIndex);
        });
      }
    });
  }

  void _getProducts(int selectedTabIndex) {
    final categoriesIds = context.read<HomeCubit>().categoriesIds;
    if (categoriesIds.isEmpty) return;
    final int currentCategoryId = categoriesIds[selectedTabIndex];
    log('hi');
    context.read<HomeCubit>().getProductsByCategory(currentCategoryId);
  }

  void _refreshAllCategoryProducts() {
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.categoriesIds.isNotEmpty) {
      _getProducts(_selectedTabIndex);
    } else {
      log('hello');
      homeCubit.getAllCategories();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeAppBar(),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetAllCategoriesFailure) {
              AppToast.showToast(
                context: context,
                title: 'error',
                description: state.error,
                type: ToastificationType.error,
              );
              log(state.error);
            }
          },
          buildWhen: (previous, current) {
            return current is GetAllCategoriesSuccess ||
                current is GetAllCategoriesFailure ||
                current is GetAllCategoriesLoading ||
                current is HomeInitial;
          },
          builder: (context, state) {
            if (state is GetAllCategoriesSuccess) {
              if (!isTabControllerInitialized) {
                _initTabController(state);
              }
              _getProducts(_selectedTabIndex);

              return TabContainerWidget(
                categories: state.categories,
                tabController: _tabController,
                selectedTabIndex: _selectedTabIndex,
              );
            } else if (state is GetAllCategoriesLoading) {
              return SizedBox(
                height: 33.h,
                child: ListView.separated(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      const CustomFadingWidget(child: LoadingTabItemWidget()),
                  separatorBuilder: (context, index) => Gap(8.w),
                  itemCount: 5,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetProductsByCategoryFailure) {
              AppToast.showToast(
                context: context,
                title: 'Error',
                description: state.error,
                type: ToastificationType.error,
              );
            }
          },
          buildWhen: (previous, current) {
            return current is GetProductsByCategorySuccess ||
                current is GetProductsByCategoryFailure ||
                current is GetProductsByCategoryLoading ||
                current is HomeInitial;
          },
          builder: (context, state) {
            if (state is GetProductsByCategorySuccess) {
              return Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(_tabController.length, (index) {
                    final categoryId = context
                        .read<HomeCubit>()
                        .categoriesIds[index];
                    final products = context
                        .read<HomeCubit>()
                        .categoryProducts[categoryId];

                    if (products == null) {
                      return ProductsGridView(
                        loading: true,
                        onTap: (ProductEntity product) {},
                        onToggleFavorite: (ProductEntity product) {},
                      );
                    } else if (products.isEmpty) {
                      return const Center(
                        child: Text('No products found for this category'),
                      );
                    } else {
                      return ProductsGridView(
                        products: products,
                        onTap: (ProductEntity product) async {
                          var result = await context.pushNamed(
                            Routes.productView,
                            arguments: product,
                          );
                          if (result != null && result) {
                            context.read<HomeCubit>().clear();
                            _refreshAllCategoryProducts();
                          }
                        },
                        onToggleFavorite: (product) {
                          context.read<HomeCubit>().toggleFavoriteProduct(
                            product.id,
                          );
                        },
                      );
                    }
                  }),
                ),
              );
            } else if (state is GetProductsByCategoryLoading) {
              return Expanded(
                child: ProductsGridView(
                  loading: true,
                  onTap: (product) {},
                  onToggleFavorite: (ProductEntity product) {},
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
