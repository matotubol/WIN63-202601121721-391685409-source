package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SellablePetPalettesMessageEventParser implements IMessageParser
   {
      
      private var var_2711:String = "";
      
      private var var_2238:Array = [];
      
      public function SellablePetPalettesMessageEventParser()
      {
         super();
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get sellablePalettes() : Array
      {
         return var_2238.slice();
      }
      
      public function flush() : Boolean
      {
         var_2711 = "";
         var_2238 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2711 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2238.push(new class_2908(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

