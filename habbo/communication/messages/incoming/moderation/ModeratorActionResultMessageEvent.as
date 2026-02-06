package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorActionResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorActionResultMessageEvent(param1:Function)
      {
         super(param1,ModeratorActionResultMessageEventParser);
      }
      
      public function getParser() : ModeratorActionResultMessageEventParser
      {
         return var_15 as ModeratorActionResultMessageEventParser;
      }
   }
}

