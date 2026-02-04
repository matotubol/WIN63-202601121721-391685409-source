package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2060;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TableView implements class_13
   {
      
      private static var SKIP_SCROLL_RESIZE:int = 500;
      
      private static var LAZY_CHUNKING:int = 30;
      
      private static var LAZY_CHUNKING_MINIMAL:int = 8;
      
      private static var SCROLL_BUFFER:int = 24;
      
      private static var SCROLL_BUFFER_MINIMAL:int = 2;
      
      private static var TABLE_MARGIN:int = 5;
      
      private static var SCROLLBAR_OFFSET:int = 21;
      
      private var var_3190:Vector.<TableRowView>;
      
      private var _disposed:Boolean;
      
      private var var_704:Boolean;
      
      private var _parent:class_1812;
      
      private var _container:class_1812;
      
      private var var_733:IItemListWindow;
      
      private var var_1325:class_2060;
      
      private var var_2438:ITextWindow;
      
      private var var_1230:IItemListWindow;
      
      private var var_4029:CellTemplate;
      
      private var var_517:Vector.<TableColumn>;
      
      private var _rowModels:Vector.<TableRowModel>;
      
      private var var_1595:Dictionary;
      
      private var _canSelect:Boolean;
      
      private var _onRowClickedCallback:Function = null;
      
      private var _onRowSelectedCallback:Function = null;
      
      private var _onRowHoverCallback:Function = null;
      
      private var _onCellEditCallback:Function = null;
      
      private var var_3543:Boolean = true;
      
      private var var_3321:Boolean = false;
      
      private var var_361:TableRowModel = null;
      
      private var var_438:TableRowModel = null;
      
      private var _ignoreListeners:Boolean = false;
      
      private var var_2422:DeBouncer;
      
      private var _forceUpdate:Boolean = false;
      
      private var var_3746:Boolean = false;
      
      private var _needScrollReset:Boolean = false;
      
      public function TableView(param1:class_38, param2:class_1812, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _parent = param2;
         var_2422 = new DeBouncer(150,300,manageRowViews);
         var_3746 = param4;
         _container = param1.buildFromXML(param1.assets.getAssetByName("table_view_xml").content as XML) as class_1812;
         param2.addChild(_container);
         var_733 = _container.findChildByName("table_titlerow") as IItemListWindow;
         var_1325 = _container.findChildByName("splitter") as class_2060;
         tableContents.removeListItem(var_733);
         tableContents.removeListItem(var_1325);
         var_2438 = var_733.removeListItemAt(0) as ITextWindow;
         var_1230 = tableItems.removeListItemAt(1) as IItemListWindow;
         var_4029 = new CellTemplate(var_1230.removeListItemAt(0) as IRegionWindow);
         _container.width = param2.width;
         _container.height = param2.height;
         updateTableItemsHeight();
         resizeHorizontally();
         updateEmptyText();
         if(param3)
         {
            _container.setParamFlag(2048,true);
         }
         tableContents.addEventListener("WE_RESIZED",onTableContentsResized);
         tableItems.findChildByTag("_ITEMLIST").addEventListener("WE_SCROLL",onScrolled);
      }
      
      public function initialize(param1:Vector.<TableColumn>, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(var_704)
         {
            return;
         }
         _canSelect = param3;
         var_3190 = new Vector.<TableRowView>();
         _rowModels = new Vector.<TableRowModel>();
         var_1595 = new Dictionary();
         var_3543 = param2;
         if(param2)
         {
            tableContents.addListItemAt(var_733,0);
            tableContents.addListItemAt(var_1325,1);
         }
         else
         {
            updateTableItemsHeight();
            updateEmptyText();
         }
         initializeColumns(param1);
         var_704 = true;
      }
      
      private function updateTableItemsHeight() : void
      {
         tableItems.height = tableContents.height - (var_3543 ? var_733.height + var_1325.height : 0);
         onScrollBarVisibilityMayHaveChanged();
      }
      
      private function updateEmptyText() : void
      {
         if(var_3543)
         {
            emptyTextContainer.y = var_733.height + var_1325.height;
            emptyTextContainer.height = tableContents.height - emptyTextContainer.y;
         }
         else
         {
            emptyTextContainer.y = 0;
            emptyTextContainer.height = tableContents.height;
         }
         emptyTextContainer.visible = _rowModels == null || _rowModels.length == 0;
      }
      
      private function onTableContentsResized(param1:class_1758) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         updateTableItemsHeight();
         manageRowViewsWithDebounce();
      }
      
      private function onScrolled(param1:class_1758) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         manageRowViewsWithDebounce();
      }
      
      private function initializeColumns(param1:Vector.<TableColumn>) : void
      {
         var_517 = param1;
         for each(var _loc4_ in param1)
         {
            var _loc3_:ITextWindow = var_2438.clone() as ITextWindow;
            null.text = _loc4_.columnName;
            var _loc2_:int = getCellWidth(_loc4_.id);
            null.width = 0;
            null.autoSize = _loc4_.alignment;
            var_733.addListItem(null);
         }
      }
      
      public function setObjects(param1:Vector.<ITableObject>, param2:Boolean = false) : void
      {
         if(!var_704)
         {
            return;
         }
         if(param1.length == 0)
         {
            clear();
            return;
         }
         _ignoreListeners = true;
         var _loc7_:int = int(_rowModels.length);
         var _loc8_:Boolean = false;
         var _loc11_:Dictionary = new Dictionary();
         var _loc3_:Vector.<TableRowModel> = new Vector.<TableRowModel>();
         for each(var _loc13_ in param1)
         {
            var _loc9_:TableRowModel = getRowForObject(null);
            if(_loc9_ != null)
            {
               null.update(null);
               _loc11_[null] = true;
               _loc3_.push(null);
            }
            else
            {
               _loc3_.push(null);
            }
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         for each(var _loc10_ in _rowModels)
         {
            if(!(_loc10_ in _loc11_))
            {
               if(var_361 == _loc10_)
               {
                  var_361 = null;
                  _loc4_ = true;
               }
               if(var_438 == _loc10_)
               {
                  var_438 = null;
                  _loc5_ = true;
               }
               if(_loc10_.view != null)
               {
                  recycleRowView(_loc10_.view);
                  _loc10_.view = null;
                  _forceUpdate = true;
               }
               _loc8_ = true;
               _loc10_.dispose();
            }
         }
         var_1595 = new Dictionary();
         var _loc6_:int = 0;
         while(0 < param1.length)
         {
            _loc13_ = param1[0];
            var _loc12_:TableRowModel = _loc3_[0];
            if(_loc12_ == null)
            {
               _loc12_ = new TableRowModel(null,0);
               _loc3_[0] = null;
               _loc8_ = true;
            }
            var_1595[null.identifier] = null;
            if(null.i != 0)
            {
               _loc8_ = true;
            }
            _loc6_ = 0 + 1;
         }
         _rowModels = _loc3_;
         _ignoreListeners = false;
         _needScrollReset ||= param2;
         if(_loc8_)
         {
            _loc6_ = 0;
            while(0 < _rowModels.length)
            {
               _rowModels[0].index = 0;
               _loc6_ = 0 + 1;
            }
         }
         if(_loc8_ || _needScrollReset)
         {
            manageRowViewsWithDebounce();
         }
         if(_loc7_ != _rowModels.length)
         {
            itemListAmountChanged();
         }
         if(_loc4_ && _onRowSelectedCallback != null)
         {
            _onRowSelectedCallback(null);
         }
         if(_loc5_ && _onRowHoverCallback != null)
         {
            _onRowHoverCallback(null);
         }
      }
      
      public function manageRowViewsWithDebounce() : void
      {
         if(manageRowViews(true))
         {
            var_2422.trigger();
         }
      }
      
      private function manageRowViews(param1:Boolean = false) : Boolean
      {
         var _loc10_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!param1 && _needScrollReset)
         {
            tableItems.scrollV = 0;
            _needScrollReset = false;
            _forceUpdate = true;
         }
         var _loc9_:class_1741 = tableItems.getListItemAt(0);
         var _loc5_:class_1741 = tableItems.getListItemAt(tableItems.numListItems - 1);
         var _loc7_:int = visibleRangeFirstIndex;
         var _loc13_:int = visibleRangeLastIndex;
         var _loc15_:int = int(var_1230.height);
         var _loc8_:Vector.<class_1741> = new Vector.<class_1741>();
         _loc8_.push(_loc9_);
         var _loc2_:int = _loc7_ * _loc15_;
         var _loc6_:int = Math.max(0,_rowModels.length - 1 - _loc13_) * _loc15_;
         var _loc3_:Boolean = _forceUpdate || _rowModels.length < SKIP_SCROLL_RESIZE && (_loc2_ != _loc9_.height || _loc6_ != _loc5_.height);
         if(_loc3_ && param1)
         {
            return true;
         }
         for each(var _loc14_ in _rowModels)
         {
            if(shouldBeVisible(_loc14_,_loc7_,_loc13_))
            {
               if(_loc14_.view == null)
               {
                  if(!param1)
                  {
                     _loc14_.view = createOrReuseTableRowView(_loc14_);
                  }
                  _loc3_ = true;
               }
               if(!param1)
               {
                  _loc8_.push(_loc14_.view.container);
               }
            }
            else if(_loc14_.view != null)
            {
               if(!param1)
               {
                  recycleRowView(_loc14_.view);
                  _loc14_.view = null;
               }
               _loc3_ = true;
            }
         }
         if(param1)
         {
            return _loc3_ || _needScrollReset;
         }
         _loc8_.push(_loc5_);
         _forceUpdate = false;
         _ignoreListeners = true;
         if(_loc3_)
         {
            tableItems.autoArrangeItems = false;
            _loc10_ = Number(tableItems.scrollableRegion.height);
            _loc4_ = Number(tableItems.visibleRegion.y);
            _loc11_ = Number(tableItems.scrollV);
            tableItems.removeListItems();
            _loc9_.height = _loc2_;
            _loc5_.height = _loc6_;
            var _loc12_:int = 0;
            for each(var _loc16_ in _loc8_)
            {
               _loc16_.y = 0;
               tableItems.addListItem(_loc16_);
               _loc12_ = 0 + _loc16_.height;
            }
            if(0 != _loc10_)
            {
               if(0 > tableItems.height)
               {
                  tableItems.scrollV = _loc4_ / (0 - tableItems.height);
               }
               else
               {
                  _loc5_.height += tableItems.height - 0;
                  _loc5_.width = rowWidth;
                  tableItems.scrollV = 0;
               }
            }
            else
            {
               tableItems.scrollV = _loc11_;
            }
            tableItems.autoArrangeItems = true;
            onScrollBarVisibilityMayHaveChanged();
         }
         _ignoreListeners = false;
         return _loc3_;
      }
      
      public function scrollToTop() : void
      {
         tableItems.scrollV = 0;
      }
      
      private function shouldBeVisible(param1:TableRowModel, param2:int, param3:int) : Boolean
      {
         return param1.i >= param2 && param1.i <= param3;
      }
      
      private function get visibleRangeFirstIndex() : int
      {
         var _loc5_:int = int(var_1230.height);
         var _loc3_:Rectangle = tableItems.visibleRegion;
         var _loc2_:int = _loc3_.y;
         var _loc4_:int = _loc2_ / _loc5_;
         var _loc1_:int = Math.min(_loc4_ - 1,_rowModels.length - tableItems.height / _loc5_);
         _loc1_ -= scrollBuffer + _loc1_ % lazyChunking;
         return Math.max(0,_loc1_);
      }
      
      private function get visibleRangeLastIndex() : int
      {
         var _loc5_:int = int(var_1230.height);
         var _loc4_:Rectangle = tableItems.visibleRegion;
         var _loc3_:int = _loc4_.y + _loc4_.height;
         var _loc2_:int = _loc3_ / _loc5_;
         var _loc1_:int = Math.min(_loc2_ + 1,_rowModels.length - 1);
         return int(_loc1_ + (scrollBuffer + lazyChunking - _loc1_ % lazyChunking));
      }
      
      private function get lazyChunking() : int
      {
         return var_3746 ? LAZY_CHUNKING_MINIMAL : LAZY_CHUNKING;
      }
      
      private function get scrollBuffer() : int
      {
         return var_3746 ? SCROLL_BUFFER : SCROLL_BUFFER_MINIMAL;
      }
      
      public function clear() : void
      {
         if(!var_704)
         {
            return;
         }
         _ignoreListeners = true;
         var _loc2_:class_1741 = tableItems.getListItemAt(0);
         var _loc3_:class_1741 = tableItems.getListItemAt(tableItems.numListItems - 1);
         tableItems.removeListItems();
         _loc2_.height = 0;
         _loc3_.height = tableItems.height;
         tableItems.addListItem(_loc2_);
         tableItems.addListItem(_loc3_);
         _ignoreListeners = false;
         for each(var _loc1_ in _rowModels)
         {
            if(_loc1_.view != null)
            {
               recycleRowView(_loc1_.view);
               _loc1_.view = null;
            }
            _loc1_.dispose();
         }
         _rowModels = new Vector.<TableRowModel>();
         var_1595 = new Dictionary();
         if(var_361 != null)
         {
            var_361 = null;
            if(_onRowSelectedCallback != null)
            {
               _onRowSelectedCallback(null);
            }
         }
         if(var_438 != null)
         {
            var_438 = null;
            if(_onRowHoverCallback != null)
            {
               _onRowHoverCallback(null);
            }
         }
         itemListAmountChanged();
      }
      
      public function resetScrollingNextUpdate() : void
      {
         _needScrollReset = true;
      }
      
      private function recycleRowView(param1:TableRowView) : void
      {
         param1.recycle();
         var_3190.push(param1);
      }
      
      private function createOrReuseTableRowView(param1:TableRowModel) : TableRowView
      {
         var _loc2_:TableRowView = null;
         if(var_3190.length > 0)
         {
            _loc2_ = var_3190.pop();
            _loc2_.reuse(param1);
            _loc2_.updateWidth();
         }
         else
         {
            _loc2_ = new TableRowView(this,param1);
         }
         return _loc2_;
      }
      
      private function itemListAmountChanged() : void
      {
         onScrollBarVisibilityMayHaveChanged();
         updateEmptyText();
      }
      
      private function onScrollBarVisibilityMayHaveChanged() : void
      {
         var _loc1_:Boolean = var_3321;
         var_3321 = tableItems.isScrollBarVisible;
         if(_loc1_ != var_3321)
         {
            resizeHorizontally();
         }
      }
      
      public function resizeHorizontally() : void
      {
         var _loc3_:int = 0;
         var _loc4_:ITextWindow = null;
         _container.width = _parent.width;
         var_733.width = rowWidth;
         var_1325.width = rowWidth;
         var _loc2_:int = var_733.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = var_733.getListItemAt(_loc3_) as ITextWindow;
            _loc4_.width = getCellWidth(var_517[_loc3_].id);
            _loc3_++;
         }
         for each(var _loc1_ in _rowModels)
         {
            if(_loc1_.view != null)
            {
               _loc1_.view.updateWidth();
            }
         }
      }
      
      public function getColumnById(param1:String) : TableColumn
      {
         for each(var _loc2_ in var_517)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getRowForObject(param1:ITableObject) : TableRowModel
      {
         return var_1595[param1.identifier];
      }
      
      public function getIndexOfObject(param1:ITableObject) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc2_:TableRowModel = getRowForObject(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.i;
      }
      
      public function getObjectByIndex(param1:int) : ITableObject
      {
         if(param1 < 0 || param1 >= _rowModels.length)
         {
            return null;
         }
         return _rowModels[param1].object;
      }
      
      public function trySelect(param1:ITableObject, param2:Boolean = false) : void
      {
         var _loc4_:TableRowModel = null;
         if(_onRowClickedCallback && param2)
         {
            _onRowClickedCallback(param1);
         }
         if(!_canSelect)
         {
            return;
         }
         if(var_361 != null && param1 != null && var_361.object == param1)
         {
            return;
         }
         if(var_361 != null)
         {
            var_361.selected = false;
            var_361 = null;
            var _loc3_:Boolean = true;
         }
         if(param1 != null)
         {
            _loc4_ = getRowForObject(param1);
            if(_loc4_ != null)
            {
               _loc4_.selected = true;
               var_361 = _loc4_;
               _loc3_ = true;
            }
         }
      }
      
      internal function onHover(param1:ITableObject) : void
      {
         var _loc3_:TableRowModel = null;
         if(var_438 != null && param1 != null && var_438.object == param1)
         {
            return;
         }
         if(var_438 != null)
         {
            var_438.hovered = false;
            var_438 = null;
            var _loc2_:Boolean = true;
         }
         if(param1 != null)
         {
            _loc3_ = getRowForObject(param1);
            if(_loc3_ != null)
            {
               _loc3_.hovered = true;
               var_438 = _loc3_;
               _loc2_ = true;
            }
         }
      }
      
      public function getGlobalRowRectangle(param1:ITableObject) : Rectangle
      {
         var _loc3_:TableRowModel = getRowForObject(param1);
         if(_loc3_ == null || _loc3_.view == null)
         {
            return null;
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc3_.view.container.getGlobalRectangle(_loc2_);
         return _loc2_;
      }
      
      public function get selected() : ITableObject
      {
         if(var_361 == null)
         {
            return null;
         }
         return var_361.object;
      }
      
      public function get size() : int
      {
         return _rowModels.length;
      }
      
      internal function onEnterNewCellValue(param1:String, param2:ITableObject, param3:String) : void
      {
         if(_onCellEditCallback != null)
         {
            _onCellEditCallback(param2,param3,param1);
         }
      }
      
      public function get rowWidth() : int
      {
         return tableContents.width - (var_3321 ? SCROLLBAR_OFFSET : 0);
      }
      
      public function getCellWidth(param1:String) : int
      {
         return rowWidth * getColumnById(param1).widthFactor;
      }
      
      public function get columns() : Vector.<TableColumn>
      {
         return var_517;
      }
      
      public function get rowTemplate() : IItemListWindow
      {
         return var_1230;
      }
      
      public function get cellTemplate() : CellTemplate
      {
         return var_4029;
      }
      
      public function set onRowSelectedCallback(param1:Function) : void
      {
         _onRowSelectedCallback = param1;
      }
      
      public function set onRowClickedCallback(param1:Function) : void
      {
         _onRowClickedCallback = param1;
      }
      
      public function set onRowHoveredCallback(param1:Function) : void
      {
         _onRowHoverCallback = param1;
      }
      
      public function set onCellEditCallback(param1:Function) : void
      {
         _onCellEditCallback = param1;
      }
      
      public function get rowCount() : int
      {
         return _rowModels.length;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_2422.dispose();
         var_2422 = null;
         clear();
         _container.dispose();
         _parent = null;
         var_733 = null;
         var_1325 = null;
         var_2438.dispose();
         var_2438 = null;
         var_1230.dispose();
         var_1230 = null;
         var_517 = null;
         _onRowHoverCallback = null;
         _onRowSelectedCallback = null;
         _onRowClickedCallback = null;
         _onCellEditCallback = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get border() : class_1993
      {
         return _container.findChildByName("table_border") as class_1993;
      }
      
      private function get tableContents() : IItemListWindow
      {
         return _container.findChildByName("table_contents") as IItemListWindow;
      }
      
      private function get tableItems() : IScrollableListWindow
      {
         return _container.findChildByName("table_items") as IScrollableListWindow;
      }
      
      private function get emptyTextContainer() : class_1812
      {
         return _container.findChildByName("empty_container") as class_1812;
      }
   }
}

