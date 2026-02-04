package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SeparatorWidget implements ISeparatorWidget
   {
      
      public static const TYPE:String = "separator";
      
      private static const VERTICAL_KEY:String = "separator:vertical";
      
      private static const BORDER_IMAGE_HORIZONTAL:String = "illumina_light_separator_horizontal";
      
      private static const BORDER_IMAGE_VERTICAL:String = "illumina_light_separator_vertical";
      
      private static const VERTICAL_DEFAULT:PropertyStruct = new PropertyStruct("separator:vertical",false,"Boolean");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_110:class_2251;
      
      private var var_342:BitmapData;
      
      private var _children:class_1812;
      
      private var var_1534:Boolean = Boolean(VERTICAL_DEFAULT.value);
      
      public function SeparatorWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("separator_xml").content as XML) as class_1812;
         var_110 = var_134.getChildByName("canvas") as class_2251;
         _children = var_134.getChildByName("children") as class_1812;
         var_110.addEventListener("WE_RESIZE",onChange);
         var_110.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      private function onChange(param1:class_1758) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_342 != null)
            {
               var_342.dispose();
               var_342 = null;
            }
            if(var_110 != null)
            {
               var_110.removeEventListener("WE_RESIZE",onChange);
               var_110.removeEventListener("WE_RESIZED",onChange);
               var_110 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
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
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(VERTICAL_DEFAULT.withValue(var_1534));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("separator:vertical" === _loc3_)
            {
               vertical = Boolean(_loc2_.value);
            }
         }
      }
      
      public function get vertical() : Boolean
      {
         return var_1534;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         var_1534 = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:BitmapData = null;
         var _loc4_:Point = null;
         if(_disposed)
         {
            return;
         }
         if(var_342 == null || var_342.width != var_110.width || var_342.height != var_110.height)
         {
            if(var_342 != null)
            {
               var_342.dispose();
            }
            var_342 = new BitmapData(Math.max(1,var_110.width),Math.max(1,var_110.height),true,0);
            var_110.bitmap = var_342;
         }
         var_342.lock();
         var_342.fillRect(new Rectangle(0,0,var_110.width,var_110.height),0);
         var _loc3_:BitmapDataAsset = _windowManager.assets.getAssetByName(var_1534 ? "illumina_light_separator_vertical" : "illumina_light_separator_horizontal") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.content as BitmapData;
            if(var_1534)
            {
               _loc4_ = new Point(var_110.width / 2 - 1,0);
               while(_loc4_.y < var_110.height)
               {
                  var_342.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.y += _loc3_.rectangle.height;
               }
            }
            else
            {
               _loc4_ = new Point(0,var_110.height / 2 - 1);
               while(_loc4_.x < var_110.width)
               {
                  var_342.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.x += _loc3_.rectangle.width;
               }
            }
         }
         for each(var _loc2_ in _children.iterator)
         {
            if(_loc2_.visible)
            {
               var_342.fillRect(_loc2_.rectangle,0);
            }
         }
         var_342.unlock();
         var_110.invalidate();
      }
   }
}

