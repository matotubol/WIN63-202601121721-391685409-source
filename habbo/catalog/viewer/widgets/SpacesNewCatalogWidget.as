package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements class_13, class_2612, IItemGrid
   {
      
      private var var_2363:Array = ["wallpaper","floor","landscape"];
      
      private var var_252:Array = [];
      
      private var _selectedGroup:int = 0;
      
      private var var_1755:Array = [0,0,0];
      
      private var var_817:ISelectorWindow;
      
      private var var_143:Array = ["group.walls","group.floors","group.views"];
      
      public function SpacesNewCatalogWidget(param1:class_1812, param2:ISessionDataManager, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         for each(var _loc2_ in var_252)
         {
            for each(var _loc1_ in _loc2_)
            {
               _loc1_.dispose();
            }
         }
         var_252 = null;
      }
      
      override public function init() : Boolean
      {
         class_21.log("Init Item Group Catalog Widget (Spaces New)");
         createOfferGroups();
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var_817 = _window.findChildByName("groups") as ISelectorWindow;
         if(var_817)
         {
            var _loc2_:int = 0;
            while(0 < var_817.numSelectables)
            {
               var _loc1_:class_1741 = var_817.getSelectableAt(0);
               if(null is ISelectableWindow)
               {
                  null.addEventListener("WE_SELECTED",onSelectGroup);
               }
               _loc2_++;
            }
         }
         switchCategory(var_143[_selectedGroup]);
         updateRoomPreview();
         return true;
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc3_:int = int(var_1755[_selectedGroup]);
         var _loc2_:class_1793 = var_252[_selectedGroup][_loc3_];
         this.select(_loc2_.gridItem,false);
      }
      
      public function selectIndex(param1:int) : void
      {
         var _loc2_:class_1793 = null;
         if(param1 > -1 && param1 < _itemGrid.numGridItems)
         {
            _loc2_ = var_252[_selectedGroup][param1];
            this.select(_loc2_.gridItem,false);
         }
      }
      
      override public function select(param1:class_2253, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.select(param1,false);
         var _loc3_:class_1793 = (param1 as ProductContainer).offer;
         if(_loc3_ == null)
         {
            return;
         }
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc3_.product.extraParam));
         var_1755[_selectedGroup] = (var_252[_selectedGroup] as Vector.<class_1793>).indexOf(_loc3_);
         updateRoomPreview();
      }
      
      private function updateRoomPreview() : void
      {
         var _loc5_:int = int(var_1755[0]);
         var _loc6_:int = int(var_1755[1]);
         var _loc3_:int = int(var_1755[2]);
         var _loc2_:class_1793 = var_252[0].length > _loc5_ ? var_252[0][_loc5_] : null;
         var _loc4_:class_1793 = var_252[1].length > _loc6_ ? var_252[1][_loc6_] : null;
         var _loc1_:class_1793 = var_252[2].length > _loc3_ ? var_252[2][_loc3_] : null;
         if(!_loc4_ || !_loc2_ || !_loc1_)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc4_.product.extraParam,_loc2_.product.extraParam,_loc1_.product.extraParam,64));
      }
      
      private function createOfferGroups() : Boolean
      {
         var _loc2_:class_1857 = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         for each(var _loc1_ in page.offers)
         {
            if(!(_loc1_.pricingModel == "pricing_model_single" || _loc1_.pricingModel == "pricing_model_multi"))
            {
               continue;
            }
            _loc2_ = _loc1_.product;
            if(_loc2_ == null)
            {
               continue;
            }
            _loc3_ = _loc2_.productClassId;
            if(!(_loc2_.productType == "i" || _loc2_.productType == "s"))
            {
               continue;
            }
            if(_loc2_.furnitureData == null)
            {
               continue;
            }
            _loc4_ = _loc2_.furnitureData.className;
            _loc5_ = int(var_2363.indexOf(_loc4_));
            if(var_2363.indexOf(_loc4_) == -1)
            {
               var_2363.push(_loc4_);
            }
            while(var_252.length < var_2363.length)
            {
               var_252.push(new Vector.<class_1793>(0));
            }
            switch(_loc4_)
            {
               case "floor":
                  (var_252[_loc5_] as Vector.<class_1793>).push(_loc1_);
                  break;
               case "wallpaper":
                  (var_252[_loc5_] as Vector.<class_1793>).push(_loc1_);
                  break;
               case "landscape":
                  (var_252[_loc5_] as Vector.<class_1793>).push(_loc1_);
                  break;
               default:
                  class_21.log("[Spaces Catalog Widget] : " + _loc4_);
            }
         }
         page.replaceOffers(new Vector.<class_1793>(0),false);
         return true;
      }
      
      private function onSelectGroup(param1:class_1758) : void
      {
         var _loc3_:ISelectableWindow = param1.target as ISelectableWindow;
         if(_loc3_)
         {
            var _loc2_:int = var_817.getSelectableIndex(_loc3_);
            class_21.log("select: " + [_loc3_.name,0]);
            switchCategory(_loc3_.name);
         }
      }
      
      private function switchCategory(param1:String) : void
      {
         if(disposed)
         {
            return;
         }
         if(!var_817)
         {
            return;
         }
         var_817.setSelected(var_817.getSelectableByName(param1));
         var _loc5_:int = -1;
         switch(param1)
         {
            case "group.walls":
               _loc5_ = 0;
               break;
            case "group.floors":
               _loc5_ = 1;
               break;
            case "group.views":
               _loc5_ = 2;
               break;
            default:
               _loc5_ = -1;
         }
         if(_loc5_ > -1)
         {
            if(var_488 != null)
            {
               var_488.deactivate();
            }
            var_488 = null;
            _selectedGroup = _loc5_;
            if(_itemGrid)
            {
               _itemGrid.destroyGridItems();
            }
            var _loc2_:Vector.<class_1793> = var_252[_selectedGroup] == null ? new Vector.<class_1793>(0) : var_252[_selectedGroup];
            page.replaceOffers(undefined,false);
            resetTimer();
            var _loc3_:Vector.<class_1793> = populateItemGrid();
            loadItemGridGraphics(null,undefined);
            if(var_323)
            {
               var_323.start();
            }
            var _loc4_:int = int(var_1755[_selectedGroup]);
            selectIndex(0);
         }
      }
   }
}

