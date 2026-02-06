package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStoreOffersMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftStoreOffersMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftStoreOffersMessageEvent(param1:Function)
      {
         super(param1,NftStoreOffersMessageEventParser);
      }
      
      public function getParser() : NftStoreOffersMessageEventParser
      {
         return var_15 as NftStoreOffersMessageEventParser;
      }
   }
}

