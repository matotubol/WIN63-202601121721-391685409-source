package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenEventParser;
   
   [SecureSWF(rename="true")]
   public class OpenEvent extends MessageEvent implements IMessageEvent
   {
      
      public function OpenEvent(param1:Function)
      {
         super(param1,OpenEventParser);
      }
      
      public function getParser() : OpenEventParser
      {
         return this.var_15 as OpenEventParser;
      }
   }
}

