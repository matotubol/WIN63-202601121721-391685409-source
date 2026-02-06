package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapMessageEvent extends MessageEvent
   {
      
      public function HeightMapMessageEvent(param1:Function)
      {
         super(param1,HeightMapMessageEventParser);
      }
      
      public function getParser() : HeightMapMessageEventParser
      {
         return var_15 as HeightMapMessageEventParser;
      }
   }
}

