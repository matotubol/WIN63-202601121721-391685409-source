package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.catalog.class_1793;
   
   public class GameTokensOffer implements class_1793, class_13
   {
      
      private var _offerId:int;
      
      private var var_1275:String;
      
      private var var_1957:int;
      
      private var var_1865:int;
      
      private var var_2381:int;
      
      public function GameTokensOffer(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         _offerId = param1;
         var_1275 = param2;
         var_1957 = param3;
         var_1865 = param4;
         var_2381 = param5;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_1865;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function get priceInCredits() : int
      {
         return var_1957;
      }
      
      public function get page() : class_2044
      {
         return null;
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
         return var_1275;
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
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
      
      public function set page(param1:class_2044) : void
      {
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

