package com.sulake.habbo.communication.messages.incoming.friendfurni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniCancelLockMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniCancelLockMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FriendFurniCancelLockMessageEvent(param1:Function)
      {
         super(param1,FriendFurniCancelLockMessageEventParser);
      }
      
      public function getParser() : FriendFurniCancelLockMessageEventParser
      {
         return var_15 as FriendFurniCancelLockMessageEventParser;
      }
   }
}

