package com.sulake.habbo.quest
{
   import flash.utils.Dictionary;
   import package_163.class_3303;
   
   public class AchievementCategories
   {
      
      private static const ACHIEVEMENT_DISABLED:int = 0;
      
      private static const ACHIEVEMENT_ENABLED:int = 1;
      
      private static const ACHIEVEMENT_ARCHIVED:int = 2;
      
      private static const ACHIEVEMENT_OFF_SEASON:int = 3;
      
      public static const ACHIEVEMENT_CATEGORY_ARCHIVED:String = "archive";
      
      public static const ACHIEVEMENT_CATEGORY_NEW:String = "new";
      
      private var var_1483:Dictionary = new Dictionary();
      
      private var var_1081:Vector.<AchievementCategory> = new Vector.<AchievementCategory>(0);
      
      private var _questEngine:HabboQuestEngine;
      
      public function AchievementCategories(param1:Array, param2:HabboQuestEngine)
      {
         super();
         _questEngine = param2;
         var _loc3_:AchievementCategory = new AchievementCategory("archive");
         var_1483["archive"] = _loc3_;
         var _loc5_:Vector.<class_3303> = new Vector.<class_3303>();
         var _loc7_:Vector.<String> = getNewAchievementCodes();
         for each(var _loc4_ in param1)
         {
            if(_loc4_.category != "")
            {
               if(null.state == 2)
               {
                  var _loc8_:AchievementCategory = var_1483["archive"];
               }
               else
               {
                  _loc8_ = var_1483[null.category];
               }
               _loc8_ = new AchievementCategory(null.category);
               var_1483[null.category] = null;
               if(null.category != "misc")
               {
                  var_1081.push(null);
               }
               else
               {
                  var _loc6_:* = null;
               }
               null.add(null);
               if(achievementIsNew(_loc7_,null))
               {
                  _loc5_.push(null);
               }
            }
         }
         var_1081.push(_loc3_);
         if(_loc5_.length > 0)
         {
            _loc8_ = new AchievementCategory("new");
            var_1483["new"] = null;
            var_1081.push(null);
            for each(_loc4_ in _loc5_)
            {
               null.add(null);
            }
         }
      }
      
      private function achievementIsNew(param1:Vector.<String>, param2:class_3303) : Boolean
      {
         var _loc4_:String = param2.badgeId;
         if(_loc4_.indexOf("ACH_") == 0)
         {
            _loc4_ = _loc4_.substr(4);
         }
         while(_loc4_.length > 0 && "0123456789".indexOf(_loc4_.charAt(_loc4_.length - 1)) != -1)
         {
            _loc4_ = _loc4_.substr(0,_loc4_.length - 1);
         }
         return param1.indexOf(_loc4_) != -1;
      }
      
      private function getNewAchievementCodes() : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:String = _questEngine.getProperty("achievements.new");
         var _loc1_:Array = _loc3_.split(",");
         for each(var _loc4_ in _loc1_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function update(param1:class_3303) : void
      {
         if(param1 == null || param1.category == "")
         {
            return;
         }
         var _loc2_:AchievementCategory = var_1483[param1.category];
         if(_loc2_ != null)
         {
            _loc2_.update(param1);
         }
         _loc2_ = var_1483["new"];
         if(_loc2_ != null)
         {
            _loc2_.update(param1);
         }
      }
      
      public function get categoryList() : Vector.<AchievementCategory>
      {
         return var_1081;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_1081)
         {
            _loc1_ += _loc2_.getMaxProgress();
         }
         return _loc1_;
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_1081)
         {
            _loc1_ += _loc2_.getProgress();
         }
         return _loc1_;
      }
      
      public function getCategoryByCode(param1:String) : AchievementCategory
      {
         for each(var _loc2_ in var_1081)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

