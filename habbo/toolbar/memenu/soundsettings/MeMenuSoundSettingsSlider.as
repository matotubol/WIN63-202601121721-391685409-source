package com.sulake.habbo.toolbar.memenu.soundsettings
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   
   public class MeMenuSoundSettingsSlider
   {
      
      private var var_3009:*;
      
      private var var_762:class_1812;
      
      private var _referenceWidth:int;
      
      private var name_2:Number = 0;
      
      private var name_4:Number = 1;
      
      public function MeMenuSoundSettingsSlider(param1:*, param2:class_1812, param3:class_40, param4:Number = 0, param5:Number = 1)
      {
         super();
         var_3009 = param1;
         var_762 = param2;
         name_2 = param4;
         name_4 = param5;
         displaySlider();
      }
      
      public function dispose() : void
      {
         var_3009 = null;
         var_762 = null;
      }
      
      public function setValue(param1:Number) : void
      {
         if(var_762 == null)
         {
            return;
         }
         var _loc2_:class_1741 = var_762.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(_referenceWidth * ((param1 - name_2) / (name_4 - name_2)));
      }
      
      private function getValue(param1:Number) : Number
      {
         return param1 / _referenceWidth * (name_4 - name_2) + name_2;
      }
      
      private function buttonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_RELOCATED")
         {
            return;
         }
         var_3009.saveVolume(getValue(param2.x),false);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:class_1812 = null;
         var _loc1_:class_1812 = null;
         if(var_762 == null)
         {
            return;
         }
         _loc2_ = var_762.findChildByName("slider_movement_area") as class_1812;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as class_1812;
            if(_loc1_ != null)
            {
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
            }
         }
      }
   }
}

