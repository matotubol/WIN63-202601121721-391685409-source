package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.utils.class_2724;
   
   [SecureSWF(rename="true")]
   public class class_3929
   {
      
      public static const STATE_LOCKED:int = 0;
      
      public static const const_149:int = 1;
      
      public static const const_153:int = 2;
      
      private var _name:String;
      
      private var var_1616:int;
      
      private var var_1001:Vector.<class_3355>;
      
      public function class_3929()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _name = param1.readString();
         var_1001 = new Vector.<class_3355>();
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:class_3355 = new class_3355();
            null.parse(param1);
            if(null.state == 1)
            {
               var_1616 = 0;
            }
            var_1001.push(null);
            _loc4_++;
         }
      }
      
      public function findTaskByAchievementId(param1:int) : class_3765
      {
         for each(var _loc2_ in var_1001)
         {
            if(_loc2_.state != 0)
            {
               var _loc3_:class_3765 = _loc2_.findTaskByAchievementId(param1);
            }
         }
         return null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get levels() : Vector.<class_3355>
      {
         return var_1001;
      }
      
      public function get progressPerLevel() : Number
      {
         if(var_1001.length > 0)
         {
            return 1 / var_1001.length;
         }
         return 0;
      }
      
      public function get totalProgress() : Number
      {
         var _loc1_:Number = NaN;
         if(var_1001.length > 0)
         {
            _loc1_ = var_1001[var_1616].levelProgress;
            return class_2724.clamp(var_1616 * progressPerLevel + _loc1_ * progressPerLevel);
         }
         return 0;
      }
      
      public function get progressForCurrentLevel() : Number
      {
         if(var_1001.length > 0)
         {
            return var_1616 * progressPerLevel;
         }
         return 0;
      }
      
      public function removeFirstLevel() : void
      {
         var_1001.shift();
         var_1616 = Math.max(0,var_1616 - 1);
      }
   }
}

