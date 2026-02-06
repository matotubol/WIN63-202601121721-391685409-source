package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryEventParser;
   
   [SecureSWF(rename="true")]
   public class PetRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetRemovedFromInventoryEvent(param1:Function)
      {
         super(param1,PetRemovedFromInventoryEventParser);
      }
      
      public function getParser() : PetRemovedFromInventoryEventParser
      {
         return var_15 as PetRemovedFromInventoryEventParser;
      }
   }
}

