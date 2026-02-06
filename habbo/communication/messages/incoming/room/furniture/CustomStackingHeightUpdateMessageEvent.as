package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.CustomStackingHeightUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CustomStackingHeightUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CustomStackingHeightUpdateMessageEvent(param1:Function)
      {
         super(param1,CustomStackingHeightUpdateMessageEventParser);
      }
      
      public function getParser() : CustomStackingHeightUpdateMessageEventParser
      {
         return var_15 as CustomStackingHeightUpdateMessageEventParser;
      }
   }
}

