package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.TextLabelController;
   import com.sulake.core.window.utils.TextFieldCache;
   import com.sulake.core.window.utils.class_3109;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class LabelRenderer extends SkinRenderer
   {
      
      private static const const_14:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
      
      protected var var_89:Matrix;
      
      protected var var_5089:class_3109;
      
      protected var var_1218:TextField;
      
      public function LabelRenderer(param1:String)
      {
         super(param1);
         var_89 = new Matrix();
      }
      
      override public function draw(param1:class_1741, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         if(param2 != null)
         {
            var _loc9_:TextLabelController = TextLabelController(param1);
            var _loc8_:class_3109 = _loc9_.textStyle;
            if(_loc8_ != var_5089)
            {
               var_1218 = TextFieldCache.getTextFieldByStyle(_loc8_);
               var_5089 = _loc8_;
            }
            var_89.tx = null.drawOffsetX;
            var_89.ty = null.drawOffsetY;
            var_1218.text = null.text;
            var _loc6_:uint = uint(_loc8_.color);
            var_1218.textColor = null.hasTextColor ? null.textColor : 0;
            var_1218.antiAliasType = "advanced";
            var_1218.gridFitType = "pixel";
            if(null.vertical)
            {
               var_89.a = 0;
               var_89.b = -1;
               var_89.c = 1;
               var_89.d = 0;
               var_89.ty += null.height;
            }
            if((uint(_loc8_.etchingColor) & 0xFF000000) != 0)
            {
               const_14.redOffset = uint(_loc8_.etchingColor) >> 16 & 0xFF;
               const_14.greenOffset = uint(_loc8_.etchingColor) >> 8 & 0xFF;
               const_14.blueOffset = uint(_loc8_.etchingColor) & 0xFF;
               var _loc7_:Object = ETCHING_POSITION[_loc8_.etchingPosition];
               if(_loc7_ != null)
               {
                  if(null.vertical)
                  {
                     var_89.tx += null.y;
                     var_89.ty -= null.x;
                     param2.draw(var_1218,var_89,const_14,null,null,false);
                     var_89.tx -= null.y;
                     var_89.ty += null.x;
                  }
                  else
                  {
                     var_89.tx += null.x;
                     var_89.ty += null.y;
                     param2.draw(var_1218,var_89,const_14,null,null,false);
                     var_89.tx -= null.x;
                     var_89.ty -= null.y;
                  }
               }
            }
            if(param1.dynamicStyleColor)
            {
               var _loc10_:ColorTransform = param1.dynamicStyleColor;
            }
            param2.draw(var_1218,var_89,null,null,null,false);
            if(null.vertical)
            {
               var_89.a = 1;
               var_89.b = 0;
               var_89.c = 0;
               var_89.d = 1;
               var_89.ty -= null.height;
            }
            var_1218.textColor = 0;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

