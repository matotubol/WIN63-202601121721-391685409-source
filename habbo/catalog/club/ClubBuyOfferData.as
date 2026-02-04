package com.sulake.habbo.catalog.club
{
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.class_2557;
   
   public class ClubBuyOfferData implements class_1793
   {
      
      private var _offerId:int;
      
      private var var_2711:String;
      
      private var var_3791:int;
      
      private var var_4163:int;
      
      private var var_4683:int;
      
      private var var_4001:Boolean;
      
      private var var_3889:int;
      
      private var var_4822:int;
      
      private var var_215:class_2044;
      
      private var var_2828:int;
      
      private var _month:int;
      
      private var var_4593:int;
      
      private var var_1280:String;
      
      private var var_5154:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_4205:int;
      
      private var var_3748:Boolean;
      
      public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:Boolean = false)
      {
         super();
         _offerId = param1;
         var_2711 = param2;
         var_3791 = param3;
         var_4163 = param4;
         var_4683 = param5;
         var_4001 = param6;
         var_3889 = param7;
         var_4205 = param8;
         var_4822 = param9;
         var_2828 = param10;
         _month = param11;
         var_4593 = param12;
         var_3748 = param13;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         var_215 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get extraParameter() : String
      {
         return var_1280;
      }
      
      public function set extraParameter(param1:String) : void
      {
         var_1280 = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get priceCredits() : int
      {
         return var_3791;
      }
      
      public function get vip() : Boolean
      {
         return var_4001;
      }
      
      public function get months() : int
      {
         return var_3889;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return var_4822;
      }
      
      public function get year() : int
      {
         return var_2828;
      }
      
      public function get month() : int
      {
         return _month;
      }
      
      public function get day() : int
      {
         return var_4593;
      }
      
      public function get isGiftable() : Boolean
      {
         return var_3748;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_4163;
      }
      
      public function get activityPointType() : int
      {
         return var_4683;
      }
      
      public function get priceInCredits() : int
      {
         return var_3791;
      }
      
      public function get page() : class_2044
      {
         return var_215;
      }
      
      public function get priceType() : String
      {
         return "price_type_credits";
      }
      
      public function get productContainer() : class_2557
      {
         return null;
      }
      
      public function get product() : class_1857
      {
         return productContainer ? productContainer.firstProduct : null;
      }
      
      public function get gridItem() : class_2253
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return var_2711;
      }
      
      public function set page(param1:class_2044) : void
      {
         var_215 = param1;
      }
      
      public function get upgradeHcPeriodToVip() : Boolean
      {
         return var_5154;
      }
      
      public function set upgradeHcPeriodToVip(param1:Boolean) : void
      {
         var_5154 = param1;
      }
      
      public function get extraDays() : int
      {
         return var_4205;
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
         return var_3748;
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
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
      
      public function get localizationName() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get localizationDescription() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

