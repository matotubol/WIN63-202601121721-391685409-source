package com.sulake.habbo.communication.messages.incoming.campaign
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDoorOpenedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDoorOpenedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CampaignCalendarDoorOpenedMessageEvent(param1:Function)
      {
         super(param1,CampaignCalendarDoorOpenedMessageEventParser);
      }
      
      public function getParser() : CampaignCalendarDoorOpenedMessageEventParser
      {
         return var_15 as CampaignCalendarDoorOpenedMessageEventParser;
      }
   }
}

