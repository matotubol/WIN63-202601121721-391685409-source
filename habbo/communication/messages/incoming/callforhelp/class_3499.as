package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_2217;
   
   [SecureSWF(rename="true")]
   public class class_3499 implements class_2217
   {
      
      private var var_4502:String;
      
      private var var_4148:int;
      
      private var var_4123:String;
      
      public function class_3499(param1:IMessageDataWrapper)
      {
         super();
         var_4502 = param1.readString();
         var_4148 = param1.readInteger();
         var_4123 = param1.readString();
      }
      
      public function get name() : String
      {
         return var_4502;
      }
      
      public function get id() : int
      {
         return var_4148;
      }
      
      public function get consequence() : String
      {
         return var_4123;
      }
   }
}

