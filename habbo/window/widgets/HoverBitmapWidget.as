package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class HoverBitmapWidget implements class_2689
   {
      
      public static const TYPE:String = "hover_bitmap";
      
      private static const const_374:String = "hover_bitmap:hover_asset";
      
      private static const NORMAL_ASSET_KEY:String = "hover_bitmap:normal_asset";
      
      private static const HOVER_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:hover_asset",null,"String");
      
      private static const NORMAL_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:normal_asset",null,"String");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var _normalAsset:String;
      
      private var _hoverAsset:String;
      
      private var var_2558:Boolean = false;
      
      public function HoverBitmapWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         _bitmap = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("hover_bitmap_xml").content as XML) as IStaticBitmapWrapperWindow;
         _bitmap.addEventListener("WME_OVER",onMouseOver);
         _bitmap.addEventListener("WME_OUT",onMouseOut);
         var_210.rootWindow = _bitmap;
         _bitmap.width = var_210.width;
         _bitmap.height = var_210.height;
         _bitmap.invalidate();
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var_2558 = true;
         _bitmap.assetUri = _hoverAsset;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var_2558 = false;
         _bitmap.assetUri = _normalAsset;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_bitmap != null)
            {
               _bitmap.dispose();
               _bitmap = null;
            }
            var_210.rootWindow = null;
            var_210 = null;
            _windowManager = null;
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
         _loc2_.push(NORMAL_ASSET_DEFAULT.withValue(_normalAsset));
         _loc2_.push(HOVER_ASSET_DEFAULT.withValue(_hoverAsset));
         if(_bitmap != null)
         {
            for each(var _loc1_ in _bitmap.properties)
            {
               if(_loc1_.key != "asset_uri")
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "hover_bitmap:normal_asset":
                  normalAsset = String(_loc2_.value);
                  break;
               case "hover_bitmap:hover_asset":
                  hoverAsset = String(_loc2_.value);
            }
         }
         if(_bitmap != null)
         {
            _bitmap.properties = param1;
            _bitmap.invalidate();
         }
      }
      
      public function get normalAsset() : String
      {
         return _normalAsset;
      }
      
      public function set normalAsset(param1:String) : void
      {
         _normalAsset = param1;
         if(!var_2558)
         {
            _bitmap.assetUri = _normalAsset;
         }
      }
      
      public function get hoverAsset() : String
      {
         return _hoverAsset;
      }
      
      public function set hoverAsset(param1:String) : void
      {
         _hoverAsset = param1;
         if(var_2558)
         {
            _bitmap.assetUri = _hoverAsset;
         }
      }
      
      public function get bitmapWrapper() : IStaticBitmapWrapperWindow
      {
         return _bitmap;
      }
   }
}

