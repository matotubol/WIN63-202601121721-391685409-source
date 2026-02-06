package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleMintingEnabledMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintingEnabledMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectibleMintingEnabledMessageEvent(param1:Function)
      {
         super(param1,CollectibleMintingEnabledMessageEventParser);
      }
      
      public function getParser() : CollectibleMintingEnabledMessageEventParser
      {
         return var_15 as CollectibleMintingEnabledMessageEventParser;
      }
   }
}

