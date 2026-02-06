package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedEventParser;
   
   [SecureSWF(rename="true")]
   public class ClubGiftSelectedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ClubGiftSelectedEvent(param1:Function)
      {
         super(param1,ClubGiftSelectedEventParser);
      }
      
      public function getParser() : ClubGiftSelectedEventParser
      {
         return this.var_15 as ClubGiftSelectedEventParser;
      }
   }
}

