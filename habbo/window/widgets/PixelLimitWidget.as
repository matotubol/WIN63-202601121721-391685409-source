package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PixelLimitWidget implements class_2383
   {
      
      public static const TYPE:String = "pixel_limit";
      
      private static const LIMIT_KEY:String = "pixel_limit:limit";
      
      private static const LIMIT_DEFAULT:PropertyStruct = new PropertyStruct("pixel_limit:limit",0,"String",false,null);
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_1899:Boolean;
      
      private var var_134:class_1812;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var var_308:IRegionWindow;
      
      private var var_1909:int = int(LIMIT_DEFAULT.value);
      
      public function PixelLimitWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("badge_image_xml").content as XML) as class_1812;
         _bitmap = var_134.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      public function get limit() : int
      {
         return var_1909;
      }
      
      public function set limit(param1:int) : void
      {
         var_1909 = Math.max(0,Math.min(100,param1));
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_308 != null)
            {
               var_308.removeEventListener("WME_CLICK",onClick);
               var_308.dispose();
               var_308 = null;
            }
            _bitmap = null;
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(LIMIT_DEFAULT.withValue(var_1909));
         for each(var _loc1_ in _bitmap.properties)
         {
            if(_loc1_.key != "asset_uri")
            {
               _loc2_.push(_loc1_.withNameSpace("pixel_limit"));
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_1899 = true;
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            var _loc4_:* = _loc2_.key;
            if("pixel_limit:limit" === _loc4_)
            {
               limit = int(_loc2_.value);
            }
            if(_loc2_.key != "pixel_limit:asset_uri")
            {
               _loc3_.push(_loc2_.withoutNameSpace());
            }
         }
         _bitmap.properties = _loc3_;
         var_1899 = false;
         refresh();
      }
      
      private function refresh() : void
      {
         if(var_1899)
         {
            return;
         }
         _bitmap.assetUri = assetUri;
         _bitmap.invalidate();
      }
      
      private function get assetUri() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = Math.floor(var_1909 / 20) * 20;
         _loc1_ = Math.max(_loc1_,20);
         _loc2_ = "${image.library.url}reception/challenge_meter_%amount%.png";
         return _loc2_.replace("%amount%",_loc1_.toString());
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      public function get bitmapData() : BitmapData
      {
         return class_2201(_bitmap).bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _bitmap.pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _bitmap.pivotPoint = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedX() : Boolean
      {
         return _bitmap.stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _bitmap.stretchedX = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedY() : Boolean
      {
         return _bitmap.stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _bitmap.stretchedY = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomX() : Number
      {
         return _bitmap.zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _bitmap.zoomX = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomY() : Number
      {
         return _bitmap.zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _bitmap.zoomY = param1;
         _bitmap.invalidate();
      }
      
      public function get greyscale() : Boolean
      {
         return _bitmap.greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _bitmap.greyscale = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingColor() : uint
      {
         return _bitmap.etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _bitmap.etchingColor = param1;
         _bitmap.invalidate();
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _bitmap.fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _bitmap.fitSizeToContents = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingPoint() : Point
      {
         return new Point(0,1);
      }
      
      public function get wrapX() : Boolean
      {
         return false;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
      }
      
      public function get wrapY() : Boolean
      {
         return false;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
   }
}

