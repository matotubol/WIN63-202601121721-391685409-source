package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_3688;
   
   [SecureSWF(rename="true")]
   public class PetBreedingResultEventParser implements IMessageParser
   {
      
      private var var_357:class_3688;
      
      private var var_3914:class_3688;
      
      public function PetBreedingResultEventParser()
      {
         super();
      }
      
      public function get resultData() : class_3688
      {
         return var_357;
      }
      
      public function get otherResultData() : class_3688
      {
         return var_3914;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      private function parseResultData(param1:IMessageDataWrapper) : class_3688
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:String = param1.readString();
         var _loc7_:int = param1.readInteger();
         var _loc6_:String = param1.readString();
         var _loc5_:int = param1.readInteger();
         var _loc8_:Boolean = param1.readBoolean();
         return new class_3688(_loc2_,_loc3_,_loc4_,_loc7_,_loc6_,_loc5_,_loc8_);
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_357 = parseResultData(param1);
         var_3914 = parseResultData(param1);
         return true;
      }
   }
}

