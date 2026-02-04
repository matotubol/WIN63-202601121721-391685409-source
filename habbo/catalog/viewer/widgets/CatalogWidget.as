package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public class CatalogWidget implements class_2612
   {
      
      protected var _window:class_1812;
      
      protected var name_1:IEventDispatcher;
      
      private var var_215:class_2044;
      
      private var var_1134:Boolean;
      
      protected var _isEmbedded:Boolean = false;
      
      public function CatalogWidget(param1:class_1812)
      {
         super();
         _window = param1;
         _isEmbedded = param1.tags.indexOf("EMBEDDED") > -1;
      }
      
      public function set page(param1:class_2044) : void
      {
         var_215 = param1;
      }
      
      public function set events(param1:IEventDispatcher) : void
      {
         name_1 = param1;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function get page() : class_2044
      {
         return var_215;
      }
      
      public function dispose() : void
      {
         name_1 = null;
         var_215 = null;
         _window = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function init() : Boolean
      {
         return true;
      }
      
      public function closed() : void
      {
      }
      
      protected function getAssetXML(param1:String) : XML
      {
         if(!page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      protected function attachWidgetView(param1:String) : void
      {
         if(_isEmbedded)
         {
            return;
         }
         var _loc2_:XML = getAssetXML(param1);
         if(_loc2_ == null)
         {
            return;
         }
         window.removeChildAt(0);
         if(!window || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         window.addChild(page.viewer.catalog.windowManager.buildFromXML(_loc2_));
      }
      
      protected function getAssetBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as BitmapData;
      }
   }
}

