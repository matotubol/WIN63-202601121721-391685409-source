package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class class_3568 implements class_13, class_2637
   {
      
      private var var_3085:class_55 = new class_55();
      
      private var var_3196:class_55 = new class_55();
      
      private var _disposed:Boolean;
      
      public function class_3568(param1:IMessageDataWrapper)
      {
         super();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var _loc6_:int = param1.readInteger();
            var _loc3_:int = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var_3085.add(0,0);
            var_3196.add(0,0);
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_3085 = null;
         this.var_3196 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get categoryToCurrentUserCountMap() : class_55
      {
         return var_3085;
      }
      
      public function get categoryToMaxUserCountMap() : class_55
      {
         return var_3196;
      }
   }
}

