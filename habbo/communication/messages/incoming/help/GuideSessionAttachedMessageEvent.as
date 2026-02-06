package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionAttachedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionAttachedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionAttachedMessageEvent(param1:Function)
      {
         super(param1,GuideSessionAttachedMessageEventParser);
      }
      
      public function getParser() : GuideSessionAttachedMessageEventParser
      {
         return var_15 as GuideSessionAttachedMessageEventParser;
      }
   }
}

