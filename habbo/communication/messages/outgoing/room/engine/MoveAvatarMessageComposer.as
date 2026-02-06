package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MoveAvatarMessageComposer implements IMessageComposer
   {
      
      private var var_25:int;
      
      private var var_26:int;
      
      public function MoveAvatarMessageComposer(param1:int, param2:int)
      {
         super();
         var_25 = param1;
         var_26 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_25,var_26];
      }
   }
}

