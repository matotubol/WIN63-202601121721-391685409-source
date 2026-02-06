package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class SnowWarGameTokensMessageParser implements IMessageParser
   {
      
      private var _offers:Array;
      
      public function SnowWarGameTokensMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = [];
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offers = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _offers.push(new SnowWarGameTokenOffer(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

