package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2486;
   
   [SecureSWF(rename="true")]
   public class PetFigureUpdateEventParser implements IMessageParser
   {
      
      private var var_3915:int;
      
      private var var_2751:int;
      
      private var var_656:class_2486;
      
      private var var_4085:Boolean;
      
      private var var_4070:Boolean;
      
      public function PetFigureUpdateEventParser()
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
      
      public function get figureData() : class_2486
      {
         return var_656;
      }
      
      public function get hasSaddle() : Boolean
      {
         return var_4085;
      }
      
      public function get isRiding() : Boolean
      {
         return var_4070;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3915 = param1.readInteger();
         var_2751 = param1.readInteger();
         var_656 = new class_2486(param1);
         var_4085 = param1.readBoolean();
         var_4070 = param1.readBoolean();
         return true;
      }
   }
}

