class AppEnum {
  static const String FEED_HISTORY_BOOKINGS = "FEED_HISTORY_BOOKINGS";
  static const String FEED_PROMOTION_CODES = "FEED_PROMOTION_CODES";

  static const String FEED_ITEM_ALL_PENDING_BOOKINGS_CARD =
      "FEED_ITEM_ALL_PENDING_BOOKINGS_CARD";
  static const String FEED_ITEM_VALET_UPCOMING_BOOKINGS_CARD =
      "FEED_ITEM_VALET_UPCOMING_BOOKINGS_CARD";
  static const String FEED_ITEM_VALET_TRIP_HISTORY_BOOKINGS_CARD =
      "FEED_ITEM_VALET_TRIP_HISTORY_BOOKINGS_CARD";
  static const String FEED_ITEM_PRMOTIONS_CARD = "FEED_ITEM_PRMOTIONS_CARD";

  static const String UPLOAD_TYPE_CAR_IMAGE = "UPLOAD_TYPE_CAR_IMAGE";
  static const String UPLOAD_TYPE_CAR_RECEIPT_IMAGE =
      "UPLOAD_TYPE_CAR_RECEIPT_IMAGE";

  static final String PROFILE_USER_DETAILS_UPDATE =
      "PROFILE_USER_DETAILS_UPDATE";
  static final String PROFILE_CUSTOMER_REGISTRATION_UPDATE =
      "PROFILE_CUSTOMER_REGISTRATION_UPDATE";
  static final String PROFILE_VALET_REGISTRATION_UPDATE =
      "PROFILE_VALET_REGISTRATION_UPDATE";
  static final String PROFILE_VALET_NORMAL_UPDATE =
      "PROFILE_VALET_NORMAL_UPDATE";
  static final String PROFILE_CUSTOMER_NORMAL_UPDATE =
      "PROFILE_CUSTOMER_NORMAL_UPDATE";

  // Booking Priority
  static final String BOOKING_PRIORITY_HIGH = "HIGH";
  static final String BOOKING_PRIORITY_MODERATE = "MODERATE";
  static final String BOOKING_PRIORITY_NORMAL = "NORMAL";

  // ADMIN Authority on Valet
  static final String ADMIN_AUTORITY_ON_VALET_ALLOWED = "ALLOWED";
  static final String ADMIN_AUTORITY_ON_VALET_PENDING = "PENDING";
  static final String ADMIN_AUTORITY_ON_VALET_BLOCKED = "BLOCKED";
  static final String ADMIN_AUTORITY_ON_VALET_PENALIZED = "PENALIZED";
  static final String ADMIN_AUTORITY_ON_VALET_AIRPORT_STATUTS_ACTIVE =
      "AIRPORT_STATUTS_ACTIVE";
  static final String ADMIN_AUTORITY_ON_VALET_AIRPORT_STATUTS_INACTIVE =
      "AIRPORT_STATUTS_INACTIVE";

  // Valet Status
  static final String VALET_STATUS_ACTIVE = "ACTIVE";
  static final String VALET_STATUS_INACTIVE = "INACTIVE";

  // BOOKING Cancellation
  static final String BOOKING_CANCELLED_BY_SUPER_ADMIN = "SUPER_ADMIN";
  static final String BOOKING_CANCELLED_BY_ADMIN = "ADMIN";
  static final String BOOKING_CANCELLED_BY_CUSTOMER = "CUSTOMER";
  static final String BOOKING_CANCELLED_BY_SYSTEM = "SYSTEM";

  // Discount Info
  static final String DISCOUNT_AMOUNT_RECEIVE_TYPE_INSTANT_AMOUNT =
      "INSTANT_AMOUNT";
  static final String DISCOUNT_AMOUNT_RECEIVE_TYPE_PERCENTAGE = "PERCENTAGE";
  static final String DISCOUNT_METHOD_TYPE_VOUCHER_CODE = "VOUCHER_CODE";
  static final String DISCOUNT_METHOD_TYPE_VISA_CARD = "VISA_CARD";
  static final String DISCOUNT_METHOD_TYPE_MASTER_CARD = "MASTER_CARD";
  static final String DISCOUNT_METHOD_TYPE_AMERICAN_EXPRESS =
      "AMERICAN_EXPRESS";

  // Booking Status
  static final String BOOKING_STATUS_COMPLETED = "COMPLETED";
  static final String BOOKING_STATUS_ONGOING_TRIP = "ONGOING_TRIP";
  static final String BOOKING_STATUS_CANCELLED = "CANCELLED";
  static final String BOOKING_STATUS_NOT_STARTED = "NOT_STARTED";

  // Trip Status
  static final String TRIP_STATUS_COMPLETED = "COMPLETED";
  static final String TRIP_STATUS_ONGOING = "ONGOING";
  static final String TRIP_STATUS_CANCELLED = "CANCELLED";
}