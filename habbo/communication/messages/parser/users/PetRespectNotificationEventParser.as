package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2838;
   
   [SecureSWF(rename="true")]
   public class PetRespectNotificationEventParser implements IMessageParser
   {
      
      public static const const_675:int = 16;
      
      private var var_4078:int;
      
      private var var_4582:int;
      
      private var var_311:class_2838;
      
      public function PetRespectNotificationEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_311 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4078 = param1.readInteger();
         var_4582 = param1.readInteger();
         var_311 = new class_2838(param1);
         return true;
      }
      
      public function get petOwnerId() : int
      {
         return var_4582;
      }
      
      public function get respect() : int
      {
         return var_4078;
      }
      
      public function get petData() : class_2838
      {
         return var_311;
      }
      
      public function isTreat() : Boolean
      {
         return var_311.typeId == 16;
      }
   }
}

