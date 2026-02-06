package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectMessageEvent extends MessageEvent
   {
      
      public function AvatarEffectMessageEvent(param1:Function)
      {
         super(param1,AvatarEffectMessageEventParser);
      }
      
      public function getParser() : AvatarEffectMessageEventParser
      {
         return var_15 as AvatarEffectMessageEventParser;
      }
   }
}

