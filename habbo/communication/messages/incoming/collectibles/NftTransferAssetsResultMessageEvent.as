package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferAssetsResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftTransferAssetsResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftTransferAssetsResultMessageEvent(param1:Function)
      {
         super(param1,NftTransferAssetsResultMessageEventParser);
      }
      
      public function getParser() : NftTransferAssetsResultMessageEventParser
      {
         return var_15 as NftTransferAssetsResultMessageEventParser;
      }
   }
}

