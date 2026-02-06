package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FindFriendsProcessResultEventParser;
   
   [SecureSWF(rename="true")]
   public class FindFriendsProcessResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FindFriendsProcessResultEvent(param1:Function)
      {
         super(param1,FindFriendsProcessResultEventParser);
      }
      
      public function get success() : Boolean
      {
         return FindFriendsProcessResultEventParser(var_15).success;
      }
   }
}

