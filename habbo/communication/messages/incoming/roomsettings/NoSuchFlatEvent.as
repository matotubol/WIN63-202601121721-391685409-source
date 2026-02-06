package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.NoSuchFlatEventParser;
   
   [SecureSWF(rename="true")]
   public class NoSuchFlatEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NoSuchFlatEvent(param1:Function)
      {
         super(param1,NoSuchFlatEventParser);
      }
      
      public function getParser() : NoSuchFlatEventParser
      {
         return this.var_15 as NoSuchFlatEventParser;
      }
   }
}

