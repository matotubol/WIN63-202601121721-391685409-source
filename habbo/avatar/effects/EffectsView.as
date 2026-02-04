package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.common.class_3708;
   
   public class EffectsView extends CategoryBaseView implements class_3708
   {
      
      public function EffectsView(param1:class_2582)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_36.controller.view.getCategoryContainer("effects") as class_1812;
            _window.visible = false;
         }
         if(var_36 && var_145 == "")
         {
            var_36.switchCategory("effects");
         }
         var_265 = true;
         updateGridView(var_145);
      }
      
      override public function reset() : void
      {
         updateGridView(var_145);
         var_36.selectPart(var_145,-1);
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         param1 = param1 == "" ? var_145 : param1;
         var_145 = param1;
         if(!var_265)
         {
            init();
         }
         updateGridView(var_145);
      }
      
      public function updateSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         AvatarEditorGridViewEffects(var_36.controller.view.effectsGridView).updateSelection(param2,param3);
      }
      
      public function getGridIndex(param1:int) : int
      {
         return AvatarEditorGridViewEffects(var_36.controller.view.effectsGridView).getGridIndex(param1);
      }
      
      override protected function updateGridView(param1:String) : void
      {
         var_36.controller.view.effectsGridView.initFromList(var_36,param1);
      }
   }
}

