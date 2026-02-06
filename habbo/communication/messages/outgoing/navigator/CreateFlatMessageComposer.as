package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class CreateFlatMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function CreateFlatMessageComposer(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
         this.var_120.push(param3);
         this.var_120.push(param4);
         this.var_120.push(param5);
         this.var_120.push(param6);
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

