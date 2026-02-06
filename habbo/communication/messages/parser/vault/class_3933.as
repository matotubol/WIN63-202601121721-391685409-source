package com.sulake.habbo.communication.messages.parser.vault
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3933 implements IMessageParser
   {
      
      private var var_3161:Boolean;
      
      private var var_3137:int;
      
      private var var_2686:int;
      
      public function class_3933()
      {
         super();
      }
      
      public function get isUnlocked() : Boolean
      {
         return var_3161;
      }
      
      public function get totalBalance() : int
      {
         return var_3137;
      }
      
      public function get withdrawBalance() : int
      {
         return var_2686;
      }
      
      public function flush() : Boolean
      {
         var_3161 = false;
         var_3137 = 0;
         var_2686 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3161 = param1.readBoolean();
         var_3137 = param1.readInteger();
         var_2686 = param1.readInteger();
         return true;
      }
   }
}

