package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectSelectedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectSelectedMessageEvent extends MessageEvent
   {
      
      public function AvatarEffectSelectedMessageEvent(param1:Function)
      {
         super(param1,AvatarEffectSelectedMessageEventParser);
      }
      
      public function getParser() : AvatarEffectSelectedMessageEventParser
      {
         return var_15 as AvatarEffectSelectedMessageEventParser;
      }
   }
}

