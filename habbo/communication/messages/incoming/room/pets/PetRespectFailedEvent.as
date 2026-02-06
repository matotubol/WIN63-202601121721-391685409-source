package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedEventParser;
   
   [SecureSWF(rename="true")]
   public class PetRespectFailedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetRespectFailedEvent(param1:Function)
      {
         super(param1,PetRespectFailedEventParser);
      }
      
      public function getParser() : PetRespectFailedEventParser
      {
         return var_15 as PetRespectFailedEventParser;
      }
   }
}

