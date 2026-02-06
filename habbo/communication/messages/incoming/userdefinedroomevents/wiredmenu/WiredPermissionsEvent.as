package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredPermissionsEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredPermissionsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredPermissionsEvent(param1:Function)
      {
         super(param1,WiredPermissionsEventParser);
      }
      
      public function getParser() : WiredPermissionsEventParser
      {
         return this.var_15 as WiredPermissionsEventParser;
      }
   }
}

