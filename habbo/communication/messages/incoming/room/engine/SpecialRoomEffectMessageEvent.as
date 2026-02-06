package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.SpecialRoomEffectMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SpecialRoomEffectMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SpecialRoomEffectMessageEvent(param1:Function)
      {
         super(param1,SpecialRoomEffectMessageEventParser);
      }
   }
}

