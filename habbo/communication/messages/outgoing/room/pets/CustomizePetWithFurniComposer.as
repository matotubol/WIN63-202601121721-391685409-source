package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CustomizePetWithFurniComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function CustomizePetWithFurniComposer(param1:int, param2:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
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

