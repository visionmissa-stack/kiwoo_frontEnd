import 'package:KIWOO/app/modules/profile/KYC/bindings/identity_kyc_binding.dart';
import 'package:KIWOO/app/modules/profile/KYC/views/other_kyc_proof_view.dart';
import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/app_utility.dart';
import 'package:KIWOO/app/core/utils/enums.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';
import 'package:KIWOO/app/modules/profile/KYC/bindings/other_kyc_proof_binding.dart';
import 'package:KIWOO/app/modules/profile/KYC/views/identity_view.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import 'package:KIWOO/app/core/utils/font_family.dart';
import 'package:KIWOO/app/global_widgets/app_bar.dart';

import '../../../../core/utils/app_colors.dart';
import '../controllers/kyc_controller.dart';

class KycView extends GetView<KycController> {
  const KycView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.APP_BG,
        appBar: AppBarWidgetTitle(
          title: "KYC",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                child: Visibility(
                  visible: false,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 14,
                        color: FontColors.WHITE,
                        fontFamily: FontPoppins.SEMIBOLD),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Obx(
            () => ListView(
              children: [
                KYCTitle(
                  title: "Identity Proof",
                  icon: Kiwoo.address_card,
                  status: controller.getExtraInfo?.idVerified,
                  onTap: () async {
                    Get.to<Map<IdentityType, String>?>(
                      () => const IdentityView(),
                      binding: IdentityKycBinding(),
                      fullscreenDialog: true,
                    );
                  },
                ),
                verticalSpaceMedium,
                KYCTitle(
                  title: "Address Proof",
                  icon: Kiwoo.home_location,
                  status: controller.getExtraInfo?.addressVerified,
                  onTap: () {
                    Get.to(() => OtherKycProofView.address(),
                        binding: OtherKycProofBinding(),
                        fullscreenDialog: true,
                        routeName: "address_verification");
                  },
                ),
                verticalSpaceMedium,
                KYCTitle(
                  title: "Occupation Proof",
                  icon: Kiwoo.businessman,
                  status: controller.getExtraInfo?.occupationVerified,
                  onTap: () {
                    Get.to(() => const OtherKycProofView.occupation(),
                        binding: OtherKycProofBinding(),
                        fullscreenDialog: true,
                        routeName: "occupation_verification");
                  },
                ),
                verticalSpaceMedium,
                KYCTitle(
                  title: "Income Proof",
                  icon: Kiwoo.income,
                  status: controller.getExtraInfo?.incomeVerified,
                  onTap: () {
                    Get.to(() => OtherKycProofView.income(),
                        binding: OtherKycProofBinding(),
                        routeName: "income_verification");
                  },
                ),
              ],
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget KYCTitle({
    required String title,
    required IconData icon,
    VerificationStatus? status = VerificationStatus.none,
    void Function()? onTap,
  }) {
    VerificationStatus verificationStatus = status ?? VerificationStatus.none;
    String subtitle = verificationStatus.textStatus;
    IconData trailingIcon = Kiwoo.angle_right;
    if (verificationStatus.isVerified) {
      trailingIcon = Kiwoo.ok_circled2;
    }
    return Card(
      color: AppColors.PRIMARY_BG,
      child: ListTile(
        onTap: verificationStatus.isVerified || verificationStatus.isPending
            ? null
            : onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(
          icon,
          size: 40.s,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.fss,
            fontFamily: FontPoppins.SEMIBOLD,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12.fss,
            fontFamily: FontPoppins.REGULAR,
            color: verificationStatus.isPending
                ? Colors.amber
                : verificationStatus.isVerified
                    ? FontColors.PRIMARY
                    : FontColors.RED,
          ),
        ),
        trailing: verificationStatus.isVerified || verificationStatus.isPending
            ? null
            : Icon(
                trailingIcon,
                // color: AppColors.PRIMARY1,
              ),
        iconColor: AppColors.PRIMARY1,
        textColor: AppColors.PRIMARY1,
      ),
    );
  }
}
