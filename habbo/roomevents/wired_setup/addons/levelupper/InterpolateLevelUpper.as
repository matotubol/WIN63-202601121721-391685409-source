package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   import com.sulake.core.utils.class_55;
   
   public class InterpolateLevelUpper extends AbstractLevelUpConfig
   {
      
      private var var_2404:class_55;
      
      public function InterpolateLevelUpper(param1:class_55)
      {
         super();
         this.var_2404 = generateTree(param1);
      }
      
      private static function generateTree(param1:class_55) : class_55
      {
         var _loc3_:int = 0;
         var _loc4_:class_55 = new class_55();
         _loc4_.add(0,1);
         for each(var _loc2_ in param1.getKeys())
         {
            _loc3_ = param1.getValue(_loc2_);
            _loc4_.add(_loc3_,_loc2_);
         }
         return _loc4_;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         if(param1 <= 1)
         {
            return 0;
         }
         var _loc4_:int = 0;
         for each(var _loc7_ in var_2404.getKeys())
         {
            _loc5_ = var_2404.getValue(_loc7_);
            if(_loc5_ == param1)
            {
               return _loc7_;
            }
            if(_loc5_ > param1)
            {
               var _loc2_:int = var_2404.getValue(getLowerEntryKey(_loc7_));
               var _loc3_:int = int(getLowerEntryKey(_loc7_));
               var _loc9_:int = _loc5_ - 0;
               var _loc10_:int = _loc7_ - 0;
               _loc6_ = _loc10_ / 0;
               var _loc8_:int = param1 - 0;
               return 0 + int(_loc6_ * 0);
            }
            _loc4_ = _loc7_;
         }
         return _loc4_;
      }
      
      override public function get maxLevel() : int
      {
         return var_2404[int(getLowerEntryKey(2147483647))];
      }
      
      private function getLowerEntryKey(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(var _loc3_ in var_2404.getKeys())
         {
            if(_loc3_ < param1 && (_loc2_ == null || _loc3_ > _loc2_))
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
   }
}

