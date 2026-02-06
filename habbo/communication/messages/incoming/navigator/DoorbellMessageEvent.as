package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.DoorbellMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DoorbellMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function DoorbellMessageEvent(param1:Function)
      {
         super(param1,DoorbellMessageEventParser);
      }
      
      public function get userName() : String
      {
         return (this.var_15 as DoorbellMessageEventParser).userName;
      }
   }
}

