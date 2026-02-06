package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceEventParser;
   
   [SecureSWF(rename="true")]
   public class PetExperienceEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetExperienceEvent(param1:Function)
      {
         super(param1,PetExperienceEventParser);
      }
      
      public function getParser() : PetExperienceEventParser
      {
         return var_15 as PetExperienceEventParser;
      }
   }
}

