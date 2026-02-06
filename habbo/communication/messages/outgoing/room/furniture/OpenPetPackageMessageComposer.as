package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_4114:String;
      
      public function OpenPetPackageMessageComposer(param1:int, param2:String)
      {
         super();
         var_315 = param1;
         var_4114 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_4114];
      }
      
      public function dispose() : void
      {
      }
   }
}

