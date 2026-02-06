package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorCautionEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorCautionEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorCautionEvent(param1:Function)
      {
         super(param1,ModeratorCautionEventParser);
      }
      
      public function getParser() : ModeratorCautionEventParser
      {
         return var_15 as ModeratorCautionEventParser;
      }
   }
}

