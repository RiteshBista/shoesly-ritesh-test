import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/review/data/model/review_model.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({required this.review, super.key});
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.buttonBorderColor,
          child: Icon(Icons.person),
        ),
        15.horizontalSpacer,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.userName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    review.time,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.textGrey),
                  ),
                ],
              ),
        5.verticalSpacer,
              RatingBar.builder(
                initialRating: review.rating,
                minRating: 1,
                allowHalfRating: true,
                itemSize: 12,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.5),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.yellow,
                ),
                ignoreGestures: true,
                onRatingUpdate: (rating) {},
              ),
        10.verticalSpacer,
              Text(
                review.review,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
