package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetCommandsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PetCommandsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetCommandsMessageEvent(param1:Function)
      {
         super(param1,PetCommandsMessageEventParser);
      }
      
      public function getParser() : PetCommandsMessageEventParser
      {
         return var_15 as PetCommandsMessageEventParser;
      }
   }
}

