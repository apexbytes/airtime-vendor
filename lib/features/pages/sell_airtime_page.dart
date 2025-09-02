import 'package:antelope/features/pages/recharge_voucher_page.dart';
import 'package:flutter/material.dart';

import 'package:antelope/features/auth/presentation/components/main_actions_card.dart';
import 'direct_recharge_page.dart';

class SellAirtimePage extends StatefulWidget {
  const SellAirtimePage({super.key});

  @override
  State<SellAirtimePage> createState() => _SellAirtimePageState();
}

class _SellAirtimePageState extends State<SellAirtimePage> {
  late final List<Map<String, dynamic>> mainActions;

  @override
  void initState() {
    super.initState();
    mainActions = [
      {
        "label": "Direct Recharge",
        "icon": Icons.currency_exchange_outlined,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DirectRechargePage()),
          );
        },
      },
      {
        "label": "Recharge Voucher",
        "icon": Icons.receipt_outlined,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RechargeVoucherPage()),
          );
        },
      }
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S e l l  A i r t i m e"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.builder(
                  itemCount: mainActions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final action = mainActions[index];
                    return MainActionCard(
                      actionCardLabel: action["label"] as String,
                      actionCardIcon: action["icon"] as IconData,
                      onTap: action["onTap"] as void Function()?,
                    );
                  }),
            ],
      )
      ),
    );
  }
}
