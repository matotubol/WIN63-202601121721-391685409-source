package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nux.SelectInitialRoomEventParser;
   
   [SecureSWF(rename="true")]
   public class SelectInitialRoomEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SelectInitialRoomEvent(param1:Function)
      {
         super(param1,SelectInitialRoomEventParser);
      }
      
      public function getParser() : SelectInitialRoomEventParser
      {
         return var_15 as SelectInitialRoomEventParser;
      }
   }
}

