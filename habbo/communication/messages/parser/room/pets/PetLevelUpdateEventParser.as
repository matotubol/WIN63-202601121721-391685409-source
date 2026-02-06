package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetLevelUpdateEventParser implements IMessageParser
   {
      
      private var var_3915:int;
      
      private var var_2751:int;
      
      private var var_2493:int;
      
      public function PetLevelUpdateEventParser()
      {
         super();
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3915 = param1.readInteger();
         var_2751 = param1.readInteger();
         var_2493 = param1.readInteger();
         return true;
      }
   }
}

