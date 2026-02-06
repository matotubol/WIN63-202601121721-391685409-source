package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class ClubGiftInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ClubGiftInfoEvent(param1:Function)
      {
         super(param1,ClubGiftInfoEventParser);
      }
      
      public function getParser() : ClubGiftInfoEventParser
      {
         return this.var_15 as ClubGiftInfoEventParser;
      }
   }
}

