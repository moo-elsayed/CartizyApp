import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/feature/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_dialogs.dart';
import '../widgets/profile_body.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(12.h),
        Align(
          alignment: Alignment.center,
          child: Text(
            'My Profile',
            style: TextStylesManager.font22RobotoColor212121SemiBold,
          ),
        ),
        Gap(12.h),
        Expanded(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is UploadImageLoading) {
                AppDialogs.showLoadingDialog(context);
              } else if (state is UploadImageFailure ||
                  state is UpdateProfileFailure) {
                if (state is UploadImageFailure) {
                  context.pop();
                }
                AppToast.showToast(
                  context: context,
                  title: state is UploadImageFailure
                      ? state.errorMessage
                      : (state as UpdateProfileFailure).errorMessage,
                  type: ToastificationType.error,
                );
              }
              if (state is UploadImageSuccess) {
                context.pop();
                AppToast.showToast(
                  context: context,
                  title: 'Image uploaded successfully',
                  type: ToastificationType.success,
                );
              }
              if (state is UpdateProfileSuccess) {
                AppToast.showToast(
                  context: context,
                  title: 'Profile updated successfully',
                  type: ToastificationType.success,
                );
              }
            },
            buildWhen: (previous, current) =>
                current is GetProfileSuccess ||
                current is GetProfileFailure ||
                current is GetProfileLoading,
            builder: (context, state) {
              if (state is GetProfileSuccess) {
                return ProfileBody(
                  user:
                      context.read<ProfileCubit>().user ??
                      const UserResponseEntity(),
                );
              } else if (state is GetProfileFailure) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
