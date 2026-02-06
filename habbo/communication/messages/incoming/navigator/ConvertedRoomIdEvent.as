package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdEventParser;
   
   [SecureSWF(rename="true")]
   public class ConvertedRoomIdEvent extends MessageEvent
   {
      
      public function ConvertedRoomIdEvent(param1:Function)
      {
         super(param1,ConvertedRoomIdEventParser);
      }
      
      public function get globalId() : String
      {
         return (this.var_15 as ConvertedRoomIdEventParser).globalId;
      }
      
      public function get convertedId() : int
      {
         return (this.var_15 as ConvertedRoomIdEventParser).convertedId;
      }
      
      public function getParser() : ConvertedRoomIdEventParser
      {
         return var_15 as ConvertedRoomIdEventParser;
      }
   }
}

