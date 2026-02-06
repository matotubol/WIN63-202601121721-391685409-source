package com.sulake.habbo.communication.messages.incoming.vault
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardClaimResponseMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardClaimResponseMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IncomeRewardClaimResponseMessageEvent(param1:Function)
      {
         super(param1,IncomeRewardClaimResponseMessageEventParser);
      }
      
      public function getParser() : IncomeRewardClaimResponseMessageEventParser
      {
         return var_15 as IncomeRewardClaimResponseMessageEventParser;
      }
   }
}

