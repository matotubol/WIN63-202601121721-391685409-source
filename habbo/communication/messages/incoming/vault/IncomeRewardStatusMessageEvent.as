package com.sulake.habbo.communication.messages.incoming.vault
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IncomeRewardStatusMessageEvent(param1:Function)
      {
         super(param1,IncomeRewardStatusMessageEventParser);
      }
      
      public function getParser() : IncomeRewardStatusMessageEventParser
      {
         return var_15 as IncomeRewardStatusMessageEventParser;
      }
   }
}

