package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.QuizResultsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuizResultsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuizResultsMessageEvent(param1:Function)
      {
         super(param1,QuizResultsMessageEventParser);
      }
      
      public function getParser() : QuizResultsMessageEventParser
      {
         return var_15 as QuizResultsMessageEventParser;
      }
   }
}

