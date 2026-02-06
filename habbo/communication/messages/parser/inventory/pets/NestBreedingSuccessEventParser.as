package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NestBreedingSuccessEventParser implements IMessageParser
   {
      
      private var var_2883:int;
      
      private var var_2751:int;
      
      public function NestBreedingSuccessEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2751 = -1;
         var_2883 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2751 = param1.readInteger();
         var_2883 = param1.readInteger();
         return true;
      }
      
      public function get rarityCategory() : int
      {
         return var_2883;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
   }
}

