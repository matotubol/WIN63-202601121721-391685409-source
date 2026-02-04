package com.sulake.habbo.avatar.generic
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_2582;
   
   public class BodyModel extends CategoryBaseModel implements class_2582, class_259
   {
      
      public function BodyModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hd");
         var_265 = true;
         if(!var_18)
         {
            var_18 = new BodyView(this);
            if(var_18)
            {
               var_18.init();
            }
         }
      }
      
      override public function switchCategory(param1:String = "") : void
      {
         var_18.switchCategory(param1);
      }
      
      override public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData = var_143[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         var _loc5_:AvatarEditorGridColorItem = _loc4_.getSelectedColor(param3);
         if(_loc5_.isDisabledForWearing)
         {
            var_55.openHabboClubAdWindow();
            return;
         }
         var_55.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         updateSelectionsFromFigure("hd");
      }
      
      override protected function updateSelectionsFromFigure(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_);
      }
      
      private function getFaceCategoryData() : CategoryData
      {
         if(!var_143)
         {
            return null;
         }
         var _loc1_:CategoryData = var_143["hd"];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc3_:int = var_55.figureData.getPartSetId("hd");
         var _loc2_:Array = var_55.figureData.getColourIds("hd");
         _loc1_.selectPartId(_loc3_);
         _loc1_.selectColorIds(_loc2_);
         return _loc1_;
      }
      
      private function updateIconImage(param1:CategoryData, param2:String = null) : void
      {
         for each(var _loc3_ in param1.parts)
         {
            if(_loc3_.partSet)
            {
               var _loc5_:String = var_55.figureData.getFigureStringWithFace(_loc3_.id);
               if(param2 == null || param2 == null)
               {
                  var _loc4_:class_1827 = var_55.manager.avatarRenderManager.createAvatarImage(null,"h",null,this);
                  _loc3_.iconImage = null.getCroppedImage("head");
                  null.dispose();
               }
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_,param1);
      }
   }
}

