package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.SilverBalanceMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SilverBalanceMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SilverBalanceMessageEvent(param1:Function)
      {
         super(param1,SilverBalanceMessageEventParser);
      }
      
      public function getParser() : SilverBalanceMessageEventParser
      {
         return var_15 as SilverBalanceMessageEventParser;
      }
   }
}

