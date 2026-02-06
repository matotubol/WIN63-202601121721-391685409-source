package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetBreedingEventParser implements IMessageParser
   {
      
      public static const const_117:int = 1;
      
      public static const const_111:int = 2;
      
      public static const const_1099:int = 3;
      
      private var var_61:int;
      
      private var var_4218:int;
      
      private var var_3827:int;
      
      public function PetBreedingEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_61 = param1.readInteger();
         var_4218 = param1.readInteger();
         var_3827 = param1.readInteger();
         return true;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get ownPetId() : int
      {
         return var_4218;
      }
      
      public function get otherPetId() : int
      {
         return var_3827;
      }
   }
}

