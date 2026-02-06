package com.sulake.habbo.communication.messages.parser.poll
{
   [SecureSWF(rename="true")]
   public class class_3851
   {
      
      private var _value:String;
      
      private var var_3329:String;
      
      private var var_2744:int;
      
      public function class_3851(param1:String, param2:String, param3:int)
      {
         super();
         _value = param1;
         var_3329 = param2;
         var_2744 = param3;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         _value = param1;
      }
      
      public function get choiceText() : String
      {
         return var_3329;
      }
      
      public function set choiceText(param1:String) : void
      {
         var_3329 = param1;
      }
      
      public function get choiceType() : int
      {
         return var_2744;
      }
      
      public function set choiceType(param1:int) : void
      {
         var_2744 = param1;
      }
   }
}

