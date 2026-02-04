package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.class_2557;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class BundleGridViewCatalogWidget extends CatalogWidget implements class_2612, IItemGrid, class_2557
   {
      
      private var _offer:class_1793;
      
      private var _gridItemLayout:XML;
      
      private var _itemGrid:IItemGridWindow;
      
      public function BundleGridViewCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         _itemGrid = IItemGridWindow(_window.findChildByName("bundleGrid"));
         return true;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
            super.dispose();
         }
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc2_:class_1793 = null;
         if(page.offers.length == 1)
         {
            _loc2_ = page.offers[0];
            if(_loc2_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc2_));
            }
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         _offer = param1.offer;
         _itemGrid.destroyGridItems();
         populateItemGrid();
      }
      
      protected function populateItemGrid() : void
      {
         var _loc5_:class_1812 = null;
         var _loc1_:class_1741 = null;
         var _loc4_:BitmapData = null;
         var _loc2_:class_1812 = _offer.page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as class_1812;
         for each(var _loc3_ in _offer.productContainer.products)
         {
            if(_loc3_.productType != "b")
            {
               _loc5_ = _loc2_.clone() as class_1812;
               _loc1_ = _loc5_.findChildByName("clubLevelIcon");
               if(_loc1_ != null)
               {
                  _loc1_.visible = false;
               }
               _itemGrid.addGridItem(_loc5_);
               _loc3_.view = _loc5_;
               _loc4_ = _loc3_.initIcon(this);
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc3_.grid = this;
            }
         }
      }
      
      public function get offer() : class_1793
      {
         return _offer;
      }
      
      public function select(param1:class_2253, param2:Boolean) : void
      {
      }
      
      public function startDragAndDrop(param1:class_2253) : Boolean
      {
         return false;
      }
      
      public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function get products() : Vector.<class_1857>
      {
         return null;
      }
      
      public function get firstProduct() : class_1857
      {
         return null;
      }
      
      public function set view(param1:class_1812) : void
      {
      }
      
      public function get view() : class_1812
      {
         return null;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
      }
      
      public function setClubIconLevel(param1:int) : void
      {
      }
   }
}

