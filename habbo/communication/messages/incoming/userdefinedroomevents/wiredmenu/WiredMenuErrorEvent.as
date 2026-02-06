package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredMenuErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredMenuErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredMenuErrorEvent(param1:Function)
      {
         super(param1,WiredMenuErrorEventParser);
      }
      
      public function getParser() : WiredMenuErrorEventParser
      {
         return this.var_15 as WiredMenuErrorEventParser;
      }
   }
}

