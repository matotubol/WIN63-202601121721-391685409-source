package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetPetInfoMessageComposer implements IMessageComposer
   {
      
      private var var_2751:int;
      
      public function GetPetInfoMessageComposer(param1:int)
      {
         super();
         var_2751 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2751];
      }
      
      public function dispose() : void
      {
      }
   }
}

