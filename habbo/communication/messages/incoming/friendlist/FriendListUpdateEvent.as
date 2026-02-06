package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendListUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendListUpdateEvent(param1:Function)
      {
         super(param1,FriendListUpdateEventParser);
      }
      
      public function getParser() : FriendListUpdateEventParser
      {
         return this.var_15 as FriendListUpdateEventParser;
      }
   }
}

