package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollectionsScoreMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftCollectionsScoreMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftCollectionsScoreMessageEvent(param1:Function)
      {
         super(param1,NftCollectionsScoreMessageEventParser);
      }
      
      public function getParser() : NftCollectionsScoreMessageEventParser
      {
         return var_15 as NftCollectionsScoreMessageEventParser;
      }
   }
}

