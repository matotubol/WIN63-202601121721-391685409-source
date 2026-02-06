package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollectionsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftCollectionsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftCollectionsMessageEvent(param1:Function)
      {
         super(param1,NftCollectionsMessageEventParser);
      }
      
      public function getParser() : NftCollectionsMessageEventParser
      {
         return var_15 as NftCollectionsMessageEventParser;
      }
   }
}

