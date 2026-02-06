package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UseObjectMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UseObjectMessageEvent(param1:Function)
      {
         super(param1,UseObjectMessageEventParser);
      }
      
      public function getParser() : UseObjectMessageEventParser
      {
         return var_15 as UseObjectMessageEventParser;
      }
   }
}

