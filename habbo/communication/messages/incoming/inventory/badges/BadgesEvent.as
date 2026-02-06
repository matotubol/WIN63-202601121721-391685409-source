package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEventParser;
   
   [SecureSWF(rename="true")]
   public class BadgesEvent extends MessageEvent
   {
      
      public function BadgesEvent(param1:Function)
      {
         super(param1,BadgesEventParser);
      }
      
      public function getParser() : BadgesEventParser
      {
         return var_15 as BadgesEventParser;
      }
   }
}

