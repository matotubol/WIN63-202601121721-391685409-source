package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PurchaseErrorMessageEventParser implements IMessageParser
   {
      
      private var var_2759:int = 0;
      
      public function PurchaseErrorMessageEventParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function flush() : Boolean
      {
         var_2759 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readInteger();
         return true;
      }
   }
}

