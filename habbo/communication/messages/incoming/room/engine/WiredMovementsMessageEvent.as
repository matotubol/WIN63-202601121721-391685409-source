package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.WiredMovementsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredMovementsMessageEvent extends MessageEvent
   {
      
      public function WiredMovementsMessageEvent(param1:Function)
      {
         super(param1,WiredMovementsMessageEventParser);
      }
      
      public function getParser() : WiredMovementsMessageEventParser
      {
         return var_15 as WiredMovementsMessageEventParser;
      }
   }
}

