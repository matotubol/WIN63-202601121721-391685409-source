package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PetInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetInfoMessageEvent(param1:Function)
      {
         super(param1,PetInfoMessageEventParser);
      }
      
      public function getParser() : PetInfoMessageEventParser
      {
         return var_15 as PetInfoMessageEventParser;
      }
   }
}

