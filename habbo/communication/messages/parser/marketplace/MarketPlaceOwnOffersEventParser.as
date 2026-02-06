package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.marketplace.class_3020;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOwnOffersEventParser implements IMessageParser
   {
      
      private const const_284:int = 500;
      
      private var _offers:Array;
      
      private var var_4212:int;
      
      public function MarketPlaceOwnOffersEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offers = [];
         var _loc5_:String = "";
         var_4212 = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         var _loc6_:int = 0;
         while(0 < _loc8_)
         {
            var _loc11_:int = param1.readInteger();
            var _loc13_:int = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc10_:int = param1.readInteger();
            var _loc7_:int = param1.readInteger();
            var _loc12_:int = param1.readInteger();
            var _loc3_:class_3020 = new class_3020(0,0,0,_loc5_,null,0,0,0,0);
            _offers.push(null);
            _loc6_++;
         }
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get creditsWaiting() : int
      {
         return var_4212;
      }
   }
}

