package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FlatAccessDeniedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FlatAccessDeniedMessageEvent(param1:Function)
      {
         super(param1,FlatAccessDeniedMessageEventParser);
      }
      
      public function getParser() : FlatAccessDeniedMessageEventParser
      {
         return var_15 as FlatAccessDeniedMessageEventParser;
      }
   }
}

