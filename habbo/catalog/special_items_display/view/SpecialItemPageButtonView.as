package com.sulake.habbo.catalog.special_items_display.view
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsView;
   
   public class SpecialItemPageButtonView implements class_13
   {
      
      private var var_18:SpecialItemsView;
      
      private var _window:IRegionWindow;
      
      private var _index:int;
      
      private var var_2281:Boolean;
      
      private var _disposed:* = false;
      
      public function SpecialItemPageButtonView(param1:SpecialItemsView, param2:int)
      {
         super();
         _index = param2;
         var_18 = param1;
         _window = param1.pageTemplate.clone() as IRegionWindow;
         _window.addEventListener("WME_CLICK",onClick);
         selected = false;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var_18.navigateTo(_index);
      }
      
      public function set selected(param1:Boolean) : void
      {
         var_2281 = param1;
         pageImage.assetUri = "progress_disk_etched_" + (var_2281 ? "on" : "off");
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window.dispose();
         _window = null;
         var_18 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get pageImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("page_image") as IStaticBitmapWrapperWindow;
      }
   }
}

