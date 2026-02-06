package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1904
   {
      
      private var var_3122:int;
      
      private var var_2109:int;
      
      private var var_4941:int;
      
      public function class_1904(param1:IMessageDataWrapper, param2:int = 0, param3:int = 0)
      {
         super();
         var_3122 = param2;
         var_2109 = param3;
         if(param1 != null)
         {
            var_3122 = param1.readInteger();
            var_2109 = param1.readInteger();
            var_4941 = param1.readInteger();
         }
      }
      
      public function get goalId() : int
      {
         return var_3122;
      }
      
      public function get pageIndex() : int
      {
         return var_2109;
      }
      
      public function get pageCount() : int
      {
         return var_4941;
      }
   }
}

