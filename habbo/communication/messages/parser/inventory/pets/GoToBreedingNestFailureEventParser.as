package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GoToBreedingNestFailureEventParser implements IMessageParser
   {
      
      public static const const_976:int = 6;
      
      private var var_2352:int;
      
      public function GoToBreedingNestFailureEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         return true;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
   }
}

