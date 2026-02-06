package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredErrorLogsEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredErrorLogsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredErrorLogsEvent(param1:Function)
      {
         super(param1,WiredErrorLogsEventParser);
      }
      
      public function getParser() : WiredErrorLogsEventParser
      {
         return this.var_15 as WiredErrorLogsEventParser;
      }
   }
}

