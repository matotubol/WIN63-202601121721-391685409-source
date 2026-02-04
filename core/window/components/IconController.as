package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.graphics.renderer.BitmapSkinRenderer;
   import com.sulake.core.window.graphics.renderer.ISkinLayout;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import flash.geom.Rectangle;
   
   public class IconController extends WindowController implements IIconWindow
   {
      
      public function IconController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set style(param1:uint) : void
      {
         super.style = param1;
      }
      
      public function fitToSize() : void
      {
         var _loc3_:ISkinRenderer = _context.getWindowFactory().getRendererByTypeAndStyle(1,style);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:BitmapSkinRenderer = _loc3_ as BitmapSkinRenderer;
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:ISkinLayout = _loc2_.getLayoutByState(state);
         if(!_loc1_)
         {
            return;
         }
         var _loc4_:int = int(_loc1_.width);
         var _loc5_:int = int(_loc1_.height);
         if(_loc4_ != var_29 || _loc5_ != var_32)
         {
            setRectangle(var_25,var_26,_loc4_,_loc5_);
         }
      }
   }
}

