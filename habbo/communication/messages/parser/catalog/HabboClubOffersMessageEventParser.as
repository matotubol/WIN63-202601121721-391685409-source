package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2374;
   
   [SecureSWF(rename="true")]
   public class HabboClubOffersMessageEventParser implements IMessageParser
   {
      
      private var _offers:Array;
      
      private var var_3854:int;
      
      public function HabboClubOffersMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offers = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _offers.push(new class_2374(param1));
            _loc3_++;
         }
         var_3854 = param1.readInteger();
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get source() : int
      {
         return var_3854;
      }
   }
}

