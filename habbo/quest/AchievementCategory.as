package com.sulake.habbo.quest
{
   import package_163.class_3303;
   
   public class AchievementCategory
   {
      
      private var var_3602:String;
      
      private var var_1423:Vector.<class_3303> = new Vector.<class_3303>(0);
      
      public function AchievementCategory(param1:String)
      {
         super();
         var_3602 = param1;
      }
      
      public function add(param1:class_3303) : void
      {
         var_1423.push(param1);
      }
      
      public function update(param1:class_3303) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3303 = null;
         _loc3_ = 0;
         while(_loc3_ < var_1423.length)
         {
            _loc2_ = var_1423[_loc3_];
            if(_loc2_.achievementId == param1.achievementId)
            {
               var_1423[_loc3_] = param1;
            }
            _loc3_++;
         }
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_1423)
         {
            _loc1_ += _loc2_.finalLevel ? _loc2_.level : _loc2_.level - 1;
         }
         return _loc1_;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_1423)
         {
            _loc1_ += _loc2_.levelCount;
         }
         return _loc1_;
      }
      
      public function get code() : String
      {
         return var_3602;
      }
      
      public function get achievements() : Vector.<class_3303>
      {
         return var_1423;
      }
      
      public function visibleInList() : Boolean
      {
         return var_3602 != "new";
      }
   }
}

