package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotAddedToInventoryEventParser implements IMessageParser
   {
      
      private var var_452:class_3317;
      
      private var var_4267:Boolean;
      
      public function BotAddedToInventoryEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_452 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_452 = new class_3317(param1);
         var_4267 = param1.readBoolean();
         return true;
      }
      
      public function get item() : class_3317
      {
         return var_452;
      }
      
      public function openInventory() : Boolean
      {
         return var_4267;
      }
   }
}

