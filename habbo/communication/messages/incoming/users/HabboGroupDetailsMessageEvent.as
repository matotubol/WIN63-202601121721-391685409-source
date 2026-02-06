package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.HabboGroupDetailsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboGroupDetailsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboGroupDetailsMessageEvent(param1:Function)
      {
         super(param1,HabboGroupDetailsMessageEventParser);
      }
      
      public function get data() : class_1846
      {
         return HabboGroupDetailsMessageEventParser(var_15).data;
      }
   }
}

