package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import flash.events.Event;
   
   public class SliderWindowControllerNew extends EventDispatcherWrapper
   {
      
      private var var_1550:Number = 0;
      
      private var var_762:class_1812;
      
      private var var_1071:Boolean = false;
      
      private var name_2:Number = 0;
      
      private var name_4:Number = 1;
      
      private var var_1288:Number = 0;
      
      public function SliderWindowControllerNew(param1:class_1812, param2:Number = 0, param3:Number = 1, param4:Number = 0)
      {
         super();
         var_762 = param1;
         name_2 = param2;
         name_4 = param3;
         var_1288 = param4;
         var_1550 = 0;
         sliderButton.procedure = sliderProcedure;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_762.dispose();
         var_762 = null;
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
         return int(referenceWidth * ((param1 - name_2) / (name_4 - name_2)));
      }
      
      private function getValueAtPosition(param1:Number) : Number
      {
         return param1 / referenceWidth * (name_4 - name_2) + name_2;
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
      
      public function moveSliderToRight() : void
      {
         var _loc1_:Number = NaN;
         var_1071 = false;
         if(var_1288 != 0)
         {
            _loc1_ = var_1550 + var_1288;
            setValue(_loc1_);
         }
      }
      
      public function moveSliderToLeft() : void
      {
         var _loc1_:Number = NaN;
         var_1071 = false;
         if(var_1288 != 0)
         {
            _loc1_ = var_1550 - var_1288;
            setValue(_loc1_);
         }
      }
      
      private function get referenceWidth() : int
      {
         return sliderMovementArea.width - sliderButton.width;
      }
      
      private function get sliderBase() : IStaticBitmapWrapperWindow
      {
         return var_762.findChildByName("slider_base") as IStaticBitmapWrapperWindow;
      }
      
      private function get sliderMovementArea() : class_1812
      {
         return var_762.findChildByName("slider_movement_area") as class_1812;
      }
      
      private function get sliderButton() : IStaticBitmapWrapperWindow
      {
         return var_762.findChildByName("slider_button") as IStaticBitmapWrapperWindow;
      }
   }
}

