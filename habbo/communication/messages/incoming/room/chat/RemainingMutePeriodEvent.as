package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.RemainingMutePeriodEventParser;
   
   [SecureSWF(rename="true")]
   public class RemainingMutePeriodEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RemainingMutePeriodEvent(param1:Function)
      {
         super(param1,RemainingMutePeriodEventParser);
      }
      
      public function get secondsRemaining() : int
      {
         return RemainingMutePeriodEventParser(var_15).secondsRemaining;
      }
   }
}

