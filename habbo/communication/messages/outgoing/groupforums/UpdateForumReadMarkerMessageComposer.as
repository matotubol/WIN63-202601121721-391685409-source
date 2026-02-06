package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class UpdateForumReadMarkerMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [0];
      
      public function UpdateForumReadMarkerMessageComposer()
      {
         super();
      }
      
      public function add(param1:int, param2:int, param3:Boolean) : void
      {
         var_120.push(param1,param2,param3);
         var _loc4_:Array = var_120;
         var _loc6_:* = Number(_loc4_[0]) + 1;
         _loc4_[0] = _loc6_;
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function get size() : int
      {
         return var_120[0];
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

