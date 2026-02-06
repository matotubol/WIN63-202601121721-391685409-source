package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferFeeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftTransferFeeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftTransferFeeMessageEvent(param1:Function)
      {
         super(param1,NftTransferFeeMessageEventParser);
      }
      
      public function getParser() : NftTransferFeeMessageEventParser
      {
         return var_15 as NftTransferFeeMessageEventParser;
      }
   }
}

