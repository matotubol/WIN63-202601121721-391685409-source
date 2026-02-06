package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectExpiredMessageEvent extends MessageEvent
   {
      
      public function AvatarEffectExpiredMessageEvent(param1:Function)
      {
         super(param1,AvatarEffectExpiredMessageEventParser);
      }
      
      public function getParser() : AvatarEffectExpiredMessageEventParser
      {
         return var_15 as AvatarEffectExpiredMessageEventParser;
      }
   }
}

