package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDataMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_2349;
      
      public function CampaignCalendarDataMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_2349();
         var_24.parse(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function cloneData() : class_2349
      {
         return var_24 ? var_24.clone() : null;
      }
   }
}

