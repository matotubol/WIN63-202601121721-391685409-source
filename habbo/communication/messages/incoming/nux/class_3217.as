package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3217
   {
      
      private var var_4289:int;
      
      private var var_4633:int;
      
      private var var_852:Vector.<class_3916>;
      
      public function class_3217(param1:IMessageDataWrapper)
      {
         super();
         var_4289 = param1.readInteger();
         var_4633 = param1.readInteger();
         var_852 = new Vector.<class_3916>(0);
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_852.push(new class_3916(param1));
            _loc2_++;
         }
      }
      
      public function get dayIndex() : int
      {
         return var_4289;
      }
      
      public function get stepIndex() : int
      {
         return var_4633;
      }
      
      public function get options() : Vector.<class_3916>
      {
         return var_852;
      }
   }
}

