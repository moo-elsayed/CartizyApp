import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/feature/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import 'package:cartizy_app_nti/feature/profile/presentation/widgets/image_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/helpers/validator.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/text_form_field_helper.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required this.user});

  final UserResponseEntity user;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(30.h),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                          current is UploadImageSuccess,
                      builder: (context, state) {
                        XFile? photo = context.read<ProfileCubit>().photo;
                        return CircleAvatar(
                          radius: 75.r,
                          backgroundImage: photo != null
                              ? FileImage(File(photo.path))
                              : CachedNetworkImageProvider(widget.user.avatar),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 2.h,
                      right: 4.w,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return ImageBottomSheet(
                                onTap: (imageSource) {
                                  context.pop();
                                  context
                                      .read<ProfileCubit>()
                                      .selectAndUploadImage(imageSource);
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: ColorsManager.white,
                          ),
                          child: Icon(CupertinoIcons.camera, size: 20.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(47.h),
              Text('Name', style: TextStylesManager.font18color212121Regular),
              Gap(8.h),
              TextFormFieldHelper(
                controller: _nameController,
                onValidate: Validator.validateName,
                hint: 'Enter your name',
                keyboardType: TextInputType.name,
                action: TextInputAction.next,
                borderRadius: BorderRadius.circular(8.r),
              ),
              Gap(16.h),
              Text('Email', style: TextStylesManager.font18color212121Regular),
              Gap(8.h),
              TextFormFieldHelper(
                controller: _emailController,
                onValidate: Validator.validateEmail,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                action: TextInputAction.next,
                borderRadius: BorderRadius.circular(8.r),
              ),
              Gap(16.h),
              Text(
                'Password',
                style: TextStylesManager.font18color212121Regular,
              ),
              Gap(8.h),
              TextFormFieldHelper(
                controller: _passwordController,
                onValidate: Validator.validatePassword,
                hint: 'Enter your password',
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                action: TextInputAction.next,
                borderRadius: BorderRadius.circular(8.r),
              ),
              Gap(100.h),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    current is UpdateProfileLoading ||
                    current is UpdateProfileSuccess ||
                    current is UpdateProfileFailure,
                builder: (context, state) {
                  return CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().updateProfile(
                          email: _emailController.text,
                          name: _nameController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                    text: 'Submit',
                    maxWidth: true,
                    textStyle: TextStylesManager.font16WhiteMedium,
                    color: ColorsManager.color212121,
                    padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
                    borderRadius: BorderRadius.circular(8.r),
                    isLoading: state is UpdateProfileLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
