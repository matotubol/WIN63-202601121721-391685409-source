package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2638 implements class_13, class_2637
   {
      
      private var var_80:Array = [];
      
      private var _disposed:Boolean;
      
      public function class_2638(param1:IMessageDataWrapper)
      {
         super();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_80.push(new class_2460(param1));
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
         if(var_80 != null)
         {
            for each(var _loc1_ in var_80)
            {
               _loc1_.dispose();
            }
         }
         var_80 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get entries() : Array
      {
         return var_80;
      }
   }
}

