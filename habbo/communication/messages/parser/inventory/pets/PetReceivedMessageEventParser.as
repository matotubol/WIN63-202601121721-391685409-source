package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetReceivedMessageEventParser implements IMessageParser
   {
      
      private var var_4838:Boolean;
      
      private var var_2914:class_2838;
      
      public function PetReceivedMessageEventParser()
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
         var_2914 = new class_2838(param1);
         return true;
      }
      
      public function get boughtAsGift() : Boolean
      {
         return var_4838;
      }
      
      public function get pet() : class_2838
      {
         return var_2914;
      }
   }
}

