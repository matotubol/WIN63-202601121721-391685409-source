package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2104;
   
   public class class_3934 implements IMessageParser
   {
      
      private var var_2912:int;
      
      private var var_375:Array = [];
      
      private var var_3255:int;
      
      private var var_2962:Boolean;
      
      public function class_3934()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return var_2912;
      }
      
      public function get products() : Array
      {
         return var_375;
      }
      
      public function get minutesUntilNextWeek() : int
      {
         return var_3255;
      }
      
      public function get rewardingOn() : Boolean
      {
         return var_2962;
      }
      
      public function flush() : Boolean
      {
         var_2912 = -1;
         var_375 = [];
         var_3255 = 0;
         var_2962 = true;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2912 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_375.push(new class_2104(param1));
            _loc2_++;
         }
         var_3255 = param1.readInteger();
         var_2962 = param1.readBoolean();
         return true;
      }
   }
}

