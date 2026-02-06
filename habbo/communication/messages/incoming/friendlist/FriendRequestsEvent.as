package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendRequestsEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendRequestsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendRequestsEvent(param1:Function)
      {
         super(param1,FriendRequestsEventParser);
      }
      
      public function getParser() : FriendRequestsEventParser
      {
         return this.var_15 as FriendRequestsEventParser;
      }
   }
}

