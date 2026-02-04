package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CameraFxStrengthSlider
   {
      
      private var var_18:CameraPhotoLab;
      
      private var var_762:class_1812;
      
      private var var_1261:BitmapData;
      
      private var var_1349:BitmapData;
      
      private var _activeBaseArea:class_2251;
      
      private var _sliderBaseWidth:int;
      
      private var _referenceWidth:int;
      
      private var var_4635:int = 0;
      
      public function CameraFxStrengthSlider(param1:CameraPhotoLab, param2:class_1812, param3:class_40)
      {
         super();
         var_18 = param1;
         var_762 = param2;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         var_18 = null;
         var_762 = null;
         var_1261 = null;
         var_1349 = null;
      }
      
      public function disable() : void
      {
         var_762.visible = false;
      }
      
      public function enable() : void
      {
         var_762.visible = true;
      }
      
      public function getScale() : int
      {
         return _referenceWidth;
      }
      
      public function setValue(param1:int) : void
      {
         var _loc2_:class_1741 = null;
         if(var_762 != null)
         {
            _loc2_ = var_762.findChildByName("slider_button");
            if(_loc2_ != null)
            {
               _loc2_.x = param1;
            }
         }
      }
      
      private function buttonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_RELOCATED")
         {
            if(_activeBaseArea)
            {
               _activeBaseArea.width = param2.x / _referenceWidth * _sliderBaseWidth;
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            var_18.setSelectedFxValue(param2.x);
         }
      }
      
      private function shaftProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN" && param2.name == "shaft_click_area")
         {
            _loc3_ = WindowMouseEvent(param1).localX - var_4635;
            setValue(_loc3_);
            var_18.setSelectedFxValue(_loc3_);
         }
      }
      
      private function displaySlider() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:class_2251 = null;
         if(var_762 == null)
         {
            return;
         }
         var _loc1_:IRegionWindow = var_762.findChildByName("shaft_click_area") as IRegionWindow;
         if(_loc1_)
         {
            _loc1_.procedure = shaftProcedure;
         }
         _loc2_ = var_762.findChildByName("slider_base") as class_2251;
         if(_loc2_ != null && var_1261 != null)
         {
            _sliderBaseWidth = _loc2_.width;
            _loc2_.bitmap = new BitmapData(var_1261.width,var_1261.height,true,16777215);
            _loc2_.bitmap.copyPixels(var_1261,var_1261.rect,new Point(0,0),null,null,true);
            _activeBaseArea = _loc2_;
         }
         _loc3_ = var_762.findChildByName("slider_movement_area") as class_1812;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.findChildByName("slider_button") as class_2251;
            if(_loc2_ != null && var_1349 != null)
            {
               _loc2_.bitmap = new BitmapData(var_1349.width,var_1349.height,true,16777215);
               _loc2_.bitmap.copyPixels(var_1349,var_1349.rect,new Point(0,0),null,null,true);
               _loc2_.procedure = buttonProcedure;
               _referenceWidth = _loc3_.width - _loc2_.width;
               var_4635 = (_sliderBaseWidth - _referenceWidth) / 2;
            }
         }
      }
      
      private function storeAssets(param1:class_40) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_bottom_active"));
         var_1261 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_button"));
         var_1349 = BitmapData(_loc2_.content);
      }
   }
}

