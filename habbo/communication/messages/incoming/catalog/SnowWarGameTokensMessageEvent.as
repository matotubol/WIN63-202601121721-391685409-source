package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokensMessageParser;
   
   public class SnowWarGameTokensMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SnowWarGameTokensMessageEvent(param1:Function)
      {
         super(param1,SnowWarGameTokensMessageParser);
      }
      
      public function getParser() : SnowWarGameTokensMessageParser
      {
         return this.var_15 as SnowWarGameTokensMessageParser;
      }
   }
}

