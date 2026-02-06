package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniConditionEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredFurniConditionEvent(param1:Function)
      {
         super(param1,WiredFurniConditionEventParser);
      }
      
      public function getParser() : WiredFurniConditionEventParser
      {
         return this.var_15 as WiredFurniConditionEventParser;
      }
   }
}

