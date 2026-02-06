package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRandomStateMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_44:int = 0;
      
      public function SetRandomStateMessageComposer(param1:int, param2:int = 0)
      {
         super();
         var_315 = param1;
         var_44 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_44];
      }
   }
}

