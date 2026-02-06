package com.sulake.habbo.communication.messages.outgoing.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CancelPetBreedingComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function CancelPetBreedingComposer(param1:int)
      {
         super();
         var_24.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

