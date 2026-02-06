package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetPlacingErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class PetPlacingErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetPlacingErrorEvent(param1:Function)
      {
         super(param1,PetPlacingErrorEventParser);
      }
      
      public function getParser() : PetPlacingErrorEventParser
      {
         return var_15 as PetPlacingErrorEventParser;
      }
   }
}

