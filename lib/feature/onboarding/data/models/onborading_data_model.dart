import 'package:cartizy_app_nti/core/helpers/app_assets.dart';

class OnboardingDataModel {
  final String title;
  final String description;
  final String image;

  OnboardingDataModel({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OnboardingDataModel> onboardingList = [
    OnboardingDataModel(
      title: 'Discover Trends',
      description: 'Now we are here to provide variety of the best fashion',
      image: AppAssets.onboarding1Image,
    ),
    OnboardingDataModel(
      title: 'Latest out fit',
      description: 'Express your self through the art of the fashionism',
      image: AppAssets.onboarding2Image,
    ),
  ];
}
