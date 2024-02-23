//
//  API_URL.swift
//  JMSC_POS_CORP_iPAD
//
//  Created by Athulya Tech on 29/12/22.
//

import Foundation


//let BaseUrlAddress = "http://192.168.2.79"
var BASEURL = ""
var IMAGEURL = "http://150.129.105.34:85" 

//var AuthToken = "-!!JAIMAHARAJ!!-"

// http://173.9.208.187:5006/api/sales_reg/CheckUserRights
//MARK: ===== SERVICE_URL =====
class API_URL:NSObject {
    //---- HostSettings ----
    static let HostSettings                 = BASEURL + "/api/v1/app_theme/get_customer_app_setting_details"  //http://192.168.29.7:3000/api/v1/app_theme/get_customer_app_setting_details
    //---- Store Configuration ----
    static let StoreConfig                  = BASEURL + "/api/v1/store_master/store_configuration" //http://192.168.29.7:3000/api/v1/store_master/store_configuration
    
    //----  Customer Login ----
    static let  LoginWithPass               = BASEURL + "/api/v1/customer_app/customer_app_login_withpass" //http://192.168.29.7:3000/api/v1/customer_app/customer_app_login_withpass
    
    static let  LoginWithOTP                = BASEURL + "/api/v1/customer_app/customer_app_login_withotp" //http://192.168.29.7:3000/api/v1/customer_app/customer_app_login_withotp
    static let  GenerateOTP                 = BASEURL + "/api/v1/customer_app/cust_app_login_otp_generate" //http://192.168.29.7:3000/api/v1/customer_app/cust_app_login_otp_generate
    
    static let SocialLoginExist             = BASEURL + "/api/v1/customer_app/cust_app_check_social_media_token_id"
    //http://192.168.29.7:3000/api/v1/customer_app/cust_app_check_social_media_token_id
    
    //---- Customer Details Save/Update ----
    static let  SaveCustomer                = BASEURL + "/api/v1/customer_app/cust_app_save_customer_information" //http://192.168.29.7:3000/api/v1/customer_app/cust_app_save_customer_information
    static let UploadImage                  = BASEURL + "/api/v1/customer_app/cust_app_add_profile_image"
    //http://192.168.29.7:3000/api/v1/customer_app/cust_app_add_profile_image
    static let  UpdateCustomer              = BASEURL + "/api/v1/customer_app/cust_app_update_customer_information" //http://192.168.29.7:3000/api/v1/customer_app/cust_app_update_customer_information
    
    static let  UpdateNotificationStatus    = BASEURL + "/api/v1/customer_app/update_notification_status" //http://192.168.29.7:3000/api/v1/customer_app/update_notification_status
    static let  UpdateShowImageOnPortalStatus    = BASEURL + "/api/v1/customer_app/update_image_on_portal_status" //http://192.168.29.7:3000/api/v1/customer_app/update_image_on_portal_status
    
    static let  ContactUs                   = BASEURL + "/api/v1/store_master/add_contact_us" //http://192.168.29.7:3000/api/v1/store_master/add_contact_us
    
    // ---- Check Details ----
    static let  CheckEmail                  = BASEURL + "/api/v1/customer_app/check_customer_emailid" //http://192.168.29.7:3000/api/v1/customer_app/check_customer_emailid
    
    static let  CheckMobile                 = BASEURL + "/api/v1/customer_app/check_customer_mobile_number" //http://192.168.29.7:3000/api/v1/customer_app/check_customer_emailid
    
    //---- Change Email---
    static let ChangeEmail                  = BASEURL + "/api/v1/customer_app/cust_app_change_profile_email" //http://192.168.29.7:3000/api/v1/customer_app/cust_app_change_profile_email
    static let ChangePhone                  = BASEURL + "/api/v1/customer_app/cust_app_change_profile_mobile" //http://192.168.29.7:3000/api/v1/customer_app/cust_app_change_profile_mobile
    
    //---- Signup Time OTP Generate
    static let SignupOTP                    = BASEURL + "/api/v1/customer_app/cust_app_signup_time_email_mobile_generate_otp"
    //http://192.168.29.7:3001/api/v1/customer_app/cust_app_signup_time_email_mobile_generate_otp
    //---- Change EmailPhone OTP Generate
    static let VerificationOTP              = BASEURL + "/api/v1/customer_app/cust_app_email_mobile_verification_time_generate_otp"
    //http://192.168.29.7:3000/api/v1/customer_app/cust_app_email_mobile_verification_time_generate_otp
    
    //---- Product List ----
    static let  ProductList                 = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_dashboard_details" //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_dashboard_details
    
    static let ProductDetails               = BASEURL + "/api/v1/product/get_cust_app_size_and_product_details"
    //http://192.168.29.7:3000/api/v1/product/get_cust_app_size_and_product_details
    
    static let CategoryAndSizeList          = BASEURL + "/api/v1/product/category_and_size_list"
    //"http://192.168.29.7:3000/api/v1/product/category_and_size_list"
    
    static let AllCategories                = BASEURL + "/api/v1/cust_app_dashboard/all_category_with_item_count"
    //"http://192.168.29.7:3000/api/v1/cust_app_dashboard/all_category_with_item_count"
    //---- Wishlist ----
    static let WishlistItems                = BASEURL + "/api/v1/cust_app_wishlist/cust_app_get_listing_wishlist"
    //http://192.168.29.7:3000/api/v1/cust_app_wishlist/cust_app_get_listing_wishlist
    
    static let AddToWishlist                = BASEURL + "/api/v1/cust_app_wishlist/cust_app_add_in_wishlist"
    //http://192.168.29.7:3000/api/v1/cust_app_wishlist/cust_app_add_in_wishlist
    
    static let RemoveFromWishlist           = BASEURL + "/api/v1/cust_app_wishlist/cust_app_remove_from_wishlist"
    //http://192.168.29.7:3000/api/v1/cust_app_wishlist/cust_app_remove_from_wishlist
    
    static let ClearWishlist                = BASEURL + "/api/v1/cust_app_wishlist/cust_app_get_clear_all_wishlist"
    //"http://192.168.29.7:3000/api/v1/cust_app_wishlist/cust_app_get_clear_all_wishlist"
    //---- Cart ----
    static let CartItems                    = BASEURL + "/api/v1/cust_app_cart/cust_app_cart_listing_details"
    //"http://192.168.29.7:3000/api/v1/cust_app_cart/cust_app_cart_listing_details"
    static let AddToCart                    = BASEURL + "/api/v1/cust_app_cart/cust_app_add_in_cart"
    //http://192.168.29.7:3000/api/v1/cust_app_cart/cust_app_add_in_cart
    static let RemoveFromCart               = BASEURL + "/api/v1/cust_app_cart/cust_app_remove_from_cart"
    //http://192.168.29.7:3000/api/v1/cust_app_cart/cust_app_remove_from_cart
    static let RemovMultipleCart            = BASEURL + "/api/v1/cust_app_cart/cust_app_remove_multiple_cart_item"
    //"http://192.168.29.7:3000/api/v1/cust_app_cart/cust_app_remove_multiple_cart_item"
    
    //----Cart Wishlist Count----
    static let GetCartWishlistCount         = BASEURL + "/api/v1/cust_app_dashboard/get_wishlist_cart_count"
    //http://150.129.105.34:81/api/v1/cust_app_dashboard/get_wishlist_cart_count
    
    //---- Search product ----
    static let SearchProduct                = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_all_product_search_details"
    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_all_product_search_details
    
    static let SearchProductUPC             = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_product_scanner_details"
    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_product_scanner_details
    
    static let GetBrandData                 = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_brand_data_list"
    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_brand_data_list
    
    static let GetCategoryWiseProduct       = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_cat_wise_product_list"
    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_cat_wise_product_list
    
//    static let GetBuyDownProduct            = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_offer_buydown_with_product_list"
//    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_offer_buydown_with_product_list
//    
//    static let GetDealOfferProduct          = BASEURL + "/api/v1/cust_app_dashboard/get_cust_app_offer_deal_discount_with_product_list"
//    //http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_cust_app_offer_deal_discount_with_product_list
    static let GetOfferProductList          = BASEURL + "/api/v1/cust_app_dashboard/get_offer_with_product_list"
    //"http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_offer_with_product_list"
    
    static let GetRecentPurchasedAndSimilar = BASEURL + "/api/v1/product/get_recent_purchase_and_similar_items"
    //"http://192.168.29.7:3000/api/v1/product/get_recent_purchase_and_similar_items"
    
    static let SeeAllProduct                = BASEURL + "/api/v1/product/get_see_all_items"
    //"http://192.168.29.7:3000/api/v1/product/get_see_all_items"
    
    //---- Change Password---
    static let ChangePassword               = BASEURL + "/api/v1/customer_app/cust_app_change_password"
    //http://192.168.29.7:3000/api/v1/customer_app/cust_app_change_password
    static let ForgotPassword               = BASEURL + "/api/v1/customer_app/customer_app_forget_password"
    //http://192.168.29.7:3000/api/v1/customer_app/cust_app_change_password
    
    //----AddressList----
    static let AddressList                   = BASEURL + "/api/v1/address_book/cust_app_get_address_list"
    //"http://192.168.29.7:3000/api/v1/address_book/cust_app_get_address_list"
    static let SaveAddress                   = BASEURL + "/api/v1/address_book/save_cust_address_book_details"
    //"http://192.168.29.7:3000/api/v1/address_book/save_cust_address_book_details"
    static let DeleteAddress                 = BASEURL + "/api/v1/address_book/delete_cust_address_book_details"
    //"http://192.168.29.7:3000/api/v1/address_book/delete_cust_address_book_details"
    static let UpdateAddress                 = BASEURL + "/api/v1/address_book/update_cust_address_book_details"
    //"http://192.168.29.7:3000/api/v1/address_book/update_cust_address_book_details"
    static let DefaultAddress                = BASEURL + "/api/v1/address_book/set_the_default_address"
    //"http://192.168.29.7:3000/api/v1/address_book/set_the_default_address"
    static let getDeliveryBoyLatLong         = BASEURL + "/api/v1/delivery_boy/get_latitude_and_longitude"
    //"http://192.168.29.7:3000/api/v1/delivery_boy/get_latitude_and_longitude"
    static let verifyMobileForAddress        = BASEURL + "/api/v1/customer_app/mobile_verification_for_addressbook"
    //"http://192.168.29.7:3000/api/v1/customer_app/mobile_verification_for_addressbook"

    
    //----Reviews----
    static let AddEditReview                 = BASEURL + "/api/v1/cust_app_product_rating_review/cust_app_product_add_rating_review_details"
    //"http://192.168.29.7:3000/api/v1/cust_app_product_rating_review/cust_app_product_add_rating_review_details"
    static let ReviewList                    = BASEURL + "/api/v1/cust_app_product_rating_review/cust_app_product_rating_review_listing"
    //"http://192.168.29.7:3000/api/v1/cust_app_product_rating_review/cust_app_product_rating_review_listing"
    
    //----Coupons and Offers----
    static let CouponList                    = BASEURL + "/api/v1/cust_app_coupon_offer/cust_app_coupon_listing"
    //"http://192.168.29.7:3000/api/v1/cust_app_coupon_offer/cust_app_coupon_listing"
    static let OfferList                     = BASEURL + "/api/v1/cust_app_coupon_offer/cust_app_offer_listing"
    //"http://192.168.29.7:3000/api/v1/cust_app_coupon_offer/cust_app_offer_listing"
    static let CustomCoupon                  = BASEURL + "/api/v1/cust_app_coupon_offer/custom_coupon_applied"
    //"http://192.168.29.7:3000/api/v1/cust_app_coupon_offer/custom_coupon_applied"
    static let CategoryWiseOffer             = BASEURL + "/api/v1/cust_app_dashboard/get_all_offer_details"
    //"http://192.168.29.7:3000/api/v1/cust_app_dashboard/get_all_offer_details"
    
    //----Order Details----
    static let SaveOrderDetails              = BASEURL + "/api/v1/cust_app_order_master/cust_app_save_order_details"
    //"http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_save_order_details"
    static let SaveOrderPaymentDetails       = BASEURL + "/api/v1/cust_app_order_master/cust_app_save_order_payment_details"
    //"http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_save_order_payment_details"
    static let ValidateOrderCount            = BASEURL + "/api/v1/cust_app_order_master/cust_app_validate_order_count"
    //"http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_validate_order_count"
    static let OrderList                     = BASEURL + "/api/v1/cust_app_order_master/cust_app_order_listing"
    //"http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_order_listing"
    static let OrderDetail                   = BASEURL + "/api/v1/cust_app_order_master/cust_app_get_order_detail"
    //"http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_get_order_detail"
    static let CancelOrder                   = BASEURL + "/api/v1/cust_app_order_master/cust_app_set_order_cancel"
    //http://192.168.29.7:3000/api/v1/cust_app_order_master/cust_app_set_order_cancel
    static let ReOrder                       = BASEURL + "/api/v1/cust_app_order_master/cust_app_set_reorder"
    //http://150.129.105.34:81/api/v1/cust_app_order_master/cust_app_set_reorder
    
   //----Notifications----
    static let getNotificationListing       = BASEURL + "/api/v1/customer_app/get_notification_lisiting"
    //"http://192.168.29.7:3000/api/v1/customer_app/get_notification_lisiting"
    
    static let readNotification             = BASEURL + "/api/v1/customer_app/notification_read"
    //"http://192.168.29.7:3000/api/v1/customer_app/notification_read"
    static let getNotificationCount         = BASEURL + "/api/v1/customer_app/notification_count"
    //http://192.168.29.7:3000/api/v1/customer_app/notification_count
    
    //----Store----
    static let getStoreList                 = BASEURL + "/api/v1/store_master/store_listing"
    //http://150.129.105.34:81/api/v1/store_master/store_listing
    
    //----Rating----
    static let addStoreDeliveryRating       = BASEURL + "/api/v1/store_master/add_store_delivery_rating"
    //http://192.168.29.7:3000/api/v1/store_master/add_store_delivery_rating
}
