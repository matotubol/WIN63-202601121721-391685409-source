package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftTransferAssetsResultMessageEventParser implements IMessageParser
   {
      
      private var var_1587:*;
      
      public function NftTransferAssetsResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1587 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1587 = param1.readShort();
         return true;
      }
      
      public function get success() : Boolean
      {
         return var_1587 == 0;
      }
      
      public function get resultCode() : *
      {
         return var_1587;
      }
   }
}

