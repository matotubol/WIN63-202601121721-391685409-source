package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.CustomUserNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CustomUserNotificationMessageEvent extends MessageEvent
   {
      
      public function CustomUserNotificationMessageEvent(param1:Function)
      {
         super(param1,CustomUserNotificationMessageEventParser);
      }
      
      public function getParser() : CustomUserNotificationMessageEventParser
      {
         return parser as CustomUserNotificationMessageEventParser;
      }
   }
}

