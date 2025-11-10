import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/modules/loans/loanRequestSent/views/loan_request_sent_details_view.dart';
import 'package:kiwoo/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/models/notifications/notification_model.dart';
import '../../loans/loanRequestSent/bindings/loan_request_sent_binding.dart';
import '../../loans/loanRequestSent/views/loan_request_offers_view.dart';

class NotificationsController extends GetxController with DefController {
  RxList<NotificationModel> get notificationList =>
      firebaseService.notifications;
  void callaction(int notificationIndex) {
    var notifcation = notificationList[notificationIndex];
    action(notifcation);
    notifcation.read = true;
    notificationList.refresh();
  }

  static void action(NotificationModel notification) {
    var data = notification.data;
    switch (notification.type) {
      case NotificationType.chat:
      case NotificationType.loanRequest:
      case NotificationType.loanOfferAccepted:
      case NotificationType.loanOfferRejected:
        Get.toNamed(Routes.LOAN_REQUEST_RECEIVED, arguments: data);
        break;
      case NotificationType.newLoanOffer:
        if (data == null || data['loan_id'] == null) return;
        Get.to(
          () => LoanRequestOffersView(int.parse(data['loan_id'])),
          binding: LoanRequestSentBinding(),
        );
        break;
      case NotificationType.loanAcceted:
        if (data == null || data['loan_id'] == null) return;
        Get.to(
          () => const LoanRequestSentDetailsView(),
          binding: LoanRequestSentBinding(),
          arguments: data,
        );

      case NotificationType.cashin:
      case NotificationType.cashout:
      case NotificationType.unKnow:
    }
  }
}
