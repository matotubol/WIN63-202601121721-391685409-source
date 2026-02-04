package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   
   public class PlacedObjectPurchaseData implements class_13
   {
      
      private var var_1134:Boolean = false;
      
      private var var_315:int;
      
      private var var_191:int;
      
      private var var_1951:int;
      
      private var var_3429:String = "";
      
      private var var_25:int = 0;
      
      private var var_26:int = 0;
      
      private var var_81:int = 0;
      
      private var _offerId:int;
      
      private var var_3320:int;
      
      private var var_1500:class_1949;
      
      private var var_85:class_1800;
      
      private var var_1280:String;
      
      public function PlacedObjectPurchaseData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:class_1793)
      {
         super();
         var_1951 = param1;
         var_315 = param2;
         var_191 = param3;
         var_3429 = param4;
         var_25 = param5;
         var_26 = param6;
         var_81 = param7;
         setOfferData(param8);
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         var_1500 = null;
         var_85 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function setOfferData(param1:class_1793) : void
      {
         _offerId = param1.offerId;
         var_3320 = param1.product.productClassId;
         var_1500 = param1.product.productData;
         var_85 = param1.product.furnitureData;
         var_1280 = param1.product.extraParam;
      }
      
      public function toString() : String
      {
         return [var_1951,var_315,var_191,var_3429,var_25,var_26,var_81,_offerId,var_3320].toString();
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get wallLocation() : String
      {
         return var_3429;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productClassId() : int
      {
         return var_3320;
      }
      
      public function get extraParameter() : String
      {
         return var_1280;
      }
      
      public function get furniData() : class_1800
      {
         return var_85;
      }
   }
}

