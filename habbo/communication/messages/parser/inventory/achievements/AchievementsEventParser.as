package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_3303;
   
   [SecureSWF(rename="true")]
   public class AchievementsEventParser implements IMessageParser
   {
      
      private var var_1423:Array;
      
      private var var_4003:String;
      
      public function AchievementsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1423 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1423 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1423.push(new class_3303(param1));
            _loc3_++;
         }
         var_4003 = param1.readString();
         return true;
      }
      
      public function get achievements() : Array
      {
         return var_1423;
      }
      
      public function get defaultCategory() : String
      {
         return var_4003;
      }
   }
}

