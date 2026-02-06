package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectActivatedMessageEvent extends MessageEvent
   {
      
      public function AvatarEffectActivatedMessageEvent(param1:Function)
      {
         super(param1,AvatarEffectActivatedMessageEventParser);
      }
      
      public function getParser() : AvatarEffectActivatedMessageEventParser
      {
         return var_15 as AvatarEffectActivatedMessageEventParser;
      }
   }
}

