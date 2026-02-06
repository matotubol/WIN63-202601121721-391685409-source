package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferEventParser;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGiftOfferEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NewUserExperienceGiftOfferEvent(param1:Function)
      {
         super(param1,NewUserExperienceGiftOfferEventParser);
      }
      
      public function getParser() : NewUserExperienceGiftOfferEventParser
      {
         return var_15 as NewUserExperienceGiftOfferEventParser;
      }
   }
}

