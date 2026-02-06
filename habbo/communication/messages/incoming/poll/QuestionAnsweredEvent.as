package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionAnsweredEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestionAnsweredEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestionAnsweredEvent(param1:Function)
      {
         super(param1,QuestionAnsweredEventParser);
      }
      
      public function getParser() : QuestionAnsweredEventParser
      {
         return var_15 as QuestionAnsweredEventParser;
      }
   }
}

