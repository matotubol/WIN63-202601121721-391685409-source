package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   internal class class_543 implements class_13
   {
      
      private var var_3099:IID;
      
      private var var_1134:Boolean;
      
      private var _receivers:Vector.<Function>;
      
      public function class_543(param1:IID)
      {
         super();
         var_3099 = param1;
         _receivers = new Vector.<Function>();
         var_1134 = false;
      }
      
      public function get identifier() : IID
      {
         return var_3099;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get receivers() : Vector.<Function>
      {
         return _receivers;
      }
      
      public function dispose() : void
      {
         if(!var_1134)
         {
            var_1134 = true;
            var_3099 = null;
            while(_receivers.length > 0)
            {
               _receivers.pop();
            }
            _receivers = null;
         }
      }
   }
}

