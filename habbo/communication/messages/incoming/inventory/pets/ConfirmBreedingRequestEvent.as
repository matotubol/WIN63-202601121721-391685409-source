package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingRequestEventParser;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingRequestEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ConfirmBreedingRequestEvent(param1:Function)
      {
         super(param1,ConfirmBreedingRequestEventParser);
      }
      
      public function getParser() : ConfirmBreedingRequestEventParser
      {
         return var_15 as ConfirmBreedingRequestEventParser;
      }
   }
}

