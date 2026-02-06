package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetStatusUpdateEventParser implements IMessageParser
   {
      
      private var var_3915:int;
      
      private var var_2751:int;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4233:Boolean;
      
      public function PetStatusUpdateEventParser()
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
      
      public function get canBreed() : Boolean
      {
         return var_3982;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_4043;
      }
      
      public function get canRevive() : Boolean
      {
         return var_3818;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3915 = param1.readInteger();
         var_2751 = param1.readInteger();
         var_3982 = param1.readBoolean();
         var_4043 = param1.readBoolean();
         var_3818 = param1.readBoolean();
         var_4233 = param1.readBoolean();
         return true;
      }
   }
}

