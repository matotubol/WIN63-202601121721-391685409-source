package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BonusRareInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BonusRareInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BonusRareInfoMessageEvent(param1:Function)
      {
         super(param1,BonusRareInfoMessageEventParser);
      }
      
      public function getParser() : BonusRareInfoMessageEventParser
      {
         return this.var_15 as BonusRareInfoMessageEventParser;
      }
   }
}

