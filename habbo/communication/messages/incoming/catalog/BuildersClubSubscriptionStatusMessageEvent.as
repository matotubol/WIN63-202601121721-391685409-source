package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubSubscriptionStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BuildersClubSubscriptionStatusMessageEvent(param1:Function)
      {
         super(param1,BuildersClubSubscriptionStatusMessageEventParser);
      }
      
      public function getParser() : BuildersClubSubscriptionStatusMessageEventParser
      {
         return this.var_15 as BuildersClubSubscriptionStatusMessageEventParser;
      }
   }
}

