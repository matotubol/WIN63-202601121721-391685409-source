package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.LimitedEditionSoldOutEventParser;
   
   [SecureSWF(rename="true")]
   public class LimitedEditionSoldOutEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LimitedEditionSoldOutEvent(param1:Function)
      {
         super(param1,LimitedEditionSoldOutEventParser);
      }
      
      public function getParser() : LimitedEditionSoldOutEventParser
      {
         return this.var_15 as LimitedEditionSoldOutEventParser;
      }
   }
}

