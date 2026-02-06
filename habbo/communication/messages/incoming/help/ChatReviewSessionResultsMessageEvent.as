package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionResultsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionResultsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ChatReviewSessionResultsMessageEvent(param1:Function)
      {
         super(param1,ChatReviewSessionResultsMessageEventParser);
      }
      
      public function getParser() : ChatReviewSessionResultsMessageEventParser
      {
         return var_15 as ChatReviewSessionResultsMessageEventParser;
      }
   }
}

