package com.sulake.habbo.communication.messages.incoming.userclassification
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userclassification.UserClassificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserClassificationMessageEvent extends MessageEvent
   {
      
      public function UserClassificationMessageEvent(param1:Function)
      {
         super(param1,UserClassificationMessageEventParser);
      }
      
      public function getParser() : UserClassificationMessageEventParser
      {
         return var_15 as UserClassificationMessageEventParser;
      }
   }
}

