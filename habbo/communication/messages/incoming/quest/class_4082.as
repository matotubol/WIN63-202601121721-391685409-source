package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_4082 implements class_13
   {
      
      private var var_897:String;
      
      private var var_1836:Array = [];
      
      public function class_4082(param1:IMessageDataWrapper)
      {
         super();
         var_897 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1836.push(new class_4117(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var_1836 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1836 == null;
      }
      
      public function get hof() : Array
      {
         return var_1836;
      }
      
      public function get goalCode() : String
      {
         return var_897;
      }
   }
}

