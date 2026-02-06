package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.IsFirstLoginOfDayEventParser;
   
   [SecureSWF(rename="true")]
   public class IsFirstLoginOfDayEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IsFirstLoginOfDayEvent(param1:Function)
      {
         super(param1,IsFirstLoginOfDayEventParser);
      }
      
      public function getParser() : IsFirstLoginOfDayEventParser
      {
         return this.var_15 as IsFirstLoginOfDayEventParser;
      }
   }
}

