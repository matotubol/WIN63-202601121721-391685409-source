package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredClickUserResponseEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredClickUserResponseEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredClickUserResponseEvent(param1:Function)
      {
         super(param1,WiredClickUserResponseEventParser);
      }
      
      public function getParser() : WiredClickUserResponseEventParser
      {
         return this.var_15 as WiredClickUserResponseEventParser;
      }
   }
}

