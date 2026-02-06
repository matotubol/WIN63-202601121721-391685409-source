package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedEventParser;
   
   [SecureSWF(rename="true")]
   public class FollowFriendFailedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FollowFriendFailedEvent(param1:Function)
      {
         super(param1,FollowFriendFailedEventParser);
      }
      
      public function getParser() : FollowFriendFailedEventParser
      {
         return this.var_15 as FollowFriendFailedEventParser;
      }
   }
}

