package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetAddedToInventoryEventParser implements IMessageParser
   {
      
      private var var_2914:class_2838;
      
      private var var_4267:Boolean;
      
      public function PetAddedToInventoryEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2914 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2914 = new class_2838(param1);
         var_4267 = param1.readBoolean();
         return true;
      }
      
      public function get pet() : class_2838
      {
         return var_2914;
      }
      
      public function openInventory() : Boolean
      {
         return var_4267;
      }
   }
}

