import 'package:cartizy_app_nti/feature/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theming/styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileSuccess) {
              return Center(child: Text(state.user.name));
            } else if (state is GetProfileFailure) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ),
      ],
    );
  }
}
