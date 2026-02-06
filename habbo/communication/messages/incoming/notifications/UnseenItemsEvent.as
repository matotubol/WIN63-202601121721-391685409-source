package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsEventParser;
   
   [SecureSWF(rename="true")]
   public class UnseenItemsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UnseenItemsEvent(param1:Function)
      {
         super(param1,UnseenItemsEventParser);
      }
      
      public function getParser() : UnseenItemsEventParser
      {
         return var_15 as UnseenItemsEventParser;
      }
   }
}

