package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LookToMessageComposer implements IMessageComposer
   {
      
      private var var_3909:int;
      
      private var var_3957:int;
      
      public function LookToMessageComposer(param1:int, param2:int)
      {
         super();
         var_3909 = param1;
         var_3957 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [var_3909,var_3957];
      }
      
      public function dispose() : void
      {
      }
   }
}

