package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_3323 implements class_13, class_2637
   {
      
      private var var_553:Array = [];
      
      private var _disposed:Boolean;
      
      public function class_3323(param1:IMessageDataWrapper)
      {
         super();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_553.push(new class_3737(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_553 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get tags() : Array
      {
         return var_553;
      }
   }
}

