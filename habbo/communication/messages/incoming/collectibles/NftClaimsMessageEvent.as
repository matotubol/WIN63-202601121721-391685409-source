package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaimsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NftClaimsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftClaimsMessageEvent(param1:Function)
      {
         super(param1,NftClaimsMessageEventParser);
      }
      
      public function getParser() : NftClaimsMessageEventParser
      {
         return var_15 as NftClaimsMessageEventParser;
      }
   }
}

