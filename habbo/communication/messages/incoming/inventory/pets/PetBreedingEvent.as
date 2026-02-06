package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetBreedingEventParser;
   
   [SecureSWF(rename="true")]
   public class PetBreedingEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetBreedingEvent(param1:Function)
      {
         super(param1,PetBreedingEventParser);
      }
      
      public function getParser() : PetBreedingEventParser
      {
         return var_15 as PetBreedingEventParser;
      }
   }
}

