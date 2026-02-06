package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.callforhelp.MyCfhReportStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class MyCfhReportStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MyCfhReportStatusMessageEvent(param1:Function)
      {
         super(param1,MyCfhReportStatusMessageEventParser);
      }
      
      public function getParser() : MyCfhReportStatusMessageEventParser
      {
         return var_15 as MyCfhReportStatusMessageEventParser;
      }
   }
}

