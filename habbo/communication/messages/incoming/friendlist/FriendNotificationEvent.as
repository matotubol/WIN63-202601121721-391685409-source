package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendNotificationEvent(param1:Function)
      {
         super(param1,FriendNotificationEventParser);
      }
      
      public function getParser() : FriendNotificationEventParser
      {
         return var_15 as FriendNotificationEventParser;
      }
   }
}

