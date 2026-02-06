package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariableHoldersEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredAllVariableHoldersEvent(param1:Function)
      {
         super(param1,WiredAllVariableHoldersEventParser);
      }
      
      public function getParser() : WiredAllVariableHoldersEventParser
      {
         return this.var_15 as WiredAllVariableHoldersEventParser;
      }
   }
}

