package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class DimmerViewAlphaSlider
   {
      
      private var var_18:DimmerView;
      
      private var var_762:class_1812;
      
      private var var_1261:BitmapData;
      
      private var var_1349:BitmapData;
      
      private var _referenceWidth:int;
      
      private var var_4635:int;
      
      private var name_2:int = 0;
      
      private var name_4:int = 255;
      
      public function DimmerViewAlphaSlider(param1:DimmerView, param2:class_1812, param3:class_40, param4:int = 0, param5:int = 255)
      {
         super();
         var_18 = param1;
         var_762 = param2;
         name_2 = param4;
         name_4 = param5;
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
      
      public function setValue(param1:int) : void
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
      
      public function set min(param1:Number) : void
      {
         name_2 = param1;
         setValue(var_18.selectedBrightness);
      }
      
      public function set max(param1:Number) : void
      {
         name_4 = param1;
         setValue(var_18.selectedBrightness);
      }
      
      private function getSliderPosition(param1:int) : int
      {
         return int(_referenceWidth * ((param1 - name_2) / (name_4 - name_2)));
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / _referenceWidth * (name_4 - name_2)) + name_2;
      }
      
      private function buttonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         var_18.selectedBrightness = getValue(param2.x);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:class_1812 = null;
         var _loc1_:class_2251 = null;
         if(var_762 == null)
         {
            return;
         }
         _loc1_ = var_762.findChildByName("slider_base") as class_2251;
         if(_loc1_ != null && var_1261 != null)
         {
            _loc1_.bitmap = new BitmapData(var_1261.width,var_1261.height,true,16777215);
            _loc1_.bitmap.copyPixels(var_1261,var_1261.rect,new Point(0,0),null,null,true);
         }
         _loc2_ = var_762.findChildByName("slider_movement_area") as class_1812;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as class_2251;
            if(_loc1_ != null && var_1349 != null)
            {
               _loc1_.bitmap = new BitmapData(var_1349.width,var_1349.height,true,16777215);
               _loc1_.bitmap.copyPixels(var_1349,var_1349.rect,new Point(0,0),null,null,true);
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
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
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_base"));
         var_1261 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_button"));
         var_1349 = BitmapData(_loc2_.content);
      }
   }
}

