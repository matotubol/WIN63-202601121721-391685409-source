package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredValidationErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredValidationErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredValidationErrorEvent(param1:Function)
      {
         super(param1,WiredValidationErrorEventParser);
      }
      
      public function getParser() : WiredValidationErrorEventParser
      {
         return this.var_15 as WiredValidationErrorEventParser;
      }
   }
}

