import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:project_init/features/common/app_outlined_button.dart';
import 'package:project_init/features/common/app_scaffold.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/common/custom_app_bar.dart';
import 'package:project_init/features/common/top_shadow_box_decoration.dart';

import 'package:project_init/features/order_summary/presentation/widgets/order_detail_tile.dart';
import 'package:project_init/features/order_summary/presentation/widgets/payment_option_tile.dart';
import 'package:project_init/firestore/app_firestore.dart';

@RoutePage()
class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CustomAppBar(title: 'Order Summary'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              children: [
                const Text(
                  'Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                20.verticalSpacer,
                GestureDetector(
                  onTap: () {
                    _showPaymentDialog(context);
                  },
                  child: const PaymentDetailsTile(
                    title: 'Payment Method',
                    subtitle: 'Credit Card',
                  ),
                ),
                const Divider(),
                const PaymentDetailsTile(
                  title: 'Payment Method',
                  subtitle: 'Credit Card',
                ),
                30.verticalSpacer,
                const Text(
                  'Order Detail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                20.verticalSpacer,
                const OrderDetailTile(
                  title: 'Jordan 1 Retro High Tie Dye',
                  subtitle: 'Nike . Red Grey . 40 . Qty 1',
                  price: r'$235,00',
                ),
                20.verticalSpacer,
                const OrderDetailTile(
                  title: 'Jordan 1 Retro High Tie Dye',
                  subtitle: 'Nike . Red Grey . 40 . Qty 1',
                  price: r'$235,00',
                ),
                20.verticalSpacer,
                const OrderDetailTile(
                  title: 'Jordan 1 Retro High Tie Dye',
                  subtitle: 'Nike . Red Grey . 40 . Qty 1',
                  price: r'$235,00',
                ),
                20.verticalSpacer,
                const Text(
                  'Payment Detail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                20.verticalSpacer,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: TextStyle(color: AppColors.bodyTextGrey),
                    ),
                    Text(
                      r'$705.00',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                20.verticalSpacer,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: TextStyle(color: AppColors.bodyTextGrey),
                    ),
                    Text(
                      r'$705.00',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                40.verticalSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shipping',
                      style: TextStyle(color: AppColors.bodyTextGrey),
                    ),
                    Text(
                      r'$705.00',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: boxDecorationTopShadow,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand Total',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.textGrey),
                    ),
                    Text(
                      r'$235.00',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                AppOutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order Created'),
                      ),
                    );
                    AppFirestore.orders().add({'data': 'New Order'});
                    BlocProvider.of<CartBloc>(context)
                        .add(const CartEvent.returnInitial());
                    AutoRouter.of(context).popUntil(
                      (route) => route.isFirst,
                    );
                  },
                  text: 'Payment',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Center(child: Text('Payment Method')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Select an option for payment'),
              const SizedBox(height: 20),
              const Divider(),
              _buildPaymentOption(context, 'Credit Card'),
              const Divider(),
              _buildPaymentOption(context, 'Bank Transfer'),
              const Divider(),
              _buildPaymentOption(context, 'Wallet'),
              const Divider(),
              _buildPaymentOption(context, 'Cash On Delivery'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(BuildContext context, String option) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$option selected')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          option,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
