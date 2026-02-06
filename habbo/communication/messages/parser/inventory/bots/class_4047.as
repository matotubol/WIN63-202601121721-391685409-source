package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_4047 implements IMessageParser
   {
      
      private var var_4838:Boolean;
      
      private var var_452:class_3317;
      
      public function class_4047()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4838 = param1.readBoolean();
         var_452 = new class_3317(param1);
         return true;
      }
      
      public function get boughtAsGift() : Boolean
      {
         return var_4838;
      }
      
      public function get item() : class_3317
      {
         return var_452;
      }
   }
}

