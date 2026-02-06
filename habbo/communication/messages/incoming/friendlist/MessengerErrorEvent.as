package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class MessengerErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MessengerErrorEvent(param1:Function)
      {
         super(param1,MessengerErrorEventParser);
      }
      
      public function getParser() : MessengerErrorEventParser
      {
         return this.var_15 as MessengerErrorEventParser;
      }
   }
}

