import 'package:otto_customer/shared/utils/assets.dart';

class NavigationModel {
  const NavigationModel(this.index, this.title, this.icon, this.activeIcon);
  final int index;
  final String title;
  final String icon;
  final String activeIcon;
}

List<NavigationModel> navigationModel = <NavigationModel>[
  const NavigationModel(
    0,
    'Home',
    SvgAssets.home,
    SvgAssets.homeActive,
  ),
  const NavigationModel(
      1, 'Gift Cards', SvgAssets.giftCards, SvgAssets.giftCardsActive),
  const NavigationModel(
      2, 'Loyalty', SvgAssets.loyalty, SvgAssets.loyaltyActive),
  const NavigationModel(
      3, 'Transactions', SvgAssets.transactions, SvgAssets.transactionsActive),
];
