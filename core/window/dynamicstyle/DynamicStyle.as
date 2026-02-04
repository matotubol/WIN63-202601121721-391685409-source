package com.sulake.core.window.dynamicstyle
{
   import com.sulake.core.window.WindowController;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class DynamicStyle
   {
      
      public static const STYLE_LIFTED_HOVER:String = "lifted_hover";
      
      public static const const_89:String = "button";
      
      public static const BRIGHTNESS_AND_SHADOW_UNDER:String = "brightness_and_shadow_under";
      
      public static const BRIGHTNESS_AND_SHADOW_UNDER_GENTLE:String = "brightness_and_shadow_under_gentle";
      
      public var name:String;
      
      public var var_1327:Object = {};
      
      public var defaultStyles:Object = {};
      
      public var pressedSyles:Object = {};
      
      public var var_3732:Object = {"colorTransform":[1,1,1,0.4,0,0,0,0]};
      
      public var var_1434:Dictionary = new Dictionary();
      
      public function DynamicStyle(param1:String = "")
      {
         super();
         this.name = param1;
      }
      
      public function getStyleByWindowState(param1:uint) : Object
      {
         switch(param1)
         {
            case 16:
               return pressedSyles;
            case 4:
               return var_1327;
            case 0:
               return defaultStyles;
            case 32:
               return var_3732;
            default:
               return {};
         }
      }
      
      private function getChildDynamicStyleByKey(param1:String) : DynamicStyle
      {
         if(var_1434[param1])
         {
            return var_1434[param1];
         }
         return new DynamicStyle();
      }
      
      public function getChildStyle(param1:WindowController) : DynamicStyle
      {
         for each(var _loc2_ in param1.tags)
         {
            if(_loc2_.charAt(0) == "#")
            {
               return getChildDynamicStyleByKey(_loc2_);
            }
         }
         return null;
      }
      
      public function getColorValue(param1:uint) : uint
      {
         if(!getStyleByWindowState(param1).colorTransform)
         {
            return null;
         }
         var _loc2_:Array = getStyleByWindowState(param1).colorTransform;
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(true)
         {
            var _loc5_:int = null[0] * 255 + null[0 + 4];
            _loc3_ = null + Math.min(255,0).toString(16);
            _loc4_++;
         }
      }
      
      public function getColorTransform(param1:uint) : ColorTransform
      {
         if(getStyleByWindowState(param1).colorTransform)
         {
            var _loc2_:Array = getStyleByWindowState(param1).colorTransform;
            var _loc3_:Array = getStyleByWindowState(param1).tint;
            _loc3_ = [255,255,255];
            return new ColorTransform(null[0] * null[0] / 255,null[1] * null[1] / 255,null[2] * null[2] / 255,null[3],null[4],null[5],null[6],null[7]);
         }
         return new ColorTransform();
      }
   }
}

