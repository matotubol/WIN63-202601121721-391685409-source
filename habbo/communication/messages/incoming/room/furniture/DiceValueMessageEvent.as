package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DiceValueMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function DiceValueMessageEvent(param1:Function)
      {
         super(param1,DiceValueMessageEventParser);
      }
      
      public function getParser() : DiceValueMessageEventParser
      {
         return var_15 as DiceValueMessageEventParser;
      }
   }
}

