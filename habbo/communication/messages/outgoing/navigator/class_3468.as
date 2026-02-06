package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_3468 implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function class_3468(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
         this.var_120.push(param3);
         this.var_120.push(param4);
      }
      
      public function addObj(param1:int, param2:int) : void
      {
         this.var_120.push(param1);
         this.var_120.push(param2);
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

