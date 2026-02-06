package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NotEnoughBalanceMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NotEnoughBalanceMessageEvent(param1:Function)
      {
         super(param1,NotEnoughBalanceMessageEventParser);
      }
      
      public function getParser() : NotEnoughBalanceMessageEventParser
      {
         return this.var_15 as NotEnoughBalanceMessageEventParser;
      }
   }
}

