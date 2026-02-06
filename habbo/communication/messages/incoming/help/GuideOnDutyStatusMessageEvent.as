package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideOnDutyStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideOnDutyStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideOnDutyStatusMessageEvent(param1:Function)
      {
         super(param1,GuideOnDutyStatusMessageEventParser);
      }
      
      public function getParser() : GuideOnDutyStatusMessageEventParser
      {
         return var_15 as GuideOnDutyStatusMessageEventParser;
      }
   }
}

