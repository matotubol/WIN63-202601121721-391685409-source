package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniAddonEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniAddonEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniAddonEvent(param1:Function)
      {
         super(param1,WiredFurniAddonEventParser);
      }
      
      public function getParser() : WiredFurniAddonEventParser
      {
         return this.var_15 as WiredFurniAddonEventParser;
      }
   }
}

