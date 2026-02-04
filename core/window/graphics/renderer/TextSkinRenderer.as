package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import com.sulake.core.window.utils.class_3398;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextSkinRenderer extends SkinRenderer
   {
      
      private static const const_14:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
      
      protected var var_89:Matrix;
      
      public function TextSkinRenderer(param1:String)
      {
         super(param1);
         var_89 = new Matrix();
      }
      
      override public function parse(param1:IAsset, param2:XMLList, param3:class_40) : void
      {
         var _loc4_:String = param1.content.toString();
         class_3398.setStyles(class_3398.parseCSS(_loc4_));
      }
      
      override public function draw(param1:class_1741, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         if(param2 != null)
         {
            var _loc7_:ITextFieldContainer = ITextFieldContainer(param1);
            var _loc10_:ITextWindow = ITextWindow(param1);
            var _loc6_:String = _loc10_.autoSize;
            var _loc8_:TextField = null.textField;
            var_89.tx = null.margins.left;
            var_89.ty = null.margins.top;
            if(_loc6_ == "right")
            {
               var_89.tx = Math.floor(param1.width - _loc8_.width - null.margins.right);
            }
            else if(_loc6_ == "center")
            {
               var_89.tx = Math.floor(param1.width / 2 - _loc8_.width / 2);
            }
            if((_loc10_.etchingColor & 0xFF000000) != 0)
            {
               const_14.redOffset = _loc10_.etchingColor >> 16 & 0xFF;
               const_14.greenOffset = _loc10_.etchingColor >> 8 & 0xFF;
               const_14.blueOffset = _loc10_.etchingColor & 0xFF;
               const_14.alphaMultiplier = (_loc10_.etchingColor >> 24 & 0xFF) / 255;
               var _loc9_:Object = ETCHING_POSITION[_loc10_.etchingPosition];
               if(_loc9_ != null)
               {
                  var_89.tx += null.x;
                  var_89.ty += null.y;
                  param2.draw(_loc8_,var_89,const_14,null,null,false);
                  var_89.tx -= null.x;
                  var_89.ty -= null.y;
               }
            }
            if(param1.dynamicStyleColor)
            {
               var _loc11_:ColorTransform = param1.dynamicStyleColor;
            }
            param2.draw(_loc8_,var_89,null,null,null,false);
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

