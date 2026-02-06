package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.BanInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BanInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BanInfoMessageEvent(param1:Function)
      {
         super(param1,BanInfoMessageEventParser);
      }
      
      public function getParser() : BanInfoMessageEventParser
      {
         return var_15 as BanInfoMessageEventParser;
      }
   }
}

