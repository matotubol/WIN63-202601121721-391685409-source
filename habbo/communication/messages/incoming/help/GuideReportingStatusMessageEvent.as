package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideReportingStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideReportingStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideReportingStatusMessageEvent(param1:Function)
      {
         super(param1,GuideReportingStatusMessageEventParser);
      }
      
      public function getParser() : GuideReportingStatusMessageEventParser
      {
         return var_15 as GuideReportingStatusMessageEventParser;
      }
   }
}

