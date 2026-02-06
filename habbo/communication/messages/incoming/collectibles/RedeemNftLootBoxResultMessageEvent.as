package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.RedeemNftLootBoxResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RedeemNftLootBoxResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RedeemNftLootBoxResultMessageEvent(param1:Function)
      {
         super(param1,RedeemNftLootBoxResultMessageEventParser);
      }
      
      public function getParser() : RedeemNftLootBoxResultMessageEventParser
      {
         return var_15 as RedeemNftLootBoxResultMessageEventParser;
      }
   }
}

