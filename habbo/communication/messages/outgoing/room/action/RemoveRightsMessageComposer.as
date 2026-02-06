package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class RemoveRightsMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function RemoveRightsMessageComposer(param1:Array)
      {
         super();
         this.var_120.push(param1.length);
         var _loc2_:int = 0;
         while(0 < param1.length)
         {
            this.var_120.push(param1[0]);
            _loc2_++;
         }
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

