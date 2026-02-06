package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetStatusUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class PetStatusUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetStatusUpdateEvent(param1:Function)
      {
         super(param1,PetStatusUpdateEventParser);
      }
      
      public function getParser() : PetStatusUpdateEventParser
      {
         return var_15 as PetStatusUpdateEventParser;
      }
   }
}

