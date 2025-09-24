import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({super.key, required this.onTap});

  final Function(ImageSource imageSource) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: ShapeDecoration(
              color: Colors.grey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(ImageSource.camera),
            child: const ListTile(
              leading: Icon(Icons.camera_alt_outlined, color: Colors.blue),
              title: Text('From camera'),
            ),
          ),
          Divider(endIndent: 15.w, indent: 15.w),
          GestureDetector(
            onTap: () => onTap(ImageSource.gallery),
            child: const ListTile(
              leading: Icon(Icons.photo_library_outlined, color: Colors.green),
              title: Text('From gallery'),
            ),
          ),
        ],
      ),
    );
  }
}
