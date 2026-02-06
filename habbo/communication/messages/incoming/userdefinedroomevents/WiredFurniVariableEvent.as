package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniVariableEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniVariableEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniVariableEvent(param1:Function)
      {
         super(param1,WiredFurniVariableEventParser);
      }
      
      public function getParser() : WiredFurniVariableEventParser
      {
         return this.var_15 as WiredFurniVariableEventParser;
      }
   }
}

