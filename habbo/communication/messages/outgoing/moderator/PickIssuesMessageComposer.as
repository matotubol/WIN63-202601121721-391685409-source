package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class PickIssuesMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function PickIssuesMessageComposer(param1:Array, param2:Boolean, param3:int, param4:String)
      {
         super();
         this.var_120.push(param1.length);
         var _loc5_:int = 0;
         while(0 < param1.length)
         {
            this.var_120.push(param1[0]);
            _loc5_++;
         }
         this.var_120.push(param2);
         this.var_120.push(param3);
         this.var_120.push(param4);
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

