import 'package:flutter/material.dart';
import 'package:project_init/constants/app_colors.dart';

class RangeSelector extends StatefulWidget {
  const RangeSelector({super.key});

  @override
  State<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  RangeValues rangeValues = const RangeValues(0, 1750);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          activeColor: AppColors.black,
          inactiveColor: Colors.grey.withOpacity(0.5),
          max: 1750,
          values: rangeValues,
          onChanged: (value) {
            setState(() {
              rangeValues = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              r'$0',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '\$${rangeValues.start.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16, color: AppColors.black),
            ),
            Text(
              '\$${rangeValues.end.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16, color: AppColors.black),
            ),
            const Text(
              r'$1750',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
