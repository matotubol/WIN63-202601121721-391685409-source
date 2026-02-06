package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetRespectFailedEventParser implements IMessageParser
   {
      
      private var var_4283:int;
      
      private var var_4989:int;
      
      public function PetRespectFailedEventParser()
      {
         super();
      }
      
      public function get requiredDays() : int
      {
         return var_4283;
      }
      
      public function get avatarAgeInDays() : int
      {
         return var_4989;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4283 = param1.readInteger();
         var_4989 = param1.readInteger();
         return true;
      }
   }
}

