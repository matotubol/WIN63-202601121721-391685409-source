package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorUserInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorUserInfoEvent(param1:Function)
      {
         super(param1,ModeratorUserInfoEventParser);
      }
      
      public function getParser() : ModeratorUserInfoEventParser
      {
         return var_15 as ModeratorUserInfoEventParser;
      }
   }
}

