package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftRewardItemClaimResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftRewardItemClaimResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftRewardItemClaimResultMessageEvent(param1:Function)
      {
         super(param1,NftRewardItemClaimResultMessageEventParser);
      }
      
      public function getParser() : NftRewardItemClaimResultMessageEventParser
      {
         return var_15 as NftRewardItemClaimResultMessageEventParser;
      }
   }
}

