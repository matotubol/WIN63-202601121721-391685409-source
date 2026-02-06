package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2463
   {
      
      private var var_2953:int;
      
      private var var_4551:int;
      
      private var var_2134:int;
      
      public function class_2463(param1:IMessageDataWrapper)
      {
         super();
         var_2953 = param1.readInteger();
         var_4551 = param1.readInteger();
         var_2134 = param1.readInteger();
      }
      
      public function get partId() : int
      {
         return var_2953;
      }
      
      public function get colorId() : int
      {
         return var_4551;
      }
      
      public function get position() : int
      {
         return var_2134;
      }
   }
}

