package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionOfferedToGuideMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionOfferedToGuideMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ChatReviewSessionOfferedToGuideMessageEvent(param1:Function)
      {
         super(param1,ChatReviewSessionOfferedToGuideMessageEventParser);
      }
      
      public function getParser() : ChatReviewSessionOfferedToGuideMessageEventParser
      {
         return var_15 as ChatReviewSessionOfferedToGuideMessageEventParser;
      }
   }
}

