package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FurniRentOrBuyoutOfferMessageEventParser implements IMessageParser
   {
      
      private var var_3022:Boolean;
      
      private var _furniTypeName:String;
      
      private var var_5076:Boolean;
      
      private var var_1957:int;
      
      private var var_1865:int;
      
      private var var_2381:int;
      
      public function FurniRentOrBuyoutOfferMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3022 = param1.readBoolean();
         _furniTypeName = param1.readString();
         var_5076 = param1.readBoolean();
         var_1957 = param1.readInteger();
         var_1865 = param1.readInteger();
         var_2381 = param1.readInteger();
         return true;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_3022;
      }
      
      public function get furniTypeName() : String
      {
         return _furniTypeName;
      }
      
      public function get buyout() : Boolean
      {
         return var_5076;
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
   }
}

