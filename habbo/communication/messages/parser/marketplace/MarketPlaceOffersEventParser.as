package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.communication.messages.incoming.marketplace.class_3020;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOffersEventParser implements IMessageParser
   {
      
      public static const const_798:int = 1;
      
      public static const const_1086:int = 2;
      
      public static const const_852:int = 3;
      
      private const const_284:int = 500;
      
      private var _offers:Array;
      
      private var var_4423:int;
      
      public function MarketPlaceOffersEventParser()
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
         var _loc10_:IStuffData = null;
         var _loc9_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(0 < _loc9_)
         {
            _loc10_ = null;
            var _loc12_:int = param1.readInteger();
            var _loc14_:int = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc11_:int = param1.readInteger();
            var _loc8_:int = param1.readInteger();
            var _loc13_:int = param1.readInteger();
            var _loc6_:int = param1.readInteger();
            var _loc3_:class_3020 = new class_3020(0,0,0,_loc5_,_loc10_,0,0,0,0,0);
            _offers.push(null);
            _loc7_++;
         }
         var_4423 = param1.readInteger();
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get totalItemsFound() : int
      {
         return var_4423;
      }
   }
}

