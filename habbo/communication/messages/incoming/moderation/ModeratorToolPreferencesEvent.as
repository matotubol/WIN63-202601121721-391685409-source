package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorToolPreferencesEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorToolPreferencesEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorToolPreferencesEvent(param1:Function)
      {
         super(param1,ModeratorToolPreferencesEventParser);
      }
      
      public function getParser() : ModeratorToolPreferencesEventParser
      {
         return parser as ModeratorToolPreferencesEventParser;
      }
   }
}

