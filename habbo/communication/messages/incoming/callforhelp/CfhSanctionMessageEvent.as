package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.callforhelp.CfhSanctionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CfhSanctionMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CfhSanctionMessageEvent(param1:Function)
      {
         super(param1,CfhSanctionMessageEventParser);
      }
      
      public function getParser() : CfhSanctionMessageEventParser
      {
         return var_15 as CfhSanctionMessageEventParser;
      }
   }
}

