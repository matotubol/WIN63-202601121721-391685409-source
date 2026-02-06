package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStorePurchaseMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftStorePurchaseMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftStorePurchaseMessageEvent(param1:Function)
      {
         super(param1,NftStorePurchaseMessageEventParser);
      }
      
      public function getParser() : NftStorePurchaseMessageEventParser
      {
         return var_15 as NftStorePurchaseMessageEventParser;
      }
   }
}

