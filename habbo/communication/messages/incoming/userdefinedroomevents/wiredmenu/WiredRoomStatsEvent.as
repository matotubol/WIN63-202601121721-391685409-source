package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredRoomStatsEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredRoomStatsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredRoomStatsEvent(param1:Function)
      {
         super(param1,WiredRoomStatsEventParser);
      }
      
      public function getParser() : WiredRoomStatsEventParser
      {
         return this.var_15 as WiredRoomStatsEventParser;
      }
   }
}

