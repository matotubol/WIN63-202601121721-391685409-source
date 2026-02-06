package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectableMintableItemTypesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CollectableMintableItemTypesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CollectableMintableItemTypesMessageEvent(param1:Function)
      {
         super(param1,CollectableMintableItemTypesMessageEventParser);
      }
      
      public function getParser() : CollectableMintableItemTypesMessageEventParser
      {
         return var_15 as CollectableMintableItemTypesMessageEventParser;
      }
   }
}

