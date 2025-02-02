import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/features/common/app_outlined_button.dart';
import 'package:project_init/features/common/app_scaffold.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/common/custom_app_bar.dart';
import 'package:project_init/features/common/top_shadow_box_decoration.dart';
import 'package:project_init/features/filter/presentation/widgets/color_selection_widget.dart';
import 'package:project_init/features/filter/presentation/widgets/range_selector.dart';
import 'package:project_init/features/filter/presentation/widgets/selectable_container.dart';
import 'package:project_init/features/product/data/model/product_model.dart';

@RoutePage()
class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CustomAppBar(title: 'Filter'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Brands',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
     20.verticalSpacer,
                SizedBox(
                  height: 106,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.backgroundGrey,
                            radius: 25,
                            child: Image.asset(
                              brands[index].logo,
                              width: 24,
                            ),
                          ),
                       10.verticalSpacer,
                          Text(
                            brands[index].title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            '1001 Items',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.bodyTextGrey),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) =>
               10.horizontalSpacer,
                    itemCount: brands.length,
                  ),
                ),
      30.verticalSpacer,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Range',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
               20.verticalSpacer,
                      const RangeSelector(),
              30.verticalSpacer,
                      Text(
                        'Sort By',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
               20.verticalSpacer,
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => filterList[index],
                    separatorBuilder: (context, index) =>
               10.horizontalSpacer,
                    itemCount: filterList.length,
                  ),
                ),
       30.verticalSpacer,
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Gender',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
         20.verticalSpacer,
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => filterList[index],
                    separatorBuilder: (context, index) =>
            10.horizontalSpacer,
                    itemCount: filterList.length,
                  ),
                ),
          30.verticalSpacer,
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Color',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
            20.verticalSpacer,
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => colorSelections[index],
                    separatorBuilder: (context, index) =>
               10.horizontalSpacer,
                    itemCount: filterList.length,
                  ),
                ),
      10.verticalSpacer,
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            decoration: boxDecorationTopShadow,
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton.white(
                    text: 'RESET (4)',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
             15.horizontalSpacer,
                Expanded(
                  child: AppOutlinedButton(
                    text: 'APPLY',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const List<SelectableContainer> filterList = [
  SelectableContainer(
    isSelected: true,
    title: 'Most recent',
  ),
  SelectableContainer(
    isSelected: false,
    title: 'Popular',
  ),
  SelectableContainer(
    isSelected: false,
    title: 'Recommended',
  ),
  SelectableContainer(
    isSelected: false,
    title: 'Trending',
  ),
  SelectableContainer(
    isSelected: false,
    title: 'New',
  ),
];

const colorSelections = [
  ColorSelectionWidget(
    isSelected: true,
    title: 'Red',
    color: Colors.red,
  ),
  ColorSelectionWidget(
    isSelected: false,
    title: 'Green',
    color: Colors.green,
  ),
  ColorSelectionWidget(
    isSelected: false,
    title: 'Blue',
    color: Colors.blue,
  ),
  ColorSelectionWidget(
    isSelected: false,
    title: 'Yellow',
    color: Colors.yellow,
  ),
  ColorSelectionWidget(
    isSelected: false,
    title: 'Purple',
    color: Colors.purple,
  ),
];
