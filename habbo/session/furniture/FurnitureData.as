package com.sulake.habbo.session.furniture
{
   public class FurnitureData implements class_1800
   {
      
      public static const const_558:String = "i";
      
      public static const const_872:String = "s";
      
      private var var_230:String;
      
      private var var_197:int;
      
      private var _className:String;
      
      private var _hasIndexedColor:Boolean;
      
      private var var_4866:int;
      
      private var var_3940:int;
      
      private var var_4304:int;
      
      private var var_4485:int;
      
      private var var_4832:int;
      
      private var _colours:Array;
      
      private var _localizedName:String;
      
      private var var_735:String;
      
      private var var_4353:String;
      
      private var var_4146:int;
      
      private var var_4443:int;
      
      private var _customParams:String;
      
      private var var_191:int;
      
      private var _purchaseCouldBeUsedForBuyout:Boolean;
      
      private var _rentCouldBeUsedForBuyout:Boolean;
      
      private var var_3918:Boolean;
      
      private var _fullName:String;
      
      private var var_4771:Boolean;
      
      private var var_4135:Boolean;
      
      private var var_4529:Boolean;
      
      private var var_5098:Boolean;
      
      private var var_4260:String;
      
      private var var_4013:int;
      
      public function FurnitureData(param1:String, param2:int, param3:String, param4:String, param5:String, param6:String, param7:int, param8:int, param9:int, param10:int, param11:Array, param12:Boolean, param13:int, param14:String, param15:int, param16:Boolean, param17:int, param18:Boolean, param19:Boolean, param20:String, param21:int, param22:Boolean, param23:Boolean, param24:Boolean, param25:Boolean, param26:String, param27:int)
      {
         super();
         var_230 = param1;
         var_197 = param2;
         _fullName = param3;
         _className = param4;
         var_3940 = param7;
         var_4304 = param8;
         var_4485 = param9;
         var_4832 = param10;
         _colours = param11;
         _hasIndexedColor = param12;
         var_4866 = param13;
         _localizedName = param5;
         var_735 = param6;
         var_4353 = param14;
         var_4146 = param15;
         _purchaseCouldBeUsedForBuyout = param16;
         var_4443 = param17;
         _rentCouldBeUsedForBuyout = param18;
         _customParams = param20;
         var_191 = param21;
         var_3918 = param19;
         var_4771 = param22;
         var_4135 = param23;
         var_4529 = param24;
         var_5098 = param25;
         var_4260 = param26;
         var_4013 = param27;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function get fullName() : String
      {
         return _fullName;
      }
      
      public function get hasIndexedColor() : Boolean
      {
         return _hasIndexedColor;
      }
      
      public function get colourIndex() : int
      {
         return var_4866;
      }
      
      public function get revision() : int
      {
         return var_3940;
      }
      
      public function get tileSizeX() : int
      {
         return var_4304;
      }
      
      public function get tileSizeY() : int
      {
         return var_4485;
      }
      
      public function get tileSizeZ() : int
      {
         return var_4832;
      }
      
      public function get colours() : Array
      {
         return _colours;
      }
      
      public function get localizedName() : String
      {
         return _localizedName;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get adUrl() : String
      {
         return var_4353;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4146;
      }
      
      public function get bcOfferId() : int
      {
         return var_4013;
      }
      
      public function get customParams() : String
      {
         return _customParams;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function set className(param1:String) : void
      {
         _className = param1;
      }
      
      public function get rentOfferId() : int
      {
         return var_4443;
      }
      
      public function get purchaseCouldBeUsedForBuyout() : Boolean
      {
         return _purchaseCouldBeUsedForBuyout;
      }
      
      public function get rentCouldBeUsedForBuyout() : Boolean
      {
         return _rentCouldBeUsedForBuyout;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_3918;
      }
      
      public function get canStandOn() : Boolean
      {
         return var_4771;
      }
      
      public function get canSitOn() : Boolean
      {
         return var_4135;
      }
      
      public function get canLayOn() : Boolean
      {
         return var_4529;
      }
      
      public function get isExternalImageType() : Boolean
      {
         return _className.indexOf("external_image") != -1;
      }
      
      public function get excludedFromDynamic() : Boolean
      {
         return var_5098;
      }
      
      public function get furniLine() : String
      {
         return var_4260;
      }
   }
}

