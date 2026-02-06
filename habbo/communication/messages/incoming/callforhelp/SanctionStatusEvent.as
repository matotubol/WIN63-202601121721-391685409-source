package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.callforhelp.SanctionStatusEventParser;
   
   [SecureSWF(rename="true")]
   public class SanctionStatusEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SanctionStatusEvent(param1:Function)
      {
         super(param1,SanctionStatusEventParser);
      }
      
      public function getParser() : SanctionStatusEventParser
      {
         return var_15 as SanctionStatusEventParser;
      }
   }
}

