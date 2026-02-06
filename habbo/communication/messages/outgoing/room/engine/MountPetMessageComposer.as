package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MountPetMessageComposer implements IMessageComposer
   {
      
      private var var_2751:int;
      
      private var var_4782:Boolean;
      
      public function MountPetMessageComposer(param1:int, param2:Boolean)
      {
         super();
         var_2751 = param1;
         var_4782 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2751,var_4782];
      }
   }
}

