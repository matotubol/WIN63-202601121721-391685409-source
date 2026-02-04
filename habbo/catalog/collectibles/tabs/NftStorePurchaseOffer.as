package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.class_2557;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3631;
   
   public class NftStorePurchaseOffer implements class_1793
   {
      
      private var var_2511:class_3631;
      
      public function NftStorePurchaseOffer(param1:class_3631)
      {
         super();
         var_2511 = param1;
      }
      
      public function get offerId() : int
      {
         return 0;
      }
      
      public function get priceInActivityPoints() : int
      {
         return 0;
      }
      
      public function get activityPointType() : int
      {
         return 0;
      }
      
      public function get priceInCredits() : int
      {
         return 0;
      }
      
      public function get priceInSilver() : int
      {
         return 0;
      }
      
      public function get page() : class_2044
      {
         return null;
      }
      
      public function get priceType() : String
      {
         return "price_type_silver";
      }
      
      public function get product() : class_1857
      {
         return null;
      }
      
      public function get productContainer() : class_2557
      {
         return null;
      }
      
      public function get gridItem() : class_2253
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return var_2511.productCode;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         return false;
      }
      
      public function get giftable() : Boolean
      {
         return false;
      }
      
      public function get pricingModel() : String
      {
         return "";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
      }
      
      public function get previewCallbackId() : int
      {
         return 0;
      }
      
      public function get clubLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function set page(param1:class_2044) : void
      {
      }
      
      public function get localizationName() : String
      {
         return "";
      }
      
      public function get localizationDescription() : String
      {
         return "";
      }
      
      public function get productCode() : String
      {
         return var_2511.productCode;
      }
      
      public function get priceInEmerald() : int
      {
         return var_2511.emeraldPrice;
      }
      
      public function get productInfo() : class_2870
      {
         return var_2511.productInfo;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
   }
}

