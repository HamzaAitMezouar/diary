import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/constants/dimensions.dart';
import 'package:diary/core/constants/text_style.dart';
import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/presentation/medicine/controllers/position_provider/position_state.dart';
import 'package:diary/widgets/info_diaog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/custom_long_button.dart';
import '../../medicine/controllers/position_provider/position_provider.dart';
import '../controllers/checkout_provider.dart';

class MakeOrderButton extends ConsumerWidget {
  const MakeOrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final position = ref.read(positionProvider);
    final checkout = ref.read(checkoutProvider);
    bool checkIfLocationisValid() {
      if (position is UserLocationState && checkout!.deliveryType == DeliveryType.home) return false;
      if (position is UserLocationState &&
          position.locationEntity.pharmacy != null &&
          checkout!.deliveryType == DeliveryType.pharmacy) return false;
      return true;
    }

    return CustomButton(
      onTap: () {
        ConfirmActionDialog().showActionDialog(
          context,
          "Confirm order",
          "Do you want to confirm this Order?",
          [
            xxsSpacer(),
            CustomButton(
              height: D.xxl,
              style: TextStyles.montserratBold15,
              backgorundColor: AppColors.turquoise.withOpacity(0.9),
              onTap: () {},
              title: "Yes",
            ),
            xxsSpacer(),
          ],
        );
      },
      isDisabled: checkIfLocationisValid(),
      title: "Order your medicament",
      style: TextStyles.montserratBold15,
      backgorundColor: AppColors.turquoise.withOpacity(0.7),
    );
  }
}
