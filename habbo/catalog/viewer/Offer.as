package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   
   public class Offer implements class_1793
   {
      
      public static const PRICING_MODEL_UNKNOWN:String = "pricing_model_unknown";
      
      public static const PRICING_MODEL_SINGLE:String = "pricing_model_single";
      
      public static const PRICING_MODEL_MULTI:String = "pricing_model_multi";
      
      public static const PRICING_MODEL_BUNDLE:String = "pricing_model_bundle";
      
      public static const PRICING_MODEL_FURNI:String = "pricing_model_furniture";
      
      public static const PRICE_TYPE_NONE:String = "price_type_none";
      
      public static const PRICE_TYPE_CREDITS:String = "price_type_credits";
      
      public static const PRICE_TYPE_ACTIVITYPOINTS:String = "price_type_activitypoints";
      
      public static const PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS:String = "price_type_credits_and_activitypoints";
      
      public static const PRICE_TYPE_SILVER:String = "price_type_silver";
      
      private var var_703:String;
      
      private var var_1025:String;
      
      private var _offerId:int;
      
      private var var_1275:String;
      
      private var var_1957:int;
      
      private var var_1865:int;
      
      private var var_2381:int;
      
      private var var_3572:int;
      
      private var var_3748:Boolean;
      
      private var var_5097:Boolean;
      
      private var var_215:class_2044;
      
      private var var_370:class_2557;
      
      private var _disposed:Boolean = false;
      
      private var var_2971:int = 0;
      
      private var var_2806:String;
      
      private var var_4374:String;
      
      private var var_4476:Boolean = false;
      
      private var _catalog:HabboCatalog;
      
      private var var_4185:Boolean;
      
      private var var_2911:int;
      
      public function Offer(param1:int, param2:String, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:int, param10:Vector.<class_1857>, param11:Boolean, param12:HabboCatalog)
      {
         super();
         _offerId = param1;
         var_1275 = param2;
         var_5097 = param3;
         var_1957 = param4;
         var_1865 = param5;
         var_2381 = param6;
         var_3572 = param7;
         var_3748 = param8;
         var_2971 = param9;
         var_4476 = param11;
         _catalog = param12;
         var_4185 = param10.length == 1 && param10[0].productType == "chat_style" || param10.length == 2 && (param10[0].productType == "chat_style" && param10[1].productType == "b" || param10[0].productType == "b" && param10[1].productType == "chat_style");
         analyzePricingModel(param10);
         analyzePriceType();
         createProductContainer(param10);
         for each(var _loc13_ in param10)
         {
            if(_loc13_.productType == "b")
            {
               var_2806 = _loc13_.extraParam;
               break;
            }
            if(!isSingleChatStyle && _loc13_.productType == "chat_style")
            {
               var_4374 = _loc13_.extraParam;
               break;
            }
         }
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get page() : class_2044
      {
         return var_215;
      }
      
      public function set page(param1:class_2044) : void
      {
         var_215 = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get localizationId() : String
      {
         return var_1275;
      }
      
      public function get priceInCredits() : int
      {
         return var_1957;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_1865;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function get priceInSilver() : int
      {
         return var_3572;
      }
      
      public function get giftable() : Boolean
      {
         return var_3748;
      }
      
      public function get productContainer() : class_2557
      {
         return var_370;
      }
      
      public function get product() : class_1857
      {
         return var_370 ? var_370.firstProduct : null;
      }
      
      public function get gridItem() : class_2253
      {
         return var_370 as class_2253;
      }
      
      public function get pricingModel() : String
      {
         return var_703;
      }
      
      public function get priceType() : String
      {
         return var_1025;
      }
      
      public function get previewCallbackId() : int
      {
         return var_2911;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_2911 = param1;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return var_4476;
      }
      
      public function get isRentOffer() : Boolean
      {
         return var_5097;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _offerId = 0;
         var_1275 = "";
         var_1957 = 0;
         var_1865 = 0;
         var_2381 = 0;
         var_215 = null;
         _catalog = null;
         if(var_370 != null)
         {
            var_370.dispose();
            var_370 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function createProductContainer(param1:Vector.<class_1857>) : void
      {
         switch(var_703)
         {
            case "pricing_model_single":
               var_370 = new SingleProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_multi":
               var_370 = new MultiProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_bundle":
               var_370 = new BundleProductContainer(this,param1,_catalog);
               break;
            default:
               var_370 = new ProductContainer(this,param1,_catalog);
               class_21.log("[Offer] Unknown pricing model" + var_703);
         }
      }
      
      private function analyzePricingModel(param1:Vector.<class_1857>) : void
      {
         if(isSingleChatStyle)
         {
            var_703 = "pricing_model_single";
            return;
         }
         var _loc2_:Vector.<class_1857> = Product.stripAddonProducts(param1);
         if(_loc2_.length == 1)
         {
            if(_loc2_[0].productCount == 1)
            {
               var_703 = "pricing_model_single";
            }
            else
            {
               var_703 = "pricing_model_multi";
            }
         }
         else if(_loc2_.length > 1)
         {
            var_703 = "pricing_model_bundle";
         }
         else
         {
            var_703 = "pricing_model_unknown";
         }
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return var_4185;
      }
      
      private function analyzePriceType() : void
      {
         if(var_1957 > 0 && var_1865 > 0)
         {
            var_1025 = "price_type_credits_and_activitypoints";
         }
         else if(var_1957 > 0)
         {
            var_1025 = "price_type_credits";
         }
         else if(var_1865 > 0)
         {
            var_1025 = "price_type_activitypoints";
         }
         else if(var_3572 > 0)
         {
            var_1025 = "price_type_silver";
         }
         else
         {
            var_1025 = "price_type_none";
         }
      }
      
      public function clone() : Offer
      {
         var _loc4_:class_1800 = null;
         var _loc2_:Product = null;
         var _loc5_:Vector.<class_1857> = new Vector.<class_1857>(0);
         var _loc6_:class_1949 = _catalog.getProductData(localizationId);
         for each(var _loc3_ in var_370.products)
         {
            _loc4_ = _catalog.getFurnitureData(_loc3_.productClassId,_loc3_.productType);
            _loc2_ = new Product(_loc3_.productType,_loc3_.productClassId,_loc3_.extraParam,_loc3_.productCount,_loc6_,_loc4_,_catalog);
            _loc5_.push(_loc2_);
         }
         var _loc1_:Offer = new Offer(offerId,localizationId,isRentOffer,priceInCredits,priceInActivityPoints,activityPointType,priceInSilver,giftable,clubLevel,_loc5_,bundlePurchaseAllowed,_catalog);
         _loc1_.page = page;
         return _loc1_;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get extraChatStyleCode() : String
      {
         return var_4374;
      }
      
      public function get localizationName() : String
      {
         var _loc1_:class_1949 = _catalog.getProductData(var_1275);
         return _loc1_ ? _loc1_.name : "${" + var_1275 + "}";
      }
      
      public function get localizationDescription() : String
      {
         var _loc1_:class_1949 = _catalog.getProductData(var_1275);
         return _loc1_ ? _loc1_.description : "${" + var_1275 + "}";
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

