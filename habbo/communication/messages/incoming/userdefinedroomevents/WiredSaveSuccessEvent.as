package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredSaveSuccessEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredSaveSuccessEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredSaveSuccessEvent(param1:Function)
      {
         super(param1,WiredSaveSuccessEventParser);
      }
      
      public function getParser() : WiredSaveSuccessEventParser
      {
         return this.var_15 as WiredSaveSuccessEventParser;
      }
   }
}

