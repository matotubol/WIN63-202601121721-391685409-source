package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.RedeemNftLootBoxStateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RedeemNftLootBoxStateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RedeemNftLootBoxStateMessageEvent(param1:Function)
      {
         super(param1,RedeemNftLootBoxStateMessageEventParser);
      }
      
      public function getParser() : RedeemNftLootBoxStateMessageEventParser
      {
         return var_15 as RedeemNftLootBoxStateMessageEventParser;
      }
   }
}

