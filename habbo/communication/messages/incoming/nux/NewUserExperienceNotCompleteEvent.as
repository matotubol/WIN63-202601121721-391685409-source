package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceNotCompleteEventParser;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceNotCompleteEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NewUserExperienceNotCompleteEvent(param1:Function)
      {
         super(param1,NewUserExperienceNotCompleteEventParser);
      }
      
      public function getParser() : NewUserExperienceNotCompleteEventParser
      {
         return var_15 as NewUserExperienceNotCompleteEventParser;
      }
   }
}

