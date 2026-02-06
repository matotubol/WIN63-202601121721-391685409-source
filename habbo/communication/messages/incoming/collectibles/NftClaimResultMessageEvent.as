package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaimResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftClaimResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftClaimResultMessageEvent(param1:Function)
      {
         super(param1,NftClaimResultMessageEventParser);
      }
      
      public function getParser() : NftClaimResultMessageEventParser
      {
         return var_15 as NftClaimResultMessageEventParser;
      }
   }
}

