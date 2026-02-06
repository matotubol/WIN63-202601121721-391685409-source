package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListFragmentMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendListFragmentMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendListFragmentMessageEvent(param1:Function)
      {
         super(param1,FriendListFragmentMessageEventParser);
      }
      
      public function getParser() : FriendListFragmentMessageEventParser
      {
         return this.var_15 as FriendListFragmentMessageEventParser;
      }
   }
}

