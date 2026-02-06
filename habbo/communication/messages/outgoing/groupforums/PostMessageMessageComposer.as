package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class PostMessageMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array;
      
      public function PostMessageMessageComposer(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         this.var_120 = [param1,param2,param3,param4];
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

