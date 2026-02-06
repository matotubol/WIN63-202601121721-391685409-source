package com.sulake.habbo.communication.messages.outgoing.notifications
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ResetUnseenItemIdsComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function ResetUnseenItemIdsComposer(param1:int, param2:Array)
      {
         super();
         var_120.push(param1);
         var_120.push(param2.length);
         var_120 = var_120.concat(param2);
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

