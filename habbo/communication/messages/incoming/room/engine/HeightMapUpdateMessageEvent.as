package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapUpdateMessageEvent extends MessageEvent
   {
      
      public function HeightMapUpdateMessageEvent(param1:Function)
      {
         super(param1,HeightMapUpdateMessageEventParser);
      }
      
      public function getParser() : HeightMapUpdateMessageEventParser
      {
         return var_15 as HeightMapUpdateMessageEventParser;
      }
   }
}

