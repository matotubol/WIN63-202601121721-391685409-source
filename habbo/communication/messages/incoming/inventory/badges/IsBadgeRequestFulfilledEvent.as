package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.IsBadgeRequestFulfilledEventParser;
   
   [SecureSWF(rename="true")]
   public class IsBadgeRequestFulfilledEvent extends MessageEvent
   {
      
      public function IsBadgeRequestFulfilledEvent(param1:Function)
      {
         super(param1,IsBadgeRequestFulfilledEventParser);
      }
      
      public function getParser() : IsBadgeRequestFulfilledEventParser
      {
         return var_15 as IsBadgeRequestFulfilledEventParser;
      }
   }
}

