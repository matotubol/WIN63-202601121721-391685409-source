package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionOfferedToGuideMessageEventParser implements IMessageParser
   {
      
      private var var_3355:int;
      
      public function ChatReviewSessionOfferedToGuideMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3355 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3355 = param1.readInteger();
         return true;
      }
      
      public function get acceptanceTimeout() : int
      {
         return var_3355;
      }
   }
}

