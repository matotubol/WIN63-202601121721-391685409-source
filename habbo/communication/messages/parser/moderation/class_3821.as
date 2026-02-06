package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_3821 implements class_13
   {
      
      private var var_2977:String;
      
      private var var_369:int;
      
      private var var_2901:int;
      
      private var var_1134:Boolean = false;
      
      public function class_3821(param1:IMessageDataWrapper)
      {
         super();
         var_2977 = param1.readString();
         var_369 = param1.readInteger();
         var_2901 = param1.readInteger();
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         var_2977 = "";
         var_369 = -1;
         var_2901 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get pattern() : String
      {
         return var_2977;
      }
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get endIndex() : int
      {
         return var_2901;
      }
   }
}

