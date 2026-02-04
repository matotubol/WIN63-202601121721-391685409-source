package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.session.furniture.class_1800;
   
   public class FurnitureOffer implements class_1793
   {
      
      private var var_85:class_1800;
      
      private var var_2911:int;
      
      private var var_215:class_2044;
      
      private var var_370:FurniProductContainer;
      
      private var var_3727:Product;
      
      public function FurnitureOffer(param1:class_1800, param2:HabboCatalog)
      {
         super();
         var_85 = param1;
         var_370 = new FurniProductContainer(this,new Vector.<class_1857>(0),param2,var_85);
         var_3727 = new Product(var_85.type,var_85.id,var_85.customParams,1,param2.getProductData(var_85.className),var_85,param2);
      }
      
      public function dispose() : void
      {
         var_85 = null;
         var_215 = null;
         var_2911 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_85 == null;
      }
      
      public function get offerId() : int
      {
         return isRentOffer ? var_85.rentOfferId : var_85.purchaseOfferId;
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
      
      public function get page() : class_2044
      {
         return var_215;
      }
      
      public function get priceType() : String
      {
         return "";
      }
      
      public function get productContainer() : class_2557
      {
         return var_370;
      }
      
      public function get product() : class_1857
      {
         return var_3727;
      }
      
      public function get gridItem() : class_2253
      {
         return var_370 as class_2253;
      }
      
      public function get localizationId() : String
      {
         return "roomItem.name." + var_85.id;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         return var_85.rentOfferId > -1 && !(var_215 != null && var_215.isBuilderPage);
      }
      
      public function get giftable() : Boolean
      {
         return false;
      }
      
      public function get pricingModel() : String
      {
         return "pricing_model_furniture";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_2911 = param1;
      }
      
      public function get previewCallbackId() : int
      {
         return var_2911;
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
         var_215 = param1;
      }
      
      public function get localizationName() : String
      {
         return var_85.localizedName;
      }
      
      public function get localizationDescription() : String
      {
         return var_85.description;
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

