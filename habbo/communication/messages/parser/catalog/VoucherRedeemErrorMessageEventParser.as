package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class VoucherRedeemErrorMessageEventParser implements IMessageParser
   {
      
      private var var_2759:String = "";
      
      public function VoucherRedeemErrorMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2759 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readString();
         return true;
      }
      
      public function get errorCode() : String
      {
         return var_2759;
      }
   }
}

