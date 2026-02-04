package com.sulake.habbo.catalog.collectibles.renderer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   
   public class AbstractCollectibleItemRenderer
   {
      
      protected var var_55:CollectiblesController;
      
      private var var_452:IRenderableCollectibleItem;
      
      private var var_1138:class_1812;
      
      private var var_2198:CollectibleProductPreviewer;
      
      private var _active:Boolean = false;
      
      private var var_1919:Boolean = false;
      
      public function AbstractCollectibleItemRenderer(param1:CollectiblesController, param2:IRenderableCollectibleItem, param3:class_1812)
      {
         super();
         var_55 = param1;
         var_452 = param2;
         var_1138 = param3;
         var_1138.addEventListener("WME_CLICK",onClick);
         var_1138.addEventListener("WME_OVER",onOver);
         var_1138.addEventListener("WME_OUT",onOut);
         var_2198 = new CollectibleProductPreviewer(bitmapWindow,badgeImageWindow,petImageWindow,unknownImageWindow);
         var_55.previewIcon(var_452,var_2198);
         updateVisuals();
         updateColoring();
      }
      
      public function updateVisuals() : void
      {
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      private function updateColoring() : void
      {
         var _loc2_:Object = isComplete ? completeColoring() : incompleteColoring();
         var _loc1_:Object = var_1919 ? _loc2_.hovered : (_active ? _loc2_.active : _loc2_.normal);
         borderOutline.color = _loc1_.outline;
         borderBackground.color = _loc1_.background;
      }
      
      protected function incompleteColoring() : Object
      {
         return {
            "active":{
               "background":15132390,
               "outline":16777215
            },
            "hovered":{
               "background":14409183,
               "outline":16119544
            },
            "normal":{
               "background":13159891,
               "outline":9412017
            }
         };
      }
      
      protected function completeColoring() : Object
      {
         return {
            "active":{
               "background":14872032,
               "outline":16777215
            },
            "hovered":{
               "background":14346200,
               "outline":16119544
            },
            "normal":{
               "background":13820623,
               "outline":8823170
            }
         };
      }
      
      protected function get isComplete() : Boolean
      {
         return var_452.amount > 0;
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         var_1919 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         var_1919 = true;
         updateColoring();
      }
      
      public function dispose() : void
      {
         if(var_1138)
         {
            var_1138.dispose();
            var_1138 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get renderableItem() : IRenderableCollectibleItem
      {
         return var_452;
      }
      
      public function get container() : class_1812
      {
         return var_1138;
      }
      
      protected function get borderOutline() : class_1993
      {
         return null;
      }
      
      protected function get borderBackground() : class_1993
      {
         return null;
      }
      
      protected function get amountText() : ITextWindow
      {
         return null;
      }
      
      protected function get amountTextBorder() : class_1993
      {
         return null;
      }
      
      protected function get bitmapWindow() : class_2251
      {
         return null;
      }
      
      protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return null;
      }
      
      protected function get badgeImageWindow() : class_2010
      {
         return null;
      }
      
      protected function get petImageWindow() : class_2010
      {
         return null;
      }
   }
}

