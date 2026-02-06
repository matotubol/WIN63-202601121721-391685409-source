package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BadgePointLimitsEventParser implements IMessageParser
   {
      
      private var var_24:Array;
      
      public function BadgePointLimitsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.readString();
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               var_24.push(new class_2384(_loc6_,param1));
               _loc3_++;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function get data() : Array
      {
         return var_24;
      }
   }
}

