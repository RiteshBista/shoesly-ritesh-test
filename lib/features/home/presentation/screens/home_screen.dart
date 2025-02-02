import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/constants/app_images.dart';
import 'package:project_init/core/route/app_router.dart';
import 'package:project_init/features/common/app_scaffold.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/common/app_state_wrapper.dart';
import 'package:project_init/features/common/cart_widget.dart';
import 'package:project_init/features/common/shoe_container.dart';
import 'package:project_init/features/home/presentation/bloc/home_bloc.dart';
import 'package:project_init/features/product/data/model/product_model.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    brands.map(
      (e) {
        AssetImage(e.logo);
      },
    );

    BlocProvider.of<HomeBloc>(context).add(const HomeEvent.getAllproducts());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Discover',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const CartImage(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.length,
                    separatorBuilder: (context, index) =>
          20.horizontalSpacer,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => BlocProvider.of<HomeBloc>(context).add(
                        HomeEvent.getAllproducts(
                          selectedbrand: brands[index].title,
                        ),
                      ),
                      child: Text(
                        brands[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: state.selectedbrand == brands[index].title
                                  ? null
                                  : AppColors.textGrey,
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AppStateWrapper(
                    theStates: state.theStates,
                    successChild: RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<HomeBloc>(context).add(
                          HomeEvent.getAllproducts(
                            selectedbrand: state.selectedbrand,
                          ),
                        );
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 60),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) => InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => AutoRouter.of(context).push(
                            ProductRoute(product: state.products[index]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShoeContainer(product: state.products[index]),
                           10.verticalSpacer,
                              Text(
                                state.products[index].name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 12,
                                    color: AppColors.yellow,
                                  ),
                                  Text(
                                    state.products[index].rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                           5.horizontalSpacer,
                                  Text(
                                    '(${state.products[index].reviews} '
                                    'Reviews)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textGrey,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                r'$' '${state.products[index].price}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AutoRouter.of(context).push(const FilterRoute());
        },
        label: Row(
          children: [
            SvgPicture.asset(
              AppImages.filterSvg.path,
              width: 20,
            ),
         16.horizontalSpacer,
            const Text(
              'FILTER',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
