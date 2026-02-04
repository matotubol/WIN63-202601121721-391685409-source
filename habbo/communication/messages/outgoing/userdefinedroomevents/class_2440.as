package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2440 implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function class_2440(param1:int, param2:Array, param3:Array, param4:String, param5:Array, param6:Array, param7:Array, param8:Array)
      {
         super();
         var_120.push(param1);
         var_120.push(param2.length);
         for each(var _loc11_ in param2)
         {
            var_120.push(_loc11_);
         }
         var_120.push(param4);
         var_120.push(param5.length);
         for each(var _loc13_ in param5)
         {
            var_120.push(_loc13_);
         }
         var_120.push(param7.length);
         for each(var _loc9_ in param7)
         {
            var_120.push(_loc9_);
         }
         var_120.push(param8.length);
         for each(var _loc14_ in param8)
         {
            var_120.push(_loc14_);
         }
         var_120.push(param3.length);
         for each(var _loc10_ in param3)
         {
            var_120.push(_loc10_);
         }
         var_120.push(param6.length);
         for each(var _loc12_ in param6)
         {
            var_120.push(_loc12_);
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

