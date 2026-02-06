package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionErrorMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionErrorMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionErrorMessageEvent(param1:Function)
      {
         super(param1,GuideSessionErrorMessageEventParser);
      }
      
      public function getParser() : GuideSessionErrorMessageEventParser
      {
         return var_15 as GuideSessionErrorMessageEventParser;
      }
   }
}

