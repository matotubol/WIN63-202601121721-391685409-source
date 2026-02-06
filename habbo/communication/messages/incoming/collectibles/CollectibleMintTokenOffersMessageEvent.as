package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleMintTokenOffersMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenOffersMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectibleMintTokenOffersMessageEvent(param1:Function)
      {
         super(param1,CollectibleMintTokenOffersMessageEventParser);
      }
      
      public function getParser() : CollectibleMintTokenOffersMessageEventParser
      {
         return var_15 as CollectibleMintTokenOffersMessageEventParser;
      }
   }
}

