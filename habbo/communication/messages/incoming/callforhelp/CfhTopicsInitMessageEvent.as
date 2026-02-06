package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.callforhelp.CfhTopicsInitMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CfhTopicsInitMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CfhTopicsInitMessageEvent(param1:Function)
      {
         super(param1,CfhTopicsInitMessageEventParser);
      }
      
      public function getParser() : CfhTopicsInitMessageEventParser
      {
         return var_15 as CfhTopicsInitMessageEventParser;
      }
   }
}

