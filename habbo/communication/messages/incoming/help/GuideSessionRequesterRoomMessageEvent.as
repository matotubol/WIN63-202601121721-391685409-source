package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionRequesterRoomMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionRequesterRoomMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionRequesterRoomMessageEvent(param1:Function)
      {
         super(param1,GuideSessionRequesterRoomMessageEventParser);
      }
      
      public function getParser() : GuideSessionRequesterRoomMessageEventParser
      {
         return var_15 as GuideSessionRequesterRoomMessageEventParser;
      }
   }
}

