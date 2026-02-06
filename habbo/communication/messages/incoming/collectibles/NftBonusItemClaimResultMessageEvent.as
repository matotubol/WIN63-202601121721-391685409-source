package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftBonusItemClaimResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftBonusItemClaimResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftBonusItemClaimResultMessageEvent(param1:Function)
      {
         super(param1,NftBonusItemClaimResultMessageEventParser);
      }
      
      public function getParser() : NftBonusItemClaimResultMessageEventParser
      {
         return var_15 as NftBonusItemClaimResultMessageEventParser;
      }
   }
}

