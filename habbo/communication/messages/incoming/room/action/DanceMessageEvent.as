package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DanceMessageEvent extends MessageEvent
   {
      
      public function DanceMessageEvent(param1:Function)
      {
         super(param1,DanceMessageEventParser);
      }
      
      public function getParser() : DanceMessageEventParser
      {
         return var_15 as DanceMessageEventParser;
      }
   }
}

