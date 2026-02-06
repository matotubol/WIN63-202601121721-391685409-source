package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2398
   {
      
      private var var_4750:String;
      
      private var var_2711:String;
      
      private var var_2783:String;
      
      public function class_2398(param1:IMessageDataWrapper)
      {
         super();
         var_4750 = param1.readString();
         var_2711 = param1.readString();
         var_2783 = param1.readString();
      }
      
      public function get recipeCode() : String
      {
         return var_4750;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get furnitureClassName() : String
      {
         return var_2783;
      }
   }
}

