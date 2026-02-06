package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MoveObjectMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var var_81:int;
      
      public function MoveObjectMessageComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         var_315 = param1;
         var_25 = param2;
         var_26 = param3;
         var_81 = param4;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_25,var_26,var_81];
      }
   }
}

