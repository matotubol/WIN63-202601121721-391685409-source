package com.sulake.habbo.communication.messages.incoming.vault
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IncomeRewardNotificationMessageEvent(param1:Function)
      {
         super(param1,IncomeRewardNotificationMessageEventParser);
      }
      
      public function getParser() : IncomeRewardNotificationMessageEventParser
      {
         return var_15 as IncomeRewardNotificationMessageEventParser;
      }
   }
}

