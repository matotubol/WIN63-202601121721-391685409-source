package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_2869
   {
      
      protected var var_197:int;
      
      protected var var_3099:String;
      
      protected var var_230:int;
      
      protected var var_839:String;
      
      protected var var_735:String;
      
      protected var var_319:String;
      
      protected var var_2949:String;
      
      protected var var_2711:String;
      
      protected var var_1551:int;
      
      protected var _expirationTime:uint;
      
      protected var var_1957:int;
      
      protected var var_1865:int;
      
      protected var var_2381:int;
      
      protected var var_2065:Vector.<String>;
      
      protected var var_2693:int;
      
      public function class_2869(param1:class_2869 = null)
      {
         super();
         if(param1 != null)
         {
            var_197 = param1.id;
            var_3099 = param1.identifier;
            var_230 = param1.type;
            var_839 = param1.title;
            var_735 = param1.description;
            var_319 = param1.imageUrl;
            var_2949 = param1.iconImageUrl;
            var_2711 = param1.productCode;
            var_1551 = param1.purchaseLimit;
            _expirationTime = param1.expirationTime;
            var_1957 = param1.priceInCredits;
            var_1865 = param1.priceInActivityPoints;
            var_2381 = param1.activityPointType;
            var_2065 = param1.subProductCodes;
            var_2693 = param1.trackingState;
         }
      }
      
      public function parse(param1:IMessageDataWrapper) : class_2869
      {
         var_2693 = param1.readInteger();
         var_197 = param1.readInteger();
         var_3099 = param1.readString();
         var_2711 = param1.readString();
         var_1957 = param1.readInteger();
         var_1865 = param1.readInteger();
         var_2381 = param1.readInteger();
         var_1551 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
         var_839 = param1.readString();
         var_735 = param1.readString();
         var_319 = param1.readString();
         var_2949 = param1.readString();
         var_230 = param1.readInteger();
         var_2065 = new Vector.<String>(0);
         var _loc4_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc4_)
         {
            var_2065.push(param1.readString());
            _loc3_++;
         }
         return this;
      }
      
      public function purchased(param1:int) : void
      {
         var_1551 -= param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get identifier() : String
      {
         return var_3099;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get imageUrl() : String
      {
         return var_319;
      }
      
      public function get iconImageUrl() : String
      {
         return var_2949;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get purchaseLimit() : int
      {
         return var_1551;
      }
      
      public function get expirationTime() : int
      {
         return _expirationTime;
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
      
      public function get subProductCodes() : Vector.<String>
      {
         return var_2065;
      }
      
      public function get trackingState() : int
      {
         return var_2693;
      }
   }
}

