package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniTriggerEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniTriggerEvent(param1:Function)
      {
         super(param1,WiredFurniTriggerEventParser);
      }
      
      public function getParser() : WiredFurniTriggerEventParser
      {
         return this.var_15 as WiredFurniTriggerEventParser;
      }
   }
}

