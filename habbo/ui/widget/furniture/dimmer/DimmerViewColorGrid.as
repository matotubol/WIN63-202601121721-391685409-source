package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class DimmerViewColorGrid
   {
      
      private var var_1008:IItemGridWindow;
      
      private var var_18:DimmerView;
      
      private var _colorCellXML:XML;
      
      private var _colorCellFrame:BitmapData;
      
      private var var_1838:BitmapData;
      
      private var var_1784:BitmapData;
      
      private var var_488:class_1812;
      
      public function DimmerViewColorGrid(param1:DimmerView, param2:IItemGridWindow, param3:class_38, param4:class_40)
      {
         super();
         var_18 = param1;
         var_1008 = param2;
         storeAssets(param4);
         populate(param3);
      }
      
      public function dispose() : void
      {
         var_18 = null;
         var_1008 = null;
         _colorCellXML = null;
         _colorCellFrame = null;
         var_1838 = null;
         var_1784 = null;
      }
      
      public function setSelectedColorIndex(param1:int) : void
      {
         if(var_1008 == null)
         {
            return;
         }
         if(param1 < 0 || param1 >= var_1008.numGridItems)
         {
            return;
         }
         select(var_1008.getGridItemAt(param1) as class_1812);
      }
      
      private function populate(param1:class_38) : void
      {
         if(var_18 == null || var_1008 == null)
         {
            return;
         }
         populateColourGrid(param1);
      }
      
      private function select(param1:class_1812) : void
      {
         var _loc2_:class_1741 = null;
         if(var_488 != null)
         {
            _loc2_ = var_488.getChildByName("chosen");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         var_488 = param1;
         _loc2_ = var_488.getChildByName("chosen");
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function populateColourGrid(param1:class_38) : void
      {
         var _loc7_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:Number = NaN;
         var_1008.destroyGridItems();
         var_488 = null;
         for each(var _loc10_ in colors)
         {
            var _loc4_:class_1812 = param1.buildFromXML(_colorCellXML) as class_1812;
            _loc4_.addEventListener("WME_CLICK",onClick);
            null.background = true;
            null.color = 4294967295;
            null.width = _colorCellFrame.width;
            null.height = _colorCellFrame.height;
            var_1008.addGridItem(null);
            var _loc8_:class_2251 = null.findChildByTag("BG_BORDER") as class_2251;
            if(_loc8_ != null)
            {
               null.bitmap = new BitmapData(_colorCellFrame.width,_colorCellFrame.height,true,0);
               null.bitmap.copyPixels(_colorCellFrame,_colorCellFrame.rect,new Point(0,0));
            }
            var _loc14_:class_2251 = null.findChildByTag("COLOR_IMAGE") as class_2251;
            if(_loc14_ != null)
            {
               null.bitmap = new BitmapData(var_1838.width,var_1838.height,true,0);
               var _loc11_:uint = uint(_loc10_ >> 16 & 0xFF);
               var _loc3_:uint = uint(_loc10_ >> 8 & 0xFF);
               var _loc2_:uint = uint(_loc10_ >> 0 & 0xFF);
               _loc7_ = 0 / 255 * 1;
               _loc12_ = 0 / 255 * 1;
               _loc5_ = 0 / 255 * 1;
               var _loc13_:ColorTransform = new ColorTransform(_loc7_,_loc12_,_loc5_);
               var _loc6_:BitmapData = var_1838.clone();
               _loc6_.colorTransform(_loc6_.rect,null);
               null.bitmap.copyPixels(null,null.rect,new Point(0,0));
            }
            var _loc9_:class_2251 = null.findChildByTag("COLOR_CHOSEN") as class_2251;
            if(_loc9_ != null)
            {
               null.bitmap = new BitmapData(var_1784.width,var_1784.height,true,16777215);
               null.bitmap.copyPixels(var_1784,var_1784.rect,new Point(0,0),null,null,true);
               null.visible = false;
            }
         }
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = var_1008.getGridItemIndex(param1.target as class_1741);
         setSelectedColorIndex(_loc2_);
         var_18.selectedColorIndex = _loc2_;
      }
      
      private function storeAssets(param1:class_40) : void
      {
         var _loc2_:XmlAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = XmlAsset(param1.getAssetByName("dimmer_color_chooser_cell"));
         _colorCellXML = XML(_loc2_.content);
         var _loc3_:BitmapDataAsset = BitmapDataAsset(param1.getAssetByName("dimmer_color_frame"));
         _colorCellFrame = BitmapData(null.content);
         _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_button"));
         var_1838 = BitmapData(null.content);
         _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_selected"));
         var_1784 = BitmapData(null.content);
      }
      
      private function get colors() : Array
      {
         if(var_18 == null)
         {
            return [];
         }
         return var_18.colors;
      }
   }
}

