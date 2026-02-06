package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.HabboGroupDeactivatedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboGroupDeactivatedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboGroupDeactivatedMessageEvent(param1:Function)
      {
         super(param1,HabboGroupDeactivatedMessageEventParser);
      }
      
      public function get groupId() : int
      {
         return HabboGroupDeactivatedMessageEventParser(var_15).groupId;
      }
   }
}

