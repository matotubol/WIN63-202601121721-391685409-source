package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BreedPetsMessageComposer implements IMessageComposer
   {
      
      public static const const_577:int = 0;
      
      public static const const_117:int = 1;
      
      public static const const_111:int = 2;
      
      private var var_24:Array = [];
      
      public function BreedPetsMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
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

