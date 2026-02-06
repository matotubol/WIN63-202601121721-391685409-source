package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryEventParser;
   
   [SecureSWF(rename="true")]
   public class PetAddedToInventoryEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetAddedToInventoryEvent(param1:Function)
      {
         super(param1,PetAddedToInventoryEventParser);
      }
      
      public function getParser() : PetAddedToInventoryEventParser
      {
         return var_15 as PetAddedToInventoryEventParser;
      }
   }
}

