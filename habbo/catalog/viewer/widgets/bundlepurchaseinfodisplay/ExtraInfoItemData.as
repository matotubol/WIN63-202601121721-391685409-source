package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   public class ExtraInfoItemData
   {
      
      public static const TYPE_PROMO:int = 0;
      
      public static const TYPE_BUNDLES_INFO_SCREEN:int = 1;
      
      public static const const_211:int = 2;
      
      public static const TYPE_BONUS_BADGE:int = 3;
      
      public static const const_501:int = 4;
      
      public static const TYPE_RESET_MESSAGE:int = 5;
      
      private var var_230:int;
      
      private var _text:String;
      
      private var var_1048:int;
      
      private var var_2381:int;
      
      private var var_3960:int;
      
      private var var_4248:int;
      
      private var var_3791:int;
      
      private var var_4163:int;
      
      private var var_4997:int;
      
      private var var_2806:String;
      
      private var var_4639:String;
      
      public function ExtraInfoItemData(param1:int, param2:String = "")
      {
         super();
         var_230 = param1;
         _text = param2;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function set quantity(param1:int) : void
      {
         var_1048 = param1;
      }
      
      public function set activityPointType(param1:int) : void
      {
         var_2381 = param1;
      }
      
      public function set discountPriceCredits(param1:int) : void
      {
         var_3960 = param1;
      }
      
      public function set discountPriceActivityPoints(param1:int) : void
      {
         var_4248 = param1;
      }
      
      public function set priceCredits(param1:int) : void
      {
         var_3791 = param1;
      }
      
      public function set priceActivityPoints(param1:int) : void
      {
         var_4163 = param1;
      }
      
      public function set priceSilver(param1:int) : void
      {
         var_4997 = param1;
      }
      
      public function set badgeCode(param1:String) : void
      {
         var_2806 = param1;
      }
      
      public function set achievementCode(param1:String) : void
      {
         var_4639 = param1;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get quantity() : int
      {
         return var_1048;
      }
      
      public function get priceCredits() : int
      {
         return var_3791;
      }
      
      public function get priceActivityPoints() : int
      {
         return var_4163;
      }
      
      public function get activityPointType() : int
      {
         return var_2381;
      }
      
      public function get priceSilver() : int
      {
         return var_4997;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get achievementCode() : String
      {
         return var_4639;
      }
      
      public function get discountPriceCredits() : int
      {
         return var_3960;
      }
      
      public function get discountPriceActivityPoints() : int
      {
         return var_4248;
      }
   }
}

