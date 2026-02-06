package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitEventParser;
   
   [SecureSWF(rename="true")]
   public class MessengerInitEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MessengerInitEvent(param1:Function)
      {
         super(param1,MessengerInitEventParser);
      }
      
      public function getParser() : MessengerInitEventParser
      {
         return this.var_15 as MessengerInitEventParser;
      }
   }
}

