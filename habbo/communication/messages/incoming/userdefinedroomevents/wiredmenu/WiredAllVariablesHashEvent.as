package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariablesHashEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariablesHashEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredAllVariablesHashEvent(param1:Function)
      {
         super(param1,WiredAllVariablesHashEventParser);
      }
      
      public function getParser() : WiredAllVariablesHashEventParser
      {
         return this.var_15 as WiredAllVariablesHashEventParser;
      }
   }
}

