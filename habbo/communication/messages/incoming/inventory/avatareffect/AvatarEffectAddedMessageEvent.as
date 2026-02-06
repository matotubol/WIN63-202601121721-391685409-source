package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectAddedMessageEvent extends MessageEvent
   {
      
      public function AvatarEffectAddedMessageEvent(param1:Function)
      {
         super(param1,AvatarEffectAddedMessageEventParser);
      }
      
      public function getParser() : AvatarEffectAddedMessageEventParser
      {
         return var_15 as AvatarEffectAddedMessageEventParser;
      }
   }
}

