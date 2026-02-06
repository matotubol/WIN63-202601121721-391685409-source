package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceNotCompleteEventParser implements IMessageParser
   {
      
      public function NewUserExperienceNotCompleteEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
   }
}

