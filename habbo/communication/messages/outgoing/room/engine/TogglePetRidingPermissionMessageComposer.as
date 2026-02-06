package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class TogglePetRidingPermissionMessageComposer implements IMessageComposer
   {
      
      private var var_2751:int;
      
      public function TogglePetRidingPermissionMessageComposer(param1:int)
      {
         super();
         var_2751 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2751];
      }
   }
}

