package com.sulake.habbo.communication.messages.outgoing.notifications
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ResetUnseenItemsComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function ResetUnseenItemsComposer(param1:int)
      {
         super();
         var_120.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

