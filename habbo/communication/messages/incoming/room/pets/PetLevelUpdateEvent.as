package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetLevelUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class PetLevelUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetLevelUpdateEvent(param1:Function)
      {
         super(param1,PetLevelUpdateEventParser);
      }
      
      public function getParser() : PetLevelUpdateEventParser
      {
         return var_15 as PetLevelUpdateEventParser;
      }
   }
}

