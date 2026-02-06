package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class InstantMessageErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InstantMessageErrorEvent(param1:Function)
      {
         super(param1,InstantMessageErrorEventParser);
      }
      
      public function getParser() : InstantMessageErrorEventParser
      {
         return this.var_15 as InstantMessageErrorEventParser;
      }
   }
}

