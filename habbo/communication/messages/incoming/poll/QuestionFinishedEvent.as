package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionFinishedEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestionFinishedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestionFinishedEvent(param1:Function)
      {
         super(param1,QuestionFinishedEventParser);
      }
      
      public function getParser() : QuestionFinishedEventParser
      {
         return var_15 as QuestionFinishedEventParser;
      }
   }
}

