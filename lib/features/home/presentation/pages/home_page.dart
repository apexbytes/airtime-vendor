import 'package:antelope/features/auth/presentation/components/balance_card.dart';
import 'package:antelope/features/auth/presentation/components/drawer.dart';
import 'package:antelope/features/auth/presentation/components/main_actions_card.dart';
import 'package:antelope/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antelope/features/auth/presentation/pages/help_page.dart';
import 'package:antelope/features/auth/presentation/pages/profile_page.dart';
import 'package:antelope/features/auth/presentation/pages/settings_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:antelope/features/auth/domain/entities/transaction.dart';
import 'package:antelope/features/auth/presentation/components/recent_transactions_list.dart';
import 'package:antelope/features/auth/presentation/pages/sell_airtime_page.dart';
import 'package:antelope/features/auth/presentation/pages/transfer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  void goToSettingsPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  void goToHelpPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
  }

  // Page controller
  final _pageController = PageController();

  // Updated mainActions to include navigation logic
  late final List<Map<String, dynamic>> mainActions;

  final List<Transaction> _recentTransactions = [
    Transaction(
      type: TransactionType.airtimeSale,
      dateTime: DateTime.now().subtract(const Duration(hours: 1)),
      amount: 10.00,
      currency: 'USD',
      serviceProvider: 'NetOne',
    ),
    Transaction(
      type: TransactionType.airtimeTransfer,
      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      amount: 5.50,
      currency: 'ZWL',
      recipient: '077XXXXXXX',
    ),
    Transaction(
      type: TransactionType.airtimeSale,
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      amount: 2.00,
      currency: 'USD',
      serviceProvider: 'Econet',
    ),
    Transaction(
      type: TransactionType.airtimeTransfer,
      dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
      amount: 1500.00,
      currency: 'ZWL',
      recipient: '071XXXXXXX',
    ),
  ];

  @override
  void initState() {
    super.initState();
    mainActions = [
      {
        "label": "Transfer Airtime",
        "icon": Icons.send,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TransferPage()),
          );
        },
      },
      {
        "label": "Sell Airtime",
        "icon": Icons.request_page,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SellAirtimePage()),
          );
        },
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("D a v e  B u d a h"),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSettingsTap: goToSettingsPage,
          onHelpTap: goToHelpPage,
          onLogoutTap: () {
            Navigator.pop(context);
            final authCubit = context.read<AuthCubit>();
            authCubit.logout();
          },
        ),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    children: const [
                      BalanceCard(
                        serviceProvider: 'NetOne',
                        usdBalance: 17.00,
                        zwlBalance: 6141.25,
                        initialCurrency: 'USD',
                      ),
                      BalanceCard(
                        serviceProvider: 'Econet',
                        usdBalance: 25.50,
                        zwlBalance: 9211.88,
                        initialCurrency: 'ZWL',
                      ),
                      BalanceCard(
                        serviceProvider: 'Telecel',
                        usdBalance: 5.00,
                        zwlBalance: 1806.25,
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 16),

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

              // Recent Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    "R e c e n t  T r a n s a c t i o n s",
                    style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )
              ),
              const SizedBox(height: 0.5),
              Expanded(
                child: RecentTransactionsList(transactions: _recentTransactions),
              )
            ]
          ),
        )
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
