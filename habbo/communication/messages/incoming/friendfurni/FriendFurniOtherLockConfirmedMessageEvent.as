package com.sulake.habbo.communication.messages.incoming.friendfurni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniOtherLockConfirmedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniOtherLockConfirmedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendFurniOtherLockConfirmedMessageEvent(param1:Function)
      {
         super(param1,FriendFurniOtherLockConfirmedMessageEventParser);
      }
      
      public function getParser() : FriendFurniOtherLockConfirmedMessageEventParser
      {
         return var_15 as FriendFurniOtherLockConfirmedMessageEventParser;
      }
   }
}

