package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleMintTokenCountMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenCountMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectibleMintTokenCountMessageEvent(param1:Function)
      {
         super(param1,CollectibleMintTokenCountMessageEventParser);
      }
      
      public function getParser() : CollectibleMintTokenCountMessageEventParser
      {
         return var_15 as CollectibleMintTokenCountMessageEventParser;
      }
   }
}

