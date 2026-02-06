package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SnowWarGameTokenOffer
   {
      
      private var _offerId:int;
      
      private var var_1275:String;
      
      private var var_1957:int;
      
      private var var_1865:int;
      
      private var var_2381:int;
      
      private var var_2971:int;
      
      private var var_3748:Boolean;
      
      public function SnowWarGameTokenOffer(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         var_1275 = param1.readString();
         var_1957 = param1.readInteger();
         var_1865 = param1.readInteger();
         var_2381 = param1.readInteger();
         var_3748 = false;
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
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get giftable() : Boolean
      {
         return var_3748;
      }
   }
}

