package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionMessageMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionMessageMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionMessageMessageEvent(param1:Function)
      {
         super(param1,GuideSessionMessageMessageEventParser);
      }
      
      public function getParser() : GuideSessionMessageMessageEventParser
      {
         return var_15 as GuideSessionMessageMessageEventParser;
      }
   }
}

