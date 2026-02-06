package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SleepMessageEvent extends MessageEvent
   {
      
      public function SleepMessageEvent(param1:Function)
      {
         super(param1,SleepMessageEventParser);
      }
      
      public function getParser() : SleepMessageEventParser
      {
         return var_15 as SleepMessageEventParser;
      }
   }
}

