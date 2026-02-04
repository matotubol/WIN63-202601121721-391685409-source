package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.class_13;
   
   public class TableRowModel implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var var_612:ITableObject;
      
      private var var_2138:int;
      
      private var _selected:Boolean = false;
      
      private var var_1919:Boolean = false;
      
      private var _hasFocus:Boolean = false;
      
      private var var_18:TableRowView;
      
      public function TableRowModel(param1:ITableObject, param2:int)
      {
         super();
         var_612 = param1;
         var_2138 = param2;
      }
      
      public function set index(param1:int) : void
      {
         var_2138 = param1;
         if(var_18 != null)
         {
            var_18.indexUpdated();
         }
      }
      
      public function update(param1:ITableObject) : void
      {
         if(!param1.isUpdated(var_612))
         {
            var_612 = param1;
            return;
         }
         var _loc2_:ITableObject = var_612;
         var_612 = param1;
         if(var_18 != null)
         {
            var_18.objectUpdated(_loc2_,param1);
         }
      }
      
      public function set hasFocus(param1:Boolean) : void
      {
         _hasFocus = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(var_18 != null)
         {
            var_18.selectedUpdated();
         }
      }
      
      public function set hovered(param1:Boolean) : void
      {
         var_1919 = param1;
         if(var_18 != null)
         {
            var_18.hovereddUpdated();
         }
      }
      
      public function set view(param1:TableRowView) : void
      {
         var_18 = param1;
      }
      
      public function get object() : ITableObject
      {
         return var_612;
      }
      
      public function get i() : int
      {
         return var_2138;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get hovered() : Boolean
      {
         return var_1919;
      }
      
      public function get hasFocus() : Boolean
      {
         return _hasFocus;
      }
      
      public function get view() : TableRowView
      {
         return var_18;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_612 = null;
         var_2138 = 0;
         _selected = false;
         var_1919 = false;
         _hasFocus = false;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

