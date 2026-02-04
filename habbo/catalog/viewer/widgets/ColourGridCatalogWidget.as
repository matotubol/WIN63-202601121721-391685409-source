package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class ColourGridCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _colours:Array;
      
      private var _colourGrid:IItemGridWindow;
      
      private var _colourChooserLayout:XML;
      
      private var var_1172:BitmapData;
      
      private var var_1748:BitmapData;
      
      private var _colourChosen:BitmapData;
      
      private var var_488:class_1812;
      
      private var var_4030:String = "";
      
      private var _colourGridCache:Dictionary = new Dictionary();
      
      public function ColourGridCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(!_colourGrid.disposed)
         {
            _colourGrid.destroyGridItems();
            _colourGrid.dispose();
         }
         _colourGrid = null;
         _colourChooserLayout = null;
         var_488 = null;
         events.removeEventListener("COLOUR_ARRAY",onAvailableColours);
         events.removeEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("colourGridWidget");
         var _loc2_:* = _window.tags.indexOf("FIXED") > -1;
         if(!_loc2_)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         _colourGrid = _window.findChildByName("colourGrid") as IItemGridWindow;
         _colourGrid.width = window.width - 6;
         _colourGrid.height = window.height - 6;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("color_chooser_cell") as XmlAsset;
         _colourChooserLayout = _loc1_.content as XML;
         events.addEventListener("COLOUR_ARRAY",onAvailableColours);
         events.addEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         return true;
      }
      
      private function onAvailableColours(param1:CatalogWidgetColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push([_loc4_]);
         }
         var _loc5_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset;
         var_1172 = _loc5_.content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         var_1748 = _loc3_.content as BitmapData;
         var_4030 = param1.backgroundAssetName + "\t" + param1.colourAssetName;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(param1.index) as class_1812);
      }
      
      private function onAvailableMultiColours(param1:CatalogWidgetMultiColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push(_loc4_.slice());
         }
         var _loc5_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset;
         var_1172 = _loc5_.content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         var_1748 = _loc3_.content as BitmapData;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(0) as class_1812);
      }
      
      private function select(param1:class_1812) : void
      {
         var _loc2_:class_1741 = null;
         class_21.log("[ColourGridCatalogWidget] Select: " + param1);
         if(var_488 != null)
         {
            _loc2_ = var_488.getChildByName("chosen");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         var_488 = param1;
         if(var_488 != null)
         {
            _loc2_ = var_488.getChildByName("chosen");
         }
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function populateColourGrid() : void
      {
         class_21.log("[ColourGridCatalogWidget] Display colors: " + [_colours.length,_colourGrid.numGridItems]);
         _colourGrid.removeGridItems();
         var_488 = null;
         var _loc2_:int = 0;
         while(0 < _colours.length)
         {
            var _loc4_:Array = _colours[0];
            if(_loc4_.length > 0)
            {
               var _loc3_:class_1812 = createColorContainer(null,0);
               _colourGrid.addGridItem(null);
               var _loc1_:class_2251 = null.findChildByTag("COLOR_CHOSEN") as class_2251;
            }
            _loc2_++;
         }
      }
      
      private function createColorContainer(param1:Array, param2:int) : class_1812
      {
         var _loc10_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:String = coloursCacheKey(param1,param2);
         var _loc6_:class_1812 = _colourGridCache[_loc12_];
         if(_loc6_ != null)
         {
            return _loc6_;
         }
         _loc6_ = page.viewer.catalog.windowManager.buildFromXML(_colourChooserLayout) as class_1812;
         _loc6_.addEventListener("WME_CLICK",onClick);
         _loc6_.background = true;
         _loc6_.color = 4294967295;
         _loc6_.width = var_1172.width;
         _loc6_.height = var_1172.height;
         var _loc9_:class_2251 = _loc6_.findChildByTag("BG_BORDER") as class_2251;
         if(_loc9_ != null)
         {
            _loc9_.bitmap = new BitmapData(var_1172.width,var_1172.height,true,0);
            _loc9_.bitmap.copyPixels(var_1172,var_1172.rect,new Point(0,0));
         }
         var _loc14_:class_2251 = _loc6_.findChildByTag("COLOR_IMAGE") as class_2251;
         if(_loc14_ != null)
         {
            _loc14_.bitmap = new BitmapData(var_1748.width,var_1748.height,true,0);
            _loc10_ = 255;
            _loc4_ = 255;
            _loc3_ = 255;
            _loc7_ = null;
            _loc5_ = null;
            _loc11_ = int(param1[0]);
            if(_loc11_ >= 0)
            {
               _loc10_ = uint(_loc11_ >> 16 & 0xFF);
               _loc4_ = uint(_loc11_ >> 8 & 0xFF);
               _loc3_ = uint(_loc11_ >> 0 & 0xFF);
            }
            _loc7_ = var_1748.clone();
            _loc7_.colorTransform(_loc7_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            if(param1.length > 1)
            {
               _loc8_ = int(param1[1]);
               if(_loc8_ >= 0)
               {
                  _loc10_ = uint(_loc8_ >> 16 & 0xFF);
                  _loc4_ = uint(_loc8_ >> 8 & 0xFF);
                  _loc3_ = uint(_loc8_ >> 0 & 0xFF);
               }
               _loc5_ = var_1748.clone();
               _loc5_.colorTransform(_loc5_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            }
            _loc14_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            _loc7_.dispose();
            if(_loc5_ != null)
            {
               _loc13_ = _loc5_.width / 2;
               _loc14_.bitmap.copyPixels(_loc5_,new Rectangle(_loc13_,0,_loc5_.width - _loc13_,_loc5_.height),new Point(_loc5_.width / 2,0));
               _loc5_.dispose();
            }
         }
         _colourGridCache[_loc12_] = _loc6_;
         return _loc6_;
      }
      
      private function coloursCacheKey(param1:Array, param2:int) : String
      {
         var _loc4_:String = var_4030;
         _loc4_ = _loc4_ + "\t";
         _loc4_ = _loc4_ + param2;
         for each(var _loc3_ in param1)
         {
            _loc4_ += "\t";
            _loc4_ = _loc4_ + _loc3_;
         }
         return _loc4_;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         select(param1.target as class_1812);
         var _loc2_:int = _colourGrid.getGridItemIndex(param1.target as class_1741);
         events.dispatchEvent(new CatalogWidgetColourIndexEvent(_loc2_));
      }
   }
}

