package com.sulake.habbo.communication.messages.incoming.hotlooks
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.hotlooks.HotLooksMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HotLooksMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HotLooksMessageEvent(param1:Function)
      {
         super(param1,HotLooksMessageEventParser);
      }
      
      public function getParser() : HotLooksMessageEventParser
      {
         return var_15 as HotLooksMessageEventParser;
      }
   }
}

