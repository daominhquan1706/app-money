class MapErrorResponse {
  static const Map<String, String> mapError = {
    null: 'An error occurred, please try again!',
    '': 'An error occurred, please try again!',
    'UNHANDLED_ERROR': 'An error occurred!',
    'INVALID_EMAIL_PASSWORD': 'Email or password incorrect',
    'USER_DOES_NOT_MEET_PROMOCODE_CONDITIONS':
        'Sorry, you are not eligible for this promocode',
    'PROMOCODE_ALREADY_USED': 'Sorry, you are not eligible for this promocode',
    'PROMOCODE_NOT_FOUND': 'Promocode not found',
    'PROMOCODE_MAX_USAGE': 'Promocode has reached its maximum usage',
    'OVER_LIMIT': 'Promocode has reached its maximum usage',
    'OVER_LIMIT_MEMBER': 'Promocode has reached its maximum usage per member',
    'CANNOT_CHARGE_NOT_AVAILABLE_PRODUCT': 'Cannot charge this product',
    'PROMOCODE_MAX_USAGE_PER_USER':
        'Promocode has reached its maximum usage per user',
  };
}
