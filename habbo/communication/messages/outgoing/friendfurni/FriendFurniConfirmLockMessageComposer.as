package com.sulake.habbo.communication.messages.outgoing.friendfurni
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class FriendFurniConfirmLockMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function FriendFurniConfirmLockMessageComposer(param1:int, param2:Boolean)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

