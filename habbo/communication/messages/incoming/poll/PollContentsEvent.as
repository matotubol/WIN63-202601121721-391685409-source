package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.PollContentsEventParser;
   
   [SecureSWF(rename="true")]
   public class PollContentsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PollContentsEvent(param1:Function)
      {
         super(param1,PollContentsEventParser);
      }
      
      public function getParser() : PollContentsEventParser
      {
         return var_15 as PollContentsEventParser;
      }
   }
}

