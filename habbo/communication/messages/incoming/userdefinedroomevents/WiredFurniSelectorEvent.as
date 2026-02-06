package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniSelectorEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniSelectorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniSelectorEvent(param1:Function)
      {
         super(param1,WiredFurniSelectorEventParser);
      }
      
      public function getParser() : WiredFurniSelectorEventParser
      {
         return this.var_15 as WiredFurniSelectorEventParser;
      }
   }
}

