package com.sulake.habbo.communication.messages.incoming.campaign
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CampaignCalendarDataMessageEvent(param1:Function)
      {
         super(param1,CampaignCalendarDataMessageEventParser);
      }
      
      public function getParser() : CampaignCalendarDataMessageEventParser
      {
         return var_15 as CampaignCalendarDataMessageEventParser;
      }
   }
}

