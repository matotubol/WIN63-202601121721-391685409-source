package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class SliderWindowController extends EventDispatcherWrapper
   {
      
      private var var_1550:Number = 0;
      
      private var var_762:class_1812;
      
      private var var_1071:Boolean = false;
      
      private var var_1261:BitmapData;
      
      private var var_1349:BitmapData;
      
      private var _referenceWidth:int;
      
      private var name_2:Number = 0;
      
      private var name_4:Number = 1;
      
      private var var_1288:Number = 0;
      
      public function SliderWindowController(param1:HabboUserDefinedRoomEvents, param2:class_1812, param3:class_40, param4:Number = 0, param5:Number = 1, param6:Number = 0)
      {
         super();
         var_762 = class_1812(param1.getXmlWindow("ude_slider"));
         param2.addChild(var_762);
         name_2 = param4;
         name_4 = param5;
         var_1288 = param6;
         var_1550 = 0;
         storeAssets(param3);
         displaySlider();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_762 = null;
         var_1261 = null;
         var_1349 = null;
      }
      
      public function setValue(param1:Number, param2:Boolean = true, param3:Boolean = true) : void
      {
         param1 = Math.max(name_2,param1);
         param1 = Math.min(name_4,param1);
         var_1550 = param1;
         if(param2)
         {
            updateSliderPosition();
         }
         if(param3)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function getValue() : Number
      {
         return var_1550;
      }
      
      public function set min(param1:Number) : void
      {
         name_2 = param1;
      }
      
      public function set max(param1:Number) : void
      {
         name_4 = param1;
      }
      
      private function updateSliderPosition() : void
      {
         if(var_762 == null)
         {
            return;
         }
         var _loc1_:class_1741 = var_762.findChildByName("slider_button");
         if(_loc1_ != null)
         {
            _loc1_.x = getSliderPosition(var_1550);
         }
         _loc1_.parent.invalidate();
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(_referenceWidth * ((param1 - name_2) / (name_4 - name_2)));
      }
      
      private function getValueAtPosition(param1:Number) : Number
      {
         return param1 / _referenceWidth * (name_4 - name_2) + name_2;
      }
      
      private function sliderProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.type == "WME_DOWN")
         {
            var_1071 = true;
         }
         if(var_1071)
         {
            if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
            {
               var_1071 = false;
            }
         }
         if(!var_1071 || param1.type != "WE_RELOCATED")
         {
            return;
         }
         if(var_1288 != 0)
         {
            _loc4_ = getValueAtPosition(param2.x);
            _loc3_ = Math.round(_loc4_ / var_1288) * var_1288;
            setValue(_loc3_,false);
         }
      }
      
      private function sliderButtonRightProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:Number = NaN;
         if(param1.type == "WME_CLICK")
         {
            var_1071 = false;
            if(var_1288 != 0)
            {
               _loc3_ = var_1550 + var_1288;
               setValue(_loc3_);
            }
         }
      }
      
      private function sliderButtonLeftProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:Number = NaN;
         if(param1.type == "WME_CLICK")
         {
            var_1071 = false;
            if(var_1288 != 0)
            {
               _loc3_ = var_1550 - var_1288;
               setValue(_loc3_);
            }
         }
      }
      
      private function displaySlider() : void
      {
         var _loc1_:class_1812 = null;
         var _loc3_:class_2251 = null;
         var _loc4_:class_2143 = null;
         var _loc2_:class_2143 = null;
         if(var_762 == null)
         {
            return;
         }
         _loc3_ = var_762.findChildByName("slider_base") as class_2251;
         if(_loc3_ != null && var_1261 != null)
         {
            _loc3_.bitmap = new BitmapData(var_1261.width,var_1261.height,true,16777215);
            _loc3_.bitmap.copyPixels(var_1261,var_1261.rect,new Point(0,0),null,null,true);
         }
         _loc1_ = var_762.findChildByName("slider_movement_area") as class_1812;
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.findChildByName("slider_button") as class_2251;
            if(_loc3_ != null && var_1349 != null)
            {
               _loc3_.bitmap = new BitmapData(var_1349.width,var_1349.height,true,16777215);
               _loc3_.bitmap.copyPixels(var_1349,var_1349.rect,new Point(0,0),null,null,true);
               _loc3_.procedure = sliderProcedure;
               _referenceWidth = _loc1_.width - _loc3_.width;
            }
         }
         _loc2_ = var_762.findChildByName("slider_button_left") as class_2143;
         if(_loc2_)
         {
            _loc2_.procedure = sliderButtonLeftProcedure;
         }
         _loc4_ = var_762.findChildByName("slider_button_right") as class_2143;
         if(_loc4_)
         {
            _loc4_.procedure = sliderButtonRightProcedure;
         }
      }
      
      private function storeAssets(param1:class_40) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_bg_png"));
         var_1261 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_obj_png"));
         var_1349 = BitmapData(_loc2_.content);
      }
   }
}

