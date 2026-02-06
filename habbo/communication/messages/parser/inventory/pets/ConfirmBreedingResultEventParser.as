package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingResultEventParser implements IMessageParser
   {
      
      private var var_2712:int;
      
      private var var_1122:int;
      
      public function ConfirmBreedingResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2712 = 0;
         var_1122 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2712 = param1.readInteger();
         var_1122 = param1.readInteger();
         return true;
      }
      
      public function get breedingNestStuffId() : int
      {
         return var_2712;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
   }
}

