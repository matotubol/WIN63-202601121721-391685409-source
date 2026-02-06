package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.QuizDataMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuizDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuizDataMessageEvent(param1:Function)
      {
         super(param1,QuizDataMessageEventParser);
      }
      
      public function getParser() : QuizDataMessageEventParser
      {
         return var_15 as QuizDataMessageEventParser;
      }
   }
}

