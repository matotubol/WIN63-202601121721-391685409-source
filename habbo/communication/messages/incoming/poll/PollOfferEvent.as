package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.PollOfferEventParser;
   
   [SecureSWF(rename="true")]
   public class PollOfferEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PollOfferEvent(param1:Function)
      {
         super(param1,PollOfferEventParser);
      }
      
      public function getParser() : PollOfferEventParser
      {
         return var_15 as PollOfferEventParser;
      }
   }
}

