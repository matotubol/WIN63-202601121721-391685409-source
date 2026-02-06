package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class MaintenanceStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MaintenanceStatusMessageEvent(param1:Function)
      {
         super(param1,MaintenanceStatusMessageEventParser);
      }
      
      public function getParser() : MaintenanceStatusMessageEventParser
      {
         return var_15 as MaintenanceStatusMessageEventParser;
      }
   }
}

