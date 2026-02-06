package com.sulake.habbo.communication.messages.incoming.error
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.error.ErrorReportEventParser;
   
   [SecureSWF(rename="true")]
   public class ErrorReportEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ErrorReportEvent(param1:Function)
      {
         super(param1,ErrorReportEventParser);
      }
      
      public function getParser() : ErrorReportEventParser
      {
         return this.var_15 as ErrorReportEventParser;
      }
   }
}

