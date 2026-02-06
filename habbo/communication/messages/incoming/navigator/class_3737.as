package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3737
   {
      
      private var var_3857:String;
      
      private var var_3244:int;
      
      public function class_3737(param1:IMessageDataWrapper)
      {
         super();
         var_3857 = param1.readString();
         var_3244 = param1.readInteger();
      }
      
      public function get tagName() : String
      {
         return var_3857;
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
   }
}

