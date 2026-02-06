package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.HabboUserBadgesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboUserBadgesMessageEvent(param1:Function)
      {
         super(param1,HabboUserBadgesMessageEventParser);
      }
      
      public function get badges() : Array
      {
         return (var_15 as HabboUserBadgesMessageEventParser).badges;
      }
      
      public function get userId() : int
      {
         return (var_15 as HabboUserBadgesMessageEventParser).userId;
      }
   }
}

