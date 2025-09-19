import 'package:cartizy_app_nti/feature/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeAppBar(),

          SizedBox(height: 5),

          //! getCategories
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
