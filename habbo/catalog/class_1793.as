package com.sulake.habbo.catalog
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.class_2557;
   
   public interface class_1793 extends class_13
   {
      
      function get offerId() : int;
      
      function get priceInActivityPoints() : int;
      
      function get activityPointType() : int;
      
      function get priceInCredits() : int;
      
      function get priceInSilver() : int;
      
      function get priceInEmerald() : int;
      
      function get page() : class_2044;
      
      function get priceType() : String;
      
      function get product() : class_1857;
      
      function get productContainer() : class_2557;
      
      function get gridItem() : class_2253;
      
      function get localizationId() : String;
      
      function get bundlePurchaseAllowed() : Boolean;
      
      function get isRentOffer() : Boolean;
      
      function get giftable() : Boolean;
      
      function get pricingModel() : String;
      
      function set previewCallbackId(param1:int) : void;
      
      function get previewCallbackId() : int;
      
      function get clubLevel() : int;
      
      function get badgeCode() : String;
      
      function get extraChatStyleCode() : String;
      
      function get isSingleChatStyle() : Boolean;
      
      function set page(param1:class_2044) : void;
      
      function get localizationName() : String;
      
      function get localizationDescription() : String;
   }
}

