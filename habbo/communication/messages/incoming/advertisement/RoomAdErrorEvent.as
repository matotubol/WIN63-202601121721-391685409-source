package com.sulake.habbo.communication.messages.incoming.advertisement
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomAdErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomAdErrorEvent(param1:Function)
      {
         super(param1,RoomAdErrorEventParser);
      }
      
      public function getParser() : RoomAdErrorEventParser
      {
         return this.var_15 as RoomAdErrorEventParser;
      }
   }
}

