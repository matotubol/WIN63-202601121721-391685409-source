package com.sulake.habbo.communication.messages.outgoing.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ConfirmPetBreedingComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function ConfirmPetBreedingComposer(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
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

