package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_1933
   {
      
      public static const const_386:int = 0;
      
      public static const const_1046:int = 1;
      
      public static const const_543:int = 2;
      
      private var var_230:int;
      
      private var var_2134:int;
      
      private var _itemName:String;
      
      private var var_3963:String;
      
      private var var_4118:String;
      
      private var var_2711:String;
      
      private var var_3912:int;
      
      private var _expirationTime:int;
      
      public function class_1933(param1:IMessageDataWrapper)
      {
         super();
         if(!param1)
         {
            return;
         }
         var_2134 = param1.readInteger();
         _itemName = param1.readString();
         var_3963 = param1.readString();
         var_230 = param1.readInteger();
         switch(var_230)
         {
            case 0:
               var_4118 = param1.readString();
               break;
            case 1:
               var_3912 = param1.readInteger();
               break;
            case 2:
               var_2711 = param1.readString();
         }
         var _loc2_:int = param1.readInteger();
         _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
      }
      
      public function get position() : int
      {
         return var_2134;
      }
      
      public function get itemName() : String
      {
         return _itemName;
      }
      
      public function get itemPromoImage() : String
      {
         return var_3963;
      }
      
      public function get cataloguePageLocation() : String
      {
         return var_4118;
      }
      
      public function get offerExpires() : Boolean
      {
         return _expirationTime > 0;
      }
      
      public function get secondsToExpiration() : int
      {
         return _expirationTime - getTimer();
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get productOfferID() : int
      {
         return var_3912;
      }
   }
}

