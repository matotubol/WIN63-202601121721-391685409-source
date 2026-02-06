package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetRemovedFromInventoryEventParser implements IMessageParser
   {
      
      private var var_2751:int;
      
      public function PetRemovedFromInventoryEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2751 = param1.readInteger();
         return true;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
   }
}

