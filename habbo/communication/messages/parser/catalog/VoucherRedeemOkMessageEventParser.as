package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class VoucherRedeemOkMessageEventParser implements IMessageParser
   {
      
      private var _productName:String = "";
      
      private var var_1593:String = "";
      
      public function VoucherRedeemOkMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1593 = "";
         _productName = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1593 = param1.readString();
         _productName = param1.readString();
         return true;
      }
      
      public function get productName() : String
      {
         return _productName;
      }
      
      public function get productDescription() : String
      {
         return var_1593;
      }
   }
}

