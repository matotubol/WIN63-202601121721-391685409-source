package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_2972;
   import com.sulake.habbo.avatar.common.*;
   
   public class AvatarEditorGridViewEffects implements class_3455
   {
      
      private var var_18:class_1812;
      
      private var var_4072:Boolean = true;
      
      private var var_36:class_2582;
      
      private var var_2851:String;
      
      private var var_690:IItemGridWindow;
      
      private var _effectItems:Vector.<AvatarEditorGridItemEffect>;
      
      private var var_2193:class_1741;
      
      private var var_839:class_1741;
      
      public function AvatarEditorGridViewEffects(param1:class_1812)
      {
         super();
         var_18 = param1;
         var_690 = var_18.findChildByName("thumbs") as IItemGridWindow;
         var_2193 = var_18.findChildByName("content_notification");
         var_839 = var_18.findChildByName("content_title");
      }
      
      public function dispose() : void
      {
         if(var_690)
         {
            var_690.dispose();
            var_690 = null;
         }
         var_36 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function get window() : class_1812
      {
         return var_18;
      }
      
      public function initFromList(param1:class_2582, param2:String) : void
      {
         var_36 = param1;
         var_2851 = param2;
         var_18.visible = true;
         var _loc3_:Array = EffectsModel(var_36).effects;
         var_690.removeGridItems();
         _effectItems = new Vector.<AvatarEditorGridItemEffect>();
         if(_loc3_.length == 0)
         {
            var_839.visible = true;
            var_2193.visible = true;
         }
         else
         {
            var_2193.visible = false;
            var_839.visible = false;
            var _loc5_:AvatarEditorGridItemEffect = new AvatarEditorGridItemEffect(null,var_36.controller.manager.windowManager,var_36.controller.manager.assets);
            addGridItem(null);
            for each(var _loc4_ in _loc3_)
            {
               _loc5_ = new AvatarEditorGridItemEffect(_loc4_,var_36.controller.manager.windowManager,var_36.controller.manager.assets);
               addGridItem(null);
            }
         }
         showPalettes(0);
         var_4072 = false;
      }
      
      private function addGridItem(param1:AvatarEditorGridItemEffect) : void
      {
         param1.window.procedure = partEventProc;
         _effectItems.push(param1);
         var_690.addGridItem(param1.window);
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc3_:class_1741 = var_18.findChildByName("palette0");
         var _loc2_:class_1741 = var_18.findChildByName("palette1");
         _loc3_.visible = false;
         _loc2_.visible = false;
      }
      
      public function get firstView() : Boolean
      {
         return var_4072;
      }
      
      public function updateSelection(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < _effectItems.length)
         {
            _effectItems[param1].selected = param2;
         }
      }
      
      public function getGridIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _effectItems.length)
         {
            if(_effectItems[_loc2_].effectType == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function partEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_DOWN")
         {
            var _loc3_:int = var_690.getGridItemIndex(param1.window);
            var_36.selectPart(var_2851,0);
         }
      }
   }
}

