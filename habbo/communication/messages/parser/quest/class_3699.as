package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3699 implements IMessageParser
   {
      
      private var var_61:int;
      
      private var var_3244:int;
      
      private var var_2717:int;
      
      public function class_3699()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_61 = -1;
         var_3244 = -1;
         var_2717 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_61 = param1.readInteger();
         var_3244 = param1.readInteger();
         var_2717 = param1.readInteger();
         return true;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
      
      public function get userCountGoal() : int
      {
         return var_2717;
      }
   }
}

