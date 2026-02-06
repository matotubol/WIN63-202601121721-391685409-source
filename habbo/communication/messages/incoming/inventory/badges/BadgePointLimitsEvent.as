package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsEventParser;
   
   [SecureSWF(rename="true")]
   public class BadgePointLimitsEvent extends MessageEvent
   {
      
      public function BadgePointLimitsEvent(param1:Function)
      {
         super(param1,BadgePointLimitsEventParser);
      }
      
      public function getParser() : BadgePointLimitsEventParser
      {
         return var_15 as BadgePointLimitsEventParser;
      }
   }
}

