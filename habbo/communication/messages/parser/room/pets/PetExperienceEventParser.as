package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetExperienceEventParser implements IMessageParser
   {
      
      private var var_2751:int = -1;
      
      private var var_4741:int = -1;
      
      private var var_4471:int = 0;
      
      public function PetExperienceEventParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get petRoomIndex() : int
      {
         return var_4741;
      }
      
      public function get gainedExperience() : int
      {
         return var_4471;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2751 = param1.readInteger();
         var_4741 = param1.readInteger();
         var_4471 = param1.readInteger();
         return true;
      }
   }
}

