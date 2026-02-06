package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftStorePurchaseMessageEventParser implements IMessageParser
   {
      
      public static var name_6:int = 0;
      
      public static var var_5257:int = 1;
      
      private var var_1122:int;
      
      public function NftStorePurchaseMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readShort();
         return true;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
   }
}

