package com.sulake.habbo.communication.messages.incoming.sound
{
   [SecureSWF(rename="true")]
   public class class_3637 extends class_3136
   {
      
      private var var_3173:String = "";
      
      public function class_3637(param1:int, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3,param4);
         var_3173 = param5;
      }
      
      public function get data() : String
      {
         return var_3173;
      }
   }
}

