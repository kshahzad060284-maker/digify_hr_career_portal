import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/features/offers/domain/config/offers_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CandidateOfferCardSkeleton extends StatelessWidget {
  const CandidateOfferCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Skeletonizer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        Bone.text(words: 3, style: TextStyle(fontSize: 20.sp)),
                        Bone.text(words: 4, style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ),
                Gap(12.w),
                Skeletonizer(
                  child: Bone(
                    width: 88.w,
                    height: 28.h,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ],
            ),
            Skeletonizer(
              child: Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: [
                  _MetaPlaceholder(width: 120.w),
                  _MetaPlaceholder(width: 110.w),
                  _MetaPlaceholder(width: 140.w),
                ],
              ),
            ),
            Divider(height: 1.h, color: context.themeCardBorder),
            Row(
              children: [
                Expanded(
                  child: Skeletonizer(
                    child: Wrap(
                      spacing: 16.w,
                      runSpacing: 4.h,
                      children: [
                        Bone(
                          width: 120.w,
                          height: 14.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        Bone(
                          width: 130.w,
                          height: 14.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(12.w),
                Skeletonizer(
                  child: Bone(
                    width: 104.w,
                    height: 40.h,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaPlaceholder extends StatelessWidget {
  const _MetaPlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Bone.circle(size: 16.w),
        Gap(4.w),
        Bone(
          width: width,
          height: 14.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }
}

class CandidateOffersListSkeleton extends StatelessWidget {
  const CandidateOffersListSkeleton({
    super.key,
    this.itemCount = OffersConfig.defaultPageSize,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24.h,
      children: [
        Skeletonizer(
          child: Bone(
            width: 120.w,
            height: 16.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (_, _) => Gap(16.h),
          itemBuilder: (_, _) => const CandidateOfferCardSkeleton(),
        ),
      ],
    );
  }
}
