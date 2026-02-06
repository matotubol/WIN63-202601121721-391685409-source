package com.sulake.habbo.communication.messages.parser.perk
{
   [SecureSWF(rename="true")]
   public class class_2995
   {
      
      private var var_3602:String;
      
      private var var_5147:Boolean = false;
      
      private var var_4951:String = "";
      
      public function class_2995()
      {
         super();
      }
      
      public function get code() : String
      {
         return var_3602;
      }
      
      public function set code(param1:String) : void
      {
         var_3602 = param1;
      }
      
      public function get isAllowed() : Boolean
      {
         return var_5147;
      }
      
      public function set isAllowed(param1:Boolean) : void
      {
         var_5147 = param1;
      }
      
      public function get errorMessage() : String
      {
         return var_4951;
      }
      
      public function set errorMessage(param1:String) : void
      {
         var_4951 = param1;
      }
   }
}

