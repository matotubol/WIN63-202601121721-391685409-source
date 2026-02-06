package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingResultMessageEventParser implements IMessageParser
   {
      
      private var var_2614:Boolean;
      
      private var var_1500:class_2398;
      
      public function CraftingResultMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2614 = param1.readBoolean();
         if(var_2614)
         {
            var_1500 = new class_2398(param1);
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2614 = false;
         return true;
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
      
      public function get productData() : class_2398
      {
         return var_1500;
      }
   }
}

