package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestionEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestionEvent(param1:Function)
      {
         super(param1,QuestionEventParser);
      }
      
      public function getParser() : QuestionEventParser
      {
         return var_15 as QuestionEventParser;
      }
   }
}

