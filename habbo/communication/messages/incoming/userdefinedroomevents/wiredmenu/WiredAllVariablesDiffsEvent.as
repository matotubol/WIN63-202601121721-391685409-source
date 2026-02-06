package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariablesDiffsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredAllVariablesDiffsEvent(param1:Function)
      {
         super(param1,WiredAllVariablesDiffsEventParser);
      }
      
      public function getParser() : WiredAllVariablesDiffsEventParser
      {
         return this.var_15 as WiredAllVariablesDiffsEventParser;
      }
   }
}

