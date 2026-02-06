package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniActionEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniActionEvent(param1:Function)
      {
         super(param1,WiredFurniActionEventParser);
      }
      
      public function getParser() : WiredFurniActionEventParser
      {
         return this.var_15 as WiredFurniActionEventParser;
      }
   }
}

