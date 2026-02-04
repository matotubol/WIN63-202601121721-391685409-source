package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3805;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class LimitedItemGridOverlayWidget implements ILimitedItemGridOverlayWidget, class_31
   {
      
      public static const TYPE:String = "limited_item_overlay_grid";
      
      private const SHINE_INTERVAL_MS:uint = 10000;
      
      private const SHINE_LENGTH_MS:uint = 250;
      
      private var _disposed:Boolean = false;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_2407:BitmapData;
      
      private var var_1180:class_2251;
      
      private var _serialNumber:int;
      
      private var var_1336:uint = getTimer();
      
      private var var_2548:uint = var_1336;
      
      private var var_3348:Boolean = false;
      
      public function LimitedItemGridOverlayWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_2407 = BitmapData(_windowManager.assets.getAssetByName("unique_item_label_plaque_metal").content).clone();
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_griditem_xml").content)));
         var_1180 = class_2251(var_134.findChildByName("unique_item_overlay_plaque_background_bitmap"));
         var_1180.bitmap = var_2407;
         var_210.rootWindow = var_134;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_3348)
            {
               _windowManager.removeUpdateReceiver(this);
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set serialNumber(param1:int) : void
      {
         _serialNumber = param1;
         var _loc2_:class_2251 = class_2251(var_134.findChildByName("unique_item_overlay_plaque_number_bitmap"));
         _loc2_.bitmap = class_3805.createBitmap(_windowManager.assets,serialNumber,_loc2_.width,_loc2_.height);
      }
      
      public function set seriesSize(param1:int) : void
      {
      }
      
      public function get serialNumber() : int
      {
         return _serialNumber;
      }
      
      public function get seriesSize() : int
      {
         return 0;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get animated() : Boolean
      {
         return var_3348;
      }
      
      public function set animated(param1:Boolean) : void
      {
         var_3348 = param1;
         if(var_3348)
         {
            _windowManager.registerUpdateReceiver(this,5);
         }
         else
         {
            _windowManager.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(!disposed)
         {
            var_1336 += param1;
            if(var_1336 - var_2548 > 10000)
            {
               _loc2_ = new BitmapData(var_1180.width,var_1180.height,false);
               _loc3_ = (var_1336 - var_2548 - 10000) / 250;
               if(_loc3_ < 1)
               {
                  _loc4_ = (var_2407.height - var_1180.height) * _loc3_;
                  _loc2_.copyPixels(var_2407,new Rectangle(0,_loc4_,var_1180.width,var_1180.height),new Point(0,0));
                  var_1180.bitmap = _loc2_;
               }
               else
               {
                  var_1180.bitmap = var_2407;
                  var_2548 = var_1336;
               }
            }
         }
      }
   }
}

