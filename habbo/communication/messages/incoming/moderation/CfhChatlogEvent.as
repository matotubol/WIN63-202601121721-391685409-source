package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogEventParser;
   
   [SecureSWF(rename="true")]
   public class CfhChatlogEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CfhChatlogEvent(param1:Function)
      {
         super(param1,CfhChatlogEventParser);
      }
      
      public function getParser() : CfhChatlogEventParser
      {
         return var_15 as CfhChatlogEventParser;
      }
   }
}

