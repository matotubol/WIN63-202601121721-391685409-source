package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatCreatedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FlatCreatedEvent(param1:Function)
      {
         super(param1,FlatCreatedEventParser);
      }
      
      public function getParser() : FlatCreatedEventParser
      {
         return this.var_15 as FlatCreatedEventParser;
      }
   }
}

