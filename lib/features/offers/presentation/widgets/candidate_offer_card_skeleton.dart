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
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 20.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Skeletonizer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bone.text(words: 3, style: TextStyle(fontSize: 18.sp)),
                        Gap(4.h),
                        Bone.text(words: 4, style: TextStyle(fontSize: 13.sp)),
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
            Gap(14.h),
            Skeletonizer(
              child: Bone(
                width: double.infinity,
                height: 48.h,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Gap(12.h),
            Skeletonizer(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  Bone(
                    width: 120.w,
                    height: 32.h,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  Bone(
                    width: 140.w,
                    height: 32.h,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ],
              ),
            ),
            Gap(14.h),
            Divider(height: 1.h, color: context.themeCardBorder),
            Gap(12.h),
            Row(
              children: [
                Expanded(
                  child: Skeletonizer(
                    child: Wrap(
                      spacing: 16.w,
                      runSpacing: 6.h,
                      children: [
                        Bone(
                          width: 110.w,
                          height: 14.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        Bone(
                          width: 120.w,
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
                    width: 96.w,
                    height: 36.h,
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
