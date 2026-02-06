package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemOkMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class VoucherRedeemOkMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function VoucherRedeemOkMessageEvent(param1:Function)
      {
         super(param1,VoucherRedeemOkMessageEventParser);
      }
      
      public function get productName() : String
      {
         return (var_15 as VoucherRedeemOkMessageEventParser).productName;
      }
      
      public function get productDescription() : String
      {
         return (var_15 as VoucherRedeemOkMessageEventParser).productDescription;
      }
   }
}

