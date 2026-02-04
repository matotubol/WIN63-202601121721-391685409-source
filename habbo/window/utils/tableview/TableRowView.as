package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.class_1897;
   
   public class TableRowView implements class_13
   {
      
      private static var var_5290:uint = 12116732;
      
      private static var var_5300:uint = 13750737;
      
      private static var var_5331:uint = 15395562;
      
      private static var var_5357:uint = 16382457;
      
      private var _disposed:Boolean = false;
      
      private var var_647:TableView;
      
      private var _container:IItemListWindow;
      
      private var var_1245:Vector.<TableCellView>;
      
      private var var_36:TableRowModel;
      
      public function TableRowView(param1:TableView, param2:TableRowModel)
      {
         super();
         var_647 = param1;
         var_36 = param2;
         _container = param1.rowTemplate.clone() as IItemListWindow;
         var_1245 = new Vector.<TableCellView>();
         updateWidth();
         for each(var _loc4_ in param1.columns)
         {
            var _loc5_:TableCell = object.getTableCell(_loc4_.id);
            var _loc3_:TableCellView = new TableCellView(param1,this,_loc4_.id,null);
            var_1245.push(null);
            _container.addListItem(null.container);
         }
         updateColor();
         _container.addEventListener("WME_DOWN",onDown);
         _container.addEventListener("WME_OVER",onHoverOver);
         _container.addEventListener("WME_OUT",onHoverOut);
         _container.addEventListener("WME_CLICK_AWAY",onClickAway);
      }
      
      private static function windowIsChild(param1:class_1741, param2:class_1741) : Boolean
      {
         var _loc3_:class_1812 = null;
         var _loc4_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         if(param1 is class_1812 || param1 is IItemListWindow || param1 is ISelectorWindow)
         {
            if(param1 is class_1897)
            {
               for each(var _loc5_ in (param1 as class_1897).children)
               {
                  if(windowIsChild(_loc5_,param2))
                  {
                     return true;
                  }
               }
            }
            else if(param1 is class_1812)
            {
               _loc3_ = param1 as class_1812;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.numChildren)
               {
                  if(windowIsChild(_loc3_.getChildAt(_loc4_),param2))
                  {
                     return true;
                  }
                  _loc4_++;
               }
            }
         }
         return false;
      }
      
      public function indexUpdated() : void
      {
         updateColor();
      }
      
      public function objectUpdated(param1:ITableObject, param2:ITableObject) : void
      {
         var _loc5_:int = 0;
         for each(var _loc4_ in var_647.columns)
         {
            if(param2.isPropertyUpdated(_loc4_.id,param1))
            {
               var _loc6_:TableCell = param2.getTableCell(_loc4_.id);
               var _loc3_:TableCellView = var_1245[_loc5_];
               null.update(null);
            }
            _loc5_ += 1;
         }
      }
      
      public function reuse(param1:TableRowModel) : void
      {
         var_36 = param1;
         var _loc4_:int = 0;
         for each(var _loc3_ in var_647.columns)
         {
            var _loc5_:TableCell = object.getTableCell(_loc3_.id);
            var _loc2_:TableCellView = var_1245[_loc4_];
            null.reuse(null);
            _loc4_ += 1;
         }
         updateColor();
      }
      
      public function updateWidth() : void
      {
         if(container.width == var_647.rowWidth)
         {
            return;
         }
         container.width = var_647.rowWidth;
         for each(var _loc1_ in var_1245)
         {
            _loc1_.updateWidth();
         }
      }
      
      private function updateColor() : void
      {
         var _loc1_:* = 0;
         if(var_36 == null)
         {
            return;
         }
         if(var_36.selected)
         {
            if(var_36.hasFocus)
            {
               _loc1_ = var_5290;
            }
            else
            {
               _loc1_ = var_5300;
            }
         }
         else
         {
            _loc1_ = var_36.i % 2 == 0 ? var_5331 : var_5357;
         }
         _container.color = 0xFF000000 ^ _loc1_;
      }
      
      internal function onDown(param1:WindowMouseEvent) : void
      {
         if(var_36 == null)
         {
            return;
         }
         var_36.hasFocus = true;
         var_647.trySelect(object,true);
         updateColor();
      }
      
      internal function onHoverOver(param1:WindowMouseEvent) : void
      {
         if(var_36 == null)
         {
            return;
         }
         if(!var_36.hovered)
         {
            var_647.onHover(object);
         }
      }
      
      internal function onHoverOut(param1:WindowMouseEvent) : void
      {
         if(var_36 == null)
         {
            return;
         }
         if(var_36.hovered)
         {
            var_647.onHover(null);
         }
      }
      
      internal function onClickAway(param1:WindowMouseEvent) : void
      {
         if(var_36 == null)
         {
            return;
         }
         var_36.hasFocus = windowIsChild(_container,param1.related);
         updateColor();
      }
      
      public function selectedUpdated() : void
      {
         updateColor();
      }
      
      public function hovereddUpdated() : void
      {
      }
      
      public function get object() : ITableObject
      {
         return var_36?.object;
      }
      
      public function get container() : IItemListWindow
      {
         return _container;
      }
      
      public function recycle() : void
      {
         for each(var _loc1_ in var_1245)
         {
            _loc1_.recycle();
         }
         var_36 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in var_1245)
         {
            _loc1_.dispose();
         }
         var_1245 = null;
         _container.dispose();
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

