package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BackgroundViewController implements class_13
   {
      
      private var _disposed:Boolean;
      
      private var var_49:SnowWarEngine;
      
      private var _background:class_1812;
      
      public function BackgroundViewController(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_49 = null;
         if(_background)
         {
            _background.dispose();
            _background = null;
         }
         _disposed = true;
      }
      
      public function get background() : class_1741
      {
         if(!_background)
         {
            createView();
         }
         return _background;
      }
      
      private function createView() : void
      {
         var _loc1_:class_2052 = var_49.windowManager.getDesktop(0);
         _background = WindowUtils.createWindow("snowwar_loading_background_xml",1) as class_1812;
         _background.width = _loc1_.width;
         _background.height = _loc1_.height;
         _loc1_.addChildAt(_background,0);
         setBitmap("bg_sky","sky",_background);
         setBitmap("bg_sunshine","sunshine",_background);
         setBitmap("bg_vista_1","vista_1",_background,true);
         setBitmap("bg_vista_2","vista_2",_background,true);
         setBitmap("bg_vista_3","vista_3",_background,true);
      }
      
      private function setBitmap(param1:String, param2:String, param3:class_1812, param4:Boolean = false) : void
      {
         var _loc9_:BitmapDataAsset = var_49.assets.getAssetByName(param1) as BitmapDataAsset;
         var _loc7_:class_2251 = param3.findChildByName(param2) as class_2251;
         var _loc5_:BitmapData = _loc9_.content as BitmapData;
         if(param4)
         {
            var _loc8_:BitmapData = new BitmapData(param3.width,_loc5_.height,true,0);
            var _loc6_:int = 0;
            while(0 < param3.width / _loc5_.width + 1)
            {
               null.copyPixels(_loc5_,_loc5_.rect,new Point(0 * _loc5_.width,0));
               _loc6_++;
            }
            _loc7_.bitmap = null;
         }
         else
         {
            _loc7_.bitmap = _loc5_;
            _loc7_.disposesBitmap = false;
         }
      }
   }
}

