import 'dart:developer';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/home_cubit/home_cubit.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/home_app_bar.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../widgets/products_grid_view.dart';

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
  List<int> categoriesIds = [];

  void _initTabController(GetAllCategoriesSuccess state) {
    _tabController = TabController(
      length: state.categories.length,
      vsync: this,
    );

    isTabControllerInitialized = true;

    _tabController.animation!.addListener(() {
      final newIndex = _tabController.animation!.value.round();
      if (newIndex != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = newIndex;
          _getProducts();
        });
      }
    });
  }

  void _getProducts() {
    if (context
            .read<HomeCubit>()
            .categoryProducts[categoriesIds[_selectedTabIndex]] ==
        null) {
      context.read<HomeCubit>().getProductsByCategory(
        categoriesIds[_selectedTabIndex],
      );
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
            if (state is GetAllCategoriesSuccess) {
              categoriesIds = state.categories.map((e) => e.id).toList();
              _getProducts();
              if (!isTabControllerInitialized) {
                _initTabController(state);
              }
            }
          },
          buildWhen: (previous, current) {
            return current is GetAllCategoriesSuccess ||
                current is GetAllCategoriesFailure ||
                current is GetAllCategoriesLoading;
          },
          builder: (context, state) {
            if (state is GetAllCategoriesSuccess) {
              return TabContainerWidget(
                categories: state.categories,
                tabController: _tabController,
                selectedTabIndex: _selectedTabIndex,
              );
            } else if (state is GetAllCategoriesLoading) {
              return const CupertinoActivityIndicator();
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
                current is GetProductsByCategoryLoading;
          },
          builder: (context, state) {
            if (state is GetProductsByCategorySuccess) {
              return Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(_tabController.length, (index) {
                    final categoryId = categoriesIds[index];
                    final products =
                        context
                            .read<HomeCubit>()
                            .categoryProducts[categoryId] ??
                        [];
                    return ProductsGridView(products: products);
                  }),
                ),
              );
            } else if (state is GetProductsByCategoryLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
