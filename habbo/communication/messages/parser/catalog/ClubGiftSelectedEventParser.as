package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2104;
   
   [SecureSWF(rename="true")]
   public class ClubGiftSelectedEventParser implements IMessageParser
   {
      
      private var var_2711:String;
      
      private var var_375:Array;
      
      public function ClubGiftSelectedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_375 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_375 = [];
         var_2711 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_375.push(new class_2104(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get products() : Array
      {
         return var_375;
      }
   }
}

