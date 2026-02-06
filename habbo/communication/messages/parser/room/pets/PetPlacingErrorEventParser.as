package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetPlacingErrorEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      public function PetPlacingErrorEventParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function flush() : Boolean
      {
         var_2759 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2759 = param1.readInteger();
         return true;
      }
   }
}

