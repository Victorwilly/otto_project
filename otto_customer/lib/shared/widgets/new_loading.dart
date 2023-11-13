

import 'all_package.dart';

newLoader(bool isLoading) {
  return Visibility(
      visible: isLoading,
      child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: const Loader(
                  color: AppColors.primaryColor, radius: 20))));
}