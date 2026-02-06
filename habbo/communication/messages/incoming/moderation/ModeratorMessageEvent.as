package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorMessageEvent(param1:Function)
      {
         super(param1,ModeratorMessageEventParser);
      }
      
      public function getParser() : ModeratorMessageEventParser
      {
         return var_15 as ModeratorMessageEventParser;
      }
   }
}

