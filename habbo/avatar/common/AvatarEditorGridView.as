package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   
   public class AvatarEditorGridView implements class_3455
   {
      
      public static const REMOVE_ITEM:String = "REMOVE_ITEM";
      
      public static const GET_MORE:String = "GET_MORE";
      
      private const MAX_COLOR_LAYERS:int = 2;
      
      private var var_18:class_1812;
      
      private var var_36:class_2582;
      
      private var var_690:IItemGridWindow;
      
      private var var_841:Array;
      
      private var var_2851:String;
      
      private var var_2193:class_1741;
      
      private var var_839:class_1741;
      
      public function AvatarEditorGridView(param1:class_1812)
      {
         super();
         var_18 = param1;
         var_690 = var_18.findChildByName("thumbs") as IItemGridWindow;
         var_841 = [];
         var_841.push(var_18.findChildByName("palette0") as IItemGridWindow);
         var_841.push(var_18.findChildByName("palette1") as IItemGridWindow);
         var_2193 = var_18.findChildByName("content_notification");
         var_839 = var_18.findChildByName("content_title");
         var_2193.visible = false;
         var_839.visible = false;
      }
      
      public function dispose() : void
      {
         if(var_690)
         {
            var_690.dispose();
            var_690 = null;
         }
         if(var_841)
         {
            for each(var _loc1_ in var_841)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
                  _loc1_ = null;
               }
            }
            var_841 = null;
         }
         var_36 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function get window() : class_1812
      {
         if(var_18 == null)
         {
            return null;
         }
         if(var_18.disposed)
         {
            return null;
         }
         return var_18;
      }
      
      public function initFromList(param1:class_2582, param2:String) : void
      {
         var _loc4_:CategoryData = param1.getCategoryData(param2);
         if(!_loc4_)
         {
            return;
         }
         var_18.visible = true;
         var_36 = param1;
         var_2851 = param2;
         var_690.removeGridItems();
         if(_loc4_.parts.length == 0)
         {
            var_839.visible = true;
            var_2193.visible = true;
            return;
         }
         var_839.visible = false;
         var_2193.visible = false;
         for each(var _loc8_ in var_841)
         {
            _loc8_.removeGridItems();
         }
         for each(var _loc5_ in _loc4_.parts)
         {
            if(_loc5_)
            {
               var_690.addGridItem(_loc5_.view);
               _loc5_.view.addEventListener("WME_CLICK",onGridItemClicked);
               if(_loc5_.isSelected)
               {
                  showPalettes(_loc5_.colorLayerCount);
               }
            }
         }
         var _loc3_:int = 0;
         while(true)
         {
            var _loc6_:Array = _loc4_.getPalette(0);
            _loc8_ = var_841[0] as IItemGridWindow;
            _loc3_++;
         }
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc4_:IScrollableGridWindow = var_18.findChildByName("palette0") as IScrollableGridWindow;
         var _loc3_:IScrollableGridWindow = var_18.findChildByName("palette1") as IScrollableGridWindow;
         var _loc5_:int = int(var_690.width);
         var _loc2_:int = (var_690.width - 10) / 2;
         if(param1 <= 1)
         {
            _loc4_.width = _loc5_;
            _loc4_.visible = true;
            _loc3_.visible = false;
         }
         else
         {
            _loc4_.width = _loc2_;
            _loc3_.width = _loc2_;
            _loc3_.x = _loc4_.right + 10;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
      }
      
      public function updatePart(param1:int, param2:class_1812) : void
      {
         var _loc3_:class_1741 = var_690.getGridItemAt(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_ = param2;
      }
      
      private function onGridItemClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.target.name)
         {
            case "REMOVE_ITEM":
               _loc2_ = var_690.getGridItemIndex(param1.window);
               var_36.selectPart(var_2851,_loc2_);
               break;
            case "GET_MORE":
               var_36.controller.manager.catalog.openCatalogPage(var_36.controller.manager.getProperty("catalog.clothes.page"));
               break;
            default:
               _loc2_ = var_690.getGridItemIndex(param1.window);
               var_36.selectPart(var_2851,_loc2_);
         }
      }
      
      private function paletteEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:IItemGridWindow = null;
         var _loc7_:int = 0;
         var _loc3_:class_1741 = null;
         var _loc6_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param1.window;
            _loc6_ = 0;
            while(_loc6_ < 2)
            {
               if(var_841.length > _loc6_)
               {
                  _loc4_ = var_841[_loc6_] as IItemGridWindow;
                  _loc7_ = _loc4_.getGridItemIndex(_loc3_);
                  if(_loc7_ > -1)
                  {
                     var_36.selectColor(var_2851,_loc7_,_loc6_);
                     return;
                  }
               }
               _loc6_++;
            }
         }
      }
   }
}

