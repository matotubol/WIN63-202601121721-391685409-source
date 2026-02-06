package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleMintableItemResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintableItemResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectibleMintableItemResultMessageEvent(param1:Function)
      {
         super(param1,CollectibleMintableItemResultMessageEventParser);
      }
      
      public function getParser() : CollectibleMintableItemResultMessageEventParser
      {
         return var_15 as CollectibleMintableItemResultMessageEventParser;
      }
   }
}

