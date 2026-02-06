package com.sulake.habbo.communication.messages.incoming.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceEventParser;
   
   [SecureSWF(rename="true")]
   public class CreditBalanceEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CreditBalanceEvent(param1:Function)
      {
         super(param1,CreditBalanceEventParser);
      }
      
      public function getParser() : CreditBalanceEventParser
      {
         return this.var_15 as CreditBalanceEventParser;
      }
   }
}

