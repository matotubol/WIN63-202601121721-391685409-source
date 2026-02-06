package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_3292;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionsMessageEventParser implements IMessageParser
   {
      
      private var _stuffId:int;
      
      private var var_1423:Vector.<class_3292>;
      
      private var _endTime:int;
      
      public function AchievementResolutionsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         for each(var _loc1_ in var_1423)
         {
            _loc1_.dispose();
         }
         var_1423 = new Vector.<class_3292>(0);
         _endTime = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_1423.push(new class_3292(param1));
            _loc2_++;
         }
         _endTime = param1.readInteger();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get achievements() : Vector.<class_3292>
      {
         return var_1423;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
   }
}

