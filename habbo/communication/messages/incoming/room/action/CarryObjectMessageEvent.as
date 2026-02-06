package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CarryObjectMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CarryObjectMessageEvent(param1:Function)
      {
         super(param1,CarryObjectMessageEventParser);
      }
      
      public function getParser() : CarryObjectMessageEventParser
      {
         return var_15 as CarryObjectMessageEventParser;
      }
   }
}

