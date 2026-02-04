package com.sulake.habbo.avatar.common
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.inventory.class_61;
   
   public class CategoryBaseModel implements class_2582
   {
      
      protected var var_143:class_55;
      
      protected var var_55:HabboAvatarEditor;
      
      protected var var_265:Boolean = false;
      
      protected var var_18:class_3708;
      
      private var var_1134:Boolean;
      
      public function CategoryBaseModel(param1:HabboAvatarEditor)
      {
         super();
         var_55 = param1;
      }
      
      public function dispose() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
         }
         var_18 = null;
         var_143 = null;
         var_55 = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      protected function init() : void
      {
         if(!var_143)
         {
            var_143 = new class_55();
         }
      }
      
      public function reset() : void
      {
         var_265 = false;
         for each(var _loc1_ in var_143)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         var_143 = new class_55();
         if(var_18)
         {
            var_18.reset();
         }
      }
      
      protected function initCategory(param1:String) : void
      {
         var _loc2_:CategoryData = var_143[param1];
         if(_loc2_ == null)
         {
            var _loc3_:CategoryData = var_55.generateDataContent(this,param1);
         }
      }
      
      public function switchCategory(param1:String = "") : void
      {
         if(!var_265)
         {
            init();
         }
         if(var_18)
         {
            var_18.switchCategory(param1);
         }
      }
      
      protected function updateSelectionsFromFigure(param1:String) : void
      {
         if(!var_143 || !var_55 || !var_55.figureData)
         {
            return;
         }
         var _loc2_:CategoryData = var_143[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = var_55.figureData.getPartSetId(param1);
         var _loc3_:Array = var_55.figureData.getColourIds(param1);
         if(!_loc3_)
         {
            _loc3_ = [];
         }
         _loc2_.selectPartId(_loc4_);
         _loc2_.selectColorIds(_loc3_);
         if(var_18)
         {
            var_18.showPalettes(param1,_loc3_.length);
         }
      }
      
      public function hasClubItemsOverLevel(param1:int) : Boolean
      {
         if(!var_143)
         {
            return false;
         }
         for each(var _loc3_ in var_143.getValues())
         {
            if(_loc3_ != null)
            {
               var _loc2_:Boolean = _loc3_.hasClubSelectionsOverLevel(param1);
            }
         }
         return false;
      }
      
      public function hasInvalidSellableItems(param1:class_61) : Boolean
      {
         if(!var_143)
         {
            return false;
         }
         for each(var _loc3_ in var_143.getValues())
         {
            if(_loc3_ != null)
            {
               var _loc2_:Boolean = _loc3_.hasInvalidSellableItems(param1);
            }
         }
         return false;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc7_:CategoryData = null;
         var _loc5_:Boolean = false;
         var _loc3_:AvatarEditorGridPartItem = null;
         if(!var_143)
         {
            return false;
         }
         var _loc8_:Array = var_143.getKeys();
         var _loc4_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc2_ = _loc8_[_loc6_];
            _loc7_ = var_143[_loc2_];
            _loc5_ = false;
            if(_loc7_.stripClubItemsOverLevel(param1))
            {
               _loc5_ = true;
            }
            if(_loc7_.stripClubColorsOverLevel(param1))
            {
               _loc5_ = true;
            }
            if(_loc5_)
            {
               _loc3_ = _loc7_.getCurrentPart();
               if(_loc3_ && var_55 && var_55.figureData && _loc7_)
               {
                  var_55.figureData.savePartData(_loc2_,_loc3_.id,_loc7_.getSelectedColorIds(),true);
               }
               _loc4_ = true;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function stripInvalidSellableItems() : Boolean
      {
         var _loc5_:int = 0;
         var _loc1_:String = null;
         var _loc6_:CategoryData = null;
         var _loc4_:Boolean = false;
         var _loc2_:AvatarEditorGridPartItem = null;
         if(!var_143)
         {
            return false;
         }
         var _loc7_:Array = var_143.getKeys();
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc1_ = _loc7_[_loc5_];
            _loc6_ = var_143[_loc1_];
            _loc4_ = false;
            if(_loc6_.stripInvalidSellableItems(var_55.manager.inventory))
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _loc2_ = _loc6_.getCurrentPart();
               if(_loc2_ && var_55 && var_55.figureData && _loc6_)
               {
                  var_55.figureData.savePartData(_loc1_,_loc2_.id,_loc6_.getSelectedColorIds(),true);
               }
               _loc3_ = true;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = var_143[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:int = _loc3_.selectedPartIndex;
         _loc3_.selectPartIndex(param2);
         var _loc4_:AvatarEditorGridPartItem = _loc3_.getCurrentPart();
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.isDisabledForWearing)
         {
            _loc3_.selectPartIndex(_loc5_);
            var_55.openHabboClubAdWindow();
            return;
         }
         if(var_18)
         {
            var_18.showPalettes(param1,_loc4_.colorLayerCount);
         }
         if(var_55 && var_55.figureData)
         {
            var_55.figureData.savePartData(param1,_loc4_.id,_loc3_.getSelectedColorIds(),true);
         }
      }
      
      public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc6_:AvatarEditorGridColorItem = null;
         var _loc5_:CategoryData = var_143[param1];
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:int = _loc5_.getCurrentColorIndex(param3);
         _loc5_.selectColorIndex(param2,param3);
         if(var_55 && var_55.figureData)
         {
            _loc6_ = _loc5_.getSelectedColor(param3);
            if(_loc6_.isDisabledForWearing)
            {
               _loc5_.selectColorIndex(_loc4_,param3);
               var_55.openHabboClubAdWindow();
               return;
            }
            var_55.figureData.savePartSetColourId(param1,_loc5_.getSelectedColorIds(),true);
         }
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return var_55;
      }
      
      public function getWindowContainer() : class_1741
      {
         if(!var_265)
         {
            init();
         }
         if(!var_18)
         {
            return null;
         }
         return var_18.getWindowContainer();
      }
      
      public function getCategoryData(param1:String) : CategoryData
      {
         if(!var_265)
         {
            init();
         }
         if(!var_143)
         {
            return null;
         }
         return var_143[param1];
      }
   }
}

