package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.AreaHideMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AreaHideMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AreaHideMessageEvent(param1:Function)
      {
         super(param1,AreaHideMessageEventParser);
      }
      
      public function getParser() : AreaHideMessageEventParser
      {
         return var_15 as AreaHideMessageEventParser;
      }
   }
}

