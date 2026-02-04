package com.sulake.core.communication
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.class_1752;
   import com.sulake.core.communication.connection.class_58;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   
   [SecureSWF(rename="true")]
   public class class_44 extends class_17 implements class_43, class_31
   {
      
      private var var_1263:Array;
      
      public function class_44(param1:class_15, param2:uint = 0)
      {
         super(param1,param2);
         var_1263 = [];
         registerUpdateReceiver(this,0);
      }
      
      override public function dispose() : void
      {
         removeUpdateReceiver(this);
         for each(var _loc1_ in var_1263)
         {
            _loc1_.dispose();
         }
         var_1263 = null;
         super.dispose();
      }
      
      public function createConnection(param1:class_58 = null) : IConnection
      {
         var _loc2_:IConnection = new class_1752(this,param1);
         var_1263.push(_loc2_);
         return _loc2_;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IConnection = null;
         _loc2_ = 0;
         while(_loc2_ < var_1263.length)
         {
            _loc3_ = var_1263[_loc2_];
            _loc3_.processReceivedData();
            if(disposed)
            {
               return;
            }
            if(_loc3_.disposed)
            {
               var_1263.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
   }
}

