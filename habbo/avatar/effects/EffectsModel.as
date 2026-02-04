package com.sulake.habbo.avatar.effects
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.class_2972;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.inventory.class_1777;
   import flash.utils.Dictionary;
   
   public class EffectsModel extends CategoryBaseModel implements class_2582
   {
      
      public static const GRIDTYPE_EFFECTS:String = "effects";
      
      private var var_639:Dictionary = new Dictionary();
      
      private var var_3574:EffectsParamView;
      
      public function EffectsModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         var_265 = true;
         if(!var_18)
         {
            var_18 = new EffectsView(this);
            var_3574 = new EffectsParamView(this,controller.manager.windowManager,controller.manager.assets);
            if(var_18)
            {
               var_18.init();
            }
         }
      }
      
      public function get effects() : Array
      {
         if(controller.manager.inventory == null)
         {
            return [];
         }
         return controller.manager.inventory.getAvatarEffects();
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:class_2972 = null;
         setSelectionVisual(param1,var_639[param1],false);
         var _loc5_:int = controller.figureData.avatarEffectType;
         if(param2 == -1 && _loc5_ != -1)
         {
            param2 = int(EffectsView(var_18).getGridIndex(_loc5_));
            for each(var _loc4_ in effects)
            {
               if(_loc4_.type == _loc5_)
               {
                  _loc3_ = class_2972(_loc4_);
                  _loc3_.isSelected = true;
                  break;
               }
            }
         }
         else if(param2 == -1 && _loc5_ == -1 || param2 == 0)
         {
            param2 = 0;
            controller.setAvatarEffectType(-1);
            var_3574.updateView(null);
         }
         else
         {
            _loc3_ = class_2972(effects[param2 - 1]);
            _loc3_.isSelected = true;
            controller.setAvatarEffectType(_loc3_.type);
         }
         var_639[param1] = param2;
         setSelectionVisual(param1,param2,true);
         var_3574.updateView(_loc3_);
      }
      
      private function setSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         EffectsView(var_18).updateSelectionVisual(param1,param2,param3);
      }
   }
}

