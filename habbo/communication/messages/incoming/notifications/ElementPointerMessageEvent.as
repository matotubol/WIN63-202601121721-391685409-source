package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.ElementPointerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ElementPointerMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ElementPointerMessageEvent(param1:Function)
      {
         super(param1,ElementPointerMessageEventParser);
      }
      
      public function getParser() : ElementPointerMessageEventParser
      {
         return var_15 as ElementPointerMessageEventParser;
      }
   }
}

