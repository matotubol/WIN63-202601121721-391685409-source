package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2486;
   
   [SecureSWF(rename="true")]
   public class PetLevelNotificationEventParser implements IMessageParser
   {
      
      private var var_2751:int;
      
      private var var_4114:String;
      
      private var var_2493:int;
      
      private var var_656:class_2486;
      
      public function PetLevelNotificationEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2751 = param1.readInteger();
         var_4114 = param1.readString();
         var_2493 = param1.readInteger();
         var_656 = new class_2486(param1);
         return true;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get petName() : String
      {
         return var_4114;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get figureData() : class_2486
      {
         return var_656;
      }
   }
}

