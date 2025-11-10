// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// ignore_for_file: lines_longer_than_80_chars
// ignore: avoid_classes_with_only_static_members
class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': Locales.en,
    'fr': Locales.fr,
  };
}

class LocaleKeys {
  LocaleKeys._();
  static const buttons_login = 'buttons_login';
  static const buttons_sign_in = 'buttons_sign_in';
  static const buttons_logout = 'buttons_logout';
  static const buttons_sign_in_fb = 'buttons_sign_in_fb';
  static const buttons_sign_in_google = 'buttons_sign_in_google';
  static const buttons_sign_in_apple = 'buttons_sign_in_apple';
  static const direction_inbound = 'direction_inbound';
  static const direction_outbound = 'direction_outbound';
  static const direPreposition_inbound = 'direPreposition_inbound';
  static const direPreposition_outbound = 'direPreposition_outbound';
  static const transactionStatus_failed = 'transactionStatus_failed';
  static const transactionStatus_success = 'transactionStatus_success';
  static const transactionStatus_adverbe_failed =
      'transactionStatus_adverbe_failed';
  static const transactionStatus_adverbe_success =
      'transactionStatus_adverbe_success';
  static const PASTTENSE_ACCEPTED = 'PASTTENSE_ACCEPTED';
  static const PASTTENSE_REJECTED = 'PASTTENSE_REJECTED';
  static const PASTTENSE_RECEIVED = 'PASTTENSE_RECEIVED';
  static const PASTTENSE_SENT = 'PASTTENSE_SENT';
  static const PREPOSITION_inbound = 'PREPOSITION_inbound';
  static const PREPOSITION_outbound = 'PREPOSITION_outbound';
  static const TRANSACTION_TITLE_chat = 'TRANSACTION_TITLE_chat';
  static const TRANSACTION_TITLE_transfer = 'TRANSACTION_TITLE_transfer';
  static const TRANSACTION_TITLE_loan = 'TRANSACTION_TITLE_loan';
  static const TRANSACTION_TITLE_loan_Request =
      'TRANSACTION_TITLE_loan_Request';
  static const TRANSACTION_TITLE_loanPayBack = 'TRANSACTION_TITLE_loanPayBack';
  static const TRANSACTION_TITLE_loan_offer = 'TRANSACTION_TITLE_loan_offer';
  static const TRANSACTION_TITLE_loan_offer_validation =
      'TRANSACTION_TITLE_loan_offer_validation';
  static const TRANSACTION_TITLE_cashin = 'TRANSACTION_TITLE_cashin';
  static const TRANSACTION_TITLE_cashout = 'TRANSACTION_TITLE_cashout';
  static const TRANSACTION_BODY_chat = 'TRANSACTION_BODY_chat';
  static const TRANSACTION_BODY_transfer = 'TRANSACTION_BODY_transfer';
  static const TRANSACTION_BODY_loan = 'TRANSACTION_BODY_loan';
  static const TRANSACTION_BODY_loan_Request = 'TRANSACTION_BODY_loan_Request';
  static const TRANSACTION_BODY_loanPayBack = 'TRANSACTION_BODY_loanPayBack';
  static const TRANSACTION_BODY_loan_offer = 'TRANSACTION_BODY_loan_offer';
  static const TRANSACTION_BODY_loan_offer_validation_inbound =
      'TRANSACTION_BODY_loan_offer_validation_inbound';
  static const TRANSACTION_BODY_loan_offer_validation_outbound =
      'TRANSACTION_BODY_loan_offer_validation_outbound';
  static const TRANSACTION_BODY_cashin = 'TRANSACTION_BODY_cashin';
  static const TRANSACTION_BODY_cashout = 'TRANSACTION_BODY_cashout';
  static const name = 'name';
  static const phone = 'phone';
  static const directionTypeName_inbound = 'directionTypeName_inbound';
  static const directionTypeName_outbound = 'directionTypeName_outbound';
  static const transactionStatus_pending = 'transactionStatus_pending';
}

class Locales {
  static const en = {
    'buttons_login': 'Login',
    'buttons_sign_in': 'Sign-in',
    'buttons_logout': 'Logout',
    'buttons_sign_in_fb': 'Sign-in with Facebook',
    'buttons_sign_in_google': 'Sign-in with Google',
    'buttons_sign_in_apple': 'Sign-in with Apple',
    'direction_inbound': 'Received',
    'direction_outbound': 'Send',
    'direPreposition_inbound': 'from',
    'direPreposition_outbound': 'to',
    'transactionStatus_failed': 'Failed',
    'transactionStatus_success': 'Success',
    'transactionStatus_adverbe_failed': 'successfully',
    'transactionStatus_adverbe_success': 'successfully',
    'PASTTENSE_ACCEPTED': 'accepted',
    'PASTTENSE_REJECTED': 'rejected',
    'PASTTENSE_RECEIVED': 'received',
    'PASTTENSE_SENT': 'sent',
    'PREPOSITION_inbound': 'from',
    'PREPOSITION_outbound': 'to',
    'TRANSACTION_TITLE_chat': 'New Message',
    'TRANSACTION_TITLE_transfer': 'Transfer @method',
    'TRANSACTION_TITLE_loan': 'Loan @pasttense',
    'TRANSACTION_TITLE_loan_Request': 'Loan Request @pasttense',
    'TRANSACTION_TITLE_loanPayBack': 'Loan Repayment @pasttense',
    'TRANSACTION_TITLE_loan_offer': 'New Loan Offer @pasttense',
    'TRANSACTION_TITLE_loan_offer_validation': 'Loan Offer @pasttense',
    'TRANSACTION_TITLE_cashin': 'Deposit via @method',
    'TRANSACTION_TITLE_cashout': 'Withdrawal via @method',
    'TRANSACTION_BODY_chat': 'New Message',
    'TRANSACTION_BODY_transfer':
        'You have @pasttense an amount of @amount @preposition @userName.',
    'TRANSACTION_BODY_loan':
        'You have @pasttense a Loan of @amount @preposition {userName}.',
    'TRANSACTION_BODY_loan_Request':
        'You have @pasttense a Loan request of @amount @preposition {userName}.',
    'TRANSACTION_BODY_loanPayBack':
        'You have @pasttense a Loan repayment of @amount @preposition @userName.',
    'TRANSACTION_BODY_loan_offer':
        'You have @pasttense an offer for the Loan of @amount @preposition @userName.',
    'TRANSACTION_BODY_loan_offer_validation_inbound':
        'Your loan offer of @amount to @userName has been @pasttense.',
    'TRANSACTION_BODY_loan_offer_validation_outbound':
        'You have @pasttense the loan offer of @amount from @userName.',
    'TRANSACTION_BODY_cashin':
        'You have made a deposit of @amount via @method.',
    'TRANSACTION_BODY_cashout':
        'You have made a withdrawal of @amount via @method.',
  };
  static const fr = {
    'name': 'Nom',
    'phone': 'Tel.',
    'buttons_login': 'Se connecter',
    'buttons_sign_in': 'Se connecter',
    'buttons_logout': 'Se déconnecter',
    'buttons_sign_in_fb': 'Se connecter avec Facebook',
    'buttons_sign_in_google': 'Se connecter avec Google',
    'buttons_sign_in_apple': 'Se connecter avec Apple',
    'direction_inbound': 'Reçu',
    'direction_outbound': 'Envoyé',
    'directionTypeName_inbound': '%s de l\'Expéditeur',
    'directionTypeName_outbound': '%s du Destinataire',
    'transactionStatus_failed': 'Echec',
    'transactionStatus_success': 'Réussie',
    'transactionStatus_pending': 'En cours',
    'transactionStatus_adverbe_failed': 'avec succès',
    'transactionStatus_adverbe_success': 'avec succès',
    'PASTTENSE_ACCEPTED': 'accepté',
    'PASTTENSE_REJECTED': 'rejecté',
    'PASTTENSE_RECEIVED': 'reçu',
    'PASTTENSE_SENT': 'envoyé',
    'PREPOSITION_inbound': 'de',
    'PREPOSITION_outbound': 'à',
    'TRANSACTION_TITLE_chat': 'Nouveau Message',
    'TRANSACTION_TITLE_transfer': 'Transfer @method',
    'TRANSACTION_TITLE_loan': 'Prêt @pasttense',
    'TRANSACTION_TITLE_loan_Request': 'Demande De Prêt @pasttense',
    'TRANSACTION_TITLE_loanPayBack': 'Remboursement De Prêt @pasttense',
    'TRANSACTION_TITLE_loan_offer': 'Nouveau offre de Prêt @pasttense',
    'TRANSACTION_TITLE_loan_offer_validation': 'Offre De Prêt @pasttense',
    'TRANSACTION_TITLE_cashin': 'Dépot via @method',
    'TRANSACTION_TITLE_cashout': 'Retrait via @method',
    'TRANSACTION_BODY_chat': 'Nouveau Message',
    'TRANSACTION_BODY_transfer':
        'Vous avez @pasttense une somme de @amount @preposition @userName.',
    'TRANSACTION_BODY_loan':
        'Vous avez @pasttense un Prêt de @amount @preposition {userName}.',
    'TRANSACTION_BODY_loan_Request':
        'Vous avez @pasttense une demande de Prêt de @amount @preposition {userName}.',
    'TRANSACTION_BODY_loanPayBack':
        'vous avez @pasttense un Remboursement de Prêt de @amount @preposition @userName.',
    'TRANSACTION_BODY_loan_offer':
        'vous avez @pasttense une offre pour le Prêt de @amount @preposition @userName.',
    'TRANSACTION_BODY_loan_offer_validation_inbound':
        'Votre offre de Prêt du somme de @amount à @userName ete @pasttense.',
    'TRANSACTION_BODY_loan_offer_validation_outbound':
        'Vous avez @pasttense l\'offre de Prêt du somme de @amount de @userName.',
    'TRANSACTION_BODY_cashin':
        'Vous avez effectué un Dépot de @amount via @method.',
    'TRANSACTION_BODY_cashout':
        'Vous avez effectué un Retrait de @amount via @method.',
  };
}
