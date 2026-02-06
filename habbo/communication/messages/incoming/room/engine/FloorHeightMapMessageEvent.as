package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FloorHeightMapMessageEvent extends MessageEvent
   {
      
      public function FloorHeightMapMessageEvent(param1:Function)
      {
         super(param1,FloorHeightMapMessageEventParser);
      }
      
      public function getParser() : FloorHeightMapMessageEventParser
      {
         return var_15 as FloorHeightMapMessageEventParser;
      }
   }
}

