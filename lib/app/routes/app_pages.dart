import 'package:get/get.dart';

import '../data/middleware/auth_gard.dart';
import '../data/middleware/transaction_middleware.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/list_chat_view.dart';
import '../modules/connection/bindings/connection_binding.dart';
import '../modules/connection/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/connection/forgetPassword/views/forget_password_view.dart';
import '../modules/connection/login/bindings/login_binding.dart';
import '../modules/connection/login/views/login_view.dart';
import '../modules/connection/register/bindings/register_binding.dart';
import '../modules/connection/register/views/register_view.dart';
import '../modules/connection/views/connection_view.dart';
import '../modules/customInAppBrowser/bindings/custom_in_app_browser_binding.dart';
import '../modules/customInAppBrowser/views/custom_in_app_browser_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kiwoo/about/bindings/about_binding.dart';
import '../modules/kiwoo/about/views/about_view.dart';
import '../modules/kiwoo/bindings/app_info_binding.dart';
import '../modules/kiwoo/helpCenter/bindings/help_center_binding.dart';
import '../modules/kiwoo/helpCenter/views/help_center_view.dart';
import '../modules/kiwoo/privacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/kiwoo/privacyPolicy/views/privacy_policy_view.dart';
import '../modules/kiwoo/termsOfUse/bindings/terms_of_use_binding.dart';
import '../modules/kiwoo/termsOfUse/views/terms_of_use_view.dart';
import '../modules/kiwoo/views/kiwoo_view.dart';
import '../modules/loans/bindings/loans_binding.dart';
import '../modules/loans/loanGiven/bindings/loan_given_binding.dart';
import '../modules/loans/loanGiven/views/loan_given_view.dart';
import '../modules/loans/loanReceived/bindings/loan_received_binding.dart';
import '../modules/loans/loanReceived/views/loan_received_view.dart';
import '../modules/loans/loanRequestReceived/bindings/loan_request_received_binding.dart';
import '../modules/loans/loanRequestReceived/views/loan_request_received_view.dart';
import '../modules/loans/loanRequestSent/bindings/loan_request_sent_binding.dart';
import '../modules/loans/loanRequestSent/views/loan_request_sent_view.dart';
import '../modules/loans/market/bindings/market_binding.dart';
import '../modules/loans/market/views/market_view.dart';
import '../modules/loans/requestLoan/bindings/request_loan_binding.dart';
import '../modules/loans/requestLoan/views/request_loan_view.dart';
import '../modules/loans/views/loans_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/KYC/bindings/kyc_binding.dart';
import '../modules/profile/KYC/views/kyc_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/changePassword/bindings/change_password_binding.dart';
import '../modules/profile/changePassword/views/change_password_view.dart';
import '../modules/profile/views/profil_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/cashIn/bindings/cash_in_binding.dart';
import '../modules/transactions/cashIn/views/cash_in_view.dart';
import '../modules/transactions/TransactionReceipt/bindings/transaction_receipt_binding.dart';
import '../modules/transactions/TransactionReceipt/views/transaction_receipt_view.dart';
import '../modules/transactions/cashout/bindings/cashout_binding.dart';
import '../modules/transactions/cashout/views/cashout_view.dart';
import '../modules/transactions/receiveMoney/bindings/receive_money_binding.dart';
import '../modules/transactions/receiveMoney/views/receive_money_view.dart';
import '../modules/transactions/sendMoney/bindings/send_money_binding.dart';
import '../modules/transactions/sendMoney/views/send_money_view.dart';
import '../modules/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.CONNECTION,
      page: () => const ConnectionView(),
      binding: ConnectionBinding(),
      middlewares: [AuthGard()],
      children: [
        GetPage(
            name: _Paths.LOGIN,
            page: () => const LoginView(),
            binding: LoginBinding(),
            middlewares: [AuthGard()],
            participatesInRootNavigator: false),
        GetPage(
          name: _Paths.REGISTER,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: _Paths.FORGET_PASSWORD,
          page: () => const ForgetPasswordView(),
          binding: ForgetPasswordBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      bindings: [
        LoansBinding(),
        MarketBinding(),
        ChatBinding(),
        ProfileBinding(),
        PrivacyPolicyBinding(),
      ],
      middlewares: [AuthGard()],
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
      middlewares: [AuthGard()],
      children: [
        GetPage(
          name: _Paths.CASH_IN,
          page: () => const CashInView(),
          binding: CashInBinding(),
        ),
        GetPage(
          name: _Paths.CASH_OUT,
          page: () => const CashoutView(),
          binding: CashoutBinding(),
        ),
        GetPage(
          name: _Paths.SEND_MONEY,
          page: () => const SendMoneyView(),
          binding: SendMoneyBinding(),
        ),
        GetPage(
          name: _Paths.RECEIVE_MONEY,
          page: () => const ReceiveMoneyView(),
          binding: ReceiveMoneyBinding(),
        ),
        GetPage(
          name: "${_Paths.TRANSACTION_RECEIPT}/:method",
          page: () => const TransactionReceiptView(),
          binding: TransactionReceiptBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOANS,
      page: () => const LoansView(),
      binding: LoansBinding(),
      middlewares: [AuthGard()],
      children: [
        GetPage(
          name: _Paths.MARKET,
          page: () => const MarketView(),
          binding: MarketBinding(),
        ),
        GetPage(
          name: _Paths.REQUEST_LOAN,
          page: () => const RequestLoanView(),
          binding: RequestLoanBinding(),
          children: [
            GetPage(
              name: _Paths.REQUEST_LOAN,
              page: () => const RequestLoanView(),
              binding: RequestLoanBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.LOAN_REQUEST_RECEIVED,
          page: () => const LoanRequestReceivedView(),
          binding: LoanRequestReceivedBinding(),
          children: [
            GetPage(
              name: _Paths.LOAN_REQUEST_RECEIVED,
              page: () => const LoanRequestReceivedView(),
              binding: LoanRequestReceivedBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.LOAN_REQUEST_SENT,
          page: () => const LoanRequestSentView(),
          binding: LoanRequestSentBinding(),
          children: [
            GetPage(
              name: _Paths.LOAN_REQUEST_SENT,
              page: () => const LoanRequestSentView(),
              binding: LoanRequestSentBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.LOAN_RECEIVED,
          page: () => const LoanReceivedView(),
          binding: LoanReceivedBinding(),
          children: [
            GetPage(
              name: _Paths.LOAN_RECEIVED,
              page: () => const LoanReceivedView(),
              binding: LoanReceivedBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.LOAN_GIVEN,
          page: () => const LoanGivenView(),
          binding: LoanGivenBinding(),
          children: [
            GetPage(
              name: _Paths.LOAN_GIVEN,
              page: () => const LoanGivenView(),
              binding: LoanGivenBinding(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ListChatView(),
      binding: ChatBinding(),
      middlewares: [AuthGard()],
    ),
    GetPage(
      name: _Paths.KIWOO,
      page: () => const KiwooView(),
      binding: AppInfoBinding(),
      middlewares: [AuthGard()],
      children: [
        GetPage(
          name: _Paths.ABOUT,
          page: () => const AboutView(),
          binding: AboutBinding(),
        ),
        GetPage(
          name: _Paths.PRIVACY_POLICY,
          page: () => const PrivacyPolicyView(),
          binding: PrivacyPolicyBinding(),
        ),
        GetPage(
          name: _Paths.TERMS_OF_USE,
          page: () => const TermsOfUseView(),
          binding: TermsOfUseBinding(),
        ),
        GetPage(
          name: _Paths.HELP_CENTER,
          page: () => const HelpCenterView(),
          binding: HelpCenterBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.KYC,
          page: () => const KycView(),
          binding: KycBinding(),
        ),
        GetPage(
          name: _Paths.CHANGE_PASSWORD,
          page: () => const ChangePasswordView(),
          binding: ChangePasswordBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_IN_APP_BROWSER,
      page: () => const CustomInAppBrowserView(),
      binding: CustomInAppBrowserBinding(),
    ),
  ];
}
