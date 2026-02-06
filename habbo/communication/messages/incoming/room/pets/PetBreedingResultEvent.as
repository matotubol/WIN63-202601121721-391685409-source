package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetBreedingResultEventParser;
   
   [SecureSWF(rename="true")]
   public class PetBreedingResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetBreedingResultEvent(param1:Function)
      {
         super(param1,PetBreedingResultEventParser);
      }
      
      public function getParser() : PetBreedingResultEventParser
      {
         return var_15 as PetBreedingResultEventParser;
      }
   }
}

