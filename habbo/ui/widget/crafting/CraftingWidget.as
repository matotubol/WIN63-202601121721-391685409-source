package com.sulake.habbo.ui.widget.crafting
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.CraftingWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInfoController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInventoryListController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingMixerController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingRecipeListController;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import package_96.class_2347;
   import package_96.class_2398;
   
   public class CraftingWidget extends RoomWidgetBase
   {
      
      public static const MODE_NONE:int = 0;
      
      public static const MODE_SECRET_RECIPE:int = 1;
      
      public static const MODE_PUBLIC_RECIPE:int = 2;
      
      private var _roomUI:RoomUI;
      
      private var var_1497:CraftingFurnitureItem;
      
      private var var_298:IModalDialog;
      
      private var var_1581:class_1812;
      
      private var var_1290:CraftingInventoryListController;
      
      private var var_1225:CraftingRecipeListController;
      
      private var var_1044:CraftingMixerController;
      
      private var var_1155:CraftingInfoController;
      
      private var var_1195:int = 0;
      
      public function CraftingWidget(param1:IRoomWidgetHandler, param2:class_38, param3:RoomUI)
      {
         super(param1,param2,assets,localizations);
         _roomUI = param3;
         var_1290 = new CraftingInventoryListController(this);
         var_1225 = new CraftingRecipeListController(this);
         var_1044 = new CraftingMixerController(this);
         var_1155 = new CraftingInfoController(this);
         _assets = param3.assets;
         this.handler.widget = this;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide();
         _roomUI = null;
         if(var_1290)
         {
            var_1290.dispose();
            var_1290 = null;
         }
         if(var_1225)
         {
            var_1225.dispose();
            var_1225 = null;
         }
         if(var_1044)
         {
            var_1044.dispose();
            var_1044 = null;
         }
         if(var_1155)
         {
            var_1155.dispose();
            var_1155 = null;
         }
         if(var_1581)
         {
            var_1581.dispose();
            var_1581 = null;
         }
         super.dispose();
      }
      
      public function hide() : void
      {
         handler.removeInventoryUpdateEvent();
         var_1044.clearItems();
         var_1290.clearItems();
         var_1225.clearItems();
         if(craftingInProgress)
         {
            var_1155.cancelCrafting();
         }
         var_1195 = 0;
         if(var_298 != null)
         {
            var_298.dispose();
            var_298 = null;
         }
      }
      
      private function createMainWindow() : void
      {
         if(window != null)
         {
            return;
         }
         var_298 = windowManager.buildModalDialogFromXML(XML(assets.getAssetByName("craftingwidget_xml").content));
         if(!var_298 || !var_298.rootWindow)
         {
            return;
         }
         var _loc2_:class_1741 = window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
         var _loc1_:IItemGridWindow = window.findChildByName("itemgrid_products") as IItemGridWindow;
         var_1581 = _loc1_.getGridItemAt(0) as class_1812;
         _loc1_.removeGridItem(var_1581);
         window.procedure = onInput;
         window.center();
      }
      
      public function populateInventoryItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var_1290.populateInventoryItems(param1);
      }
      
      public function populateRecipeItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var_1225.populateRecipeItems(param1);
      }
      
      public function setInfoState(param1:int, ... rest) : void
      {
         if(var_1155)
         {
            var_1155.setState(param1,rest);
         }
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function setInfoText(param1:String) : void
      {
         var _loc2_:ITextWindow = window ? window.findChildByName("header_mixer") as ITextWindow : null;
         if(_loc2_)
         {
            _loc2_.text = param1;
         }
      }
      
      public function showWidget() : void
      {
         if(window)
         {
            return;
         }
         createMainWindow();
         setInfoText("");
         setInfoState(0);
      }
      
      public function showCraftingCategories(param1:Vector.<class_2398>, param2:Vector.<String>, param3:IRoomEngine, param4:ISessionDataManager) : void
      {
         var _loc9_:* = undefined;
         var _loc6_:* = null;
         var _loc10_:class_1800 = null;
         var _loc12_:class_1800 = null;
         var _loc8_:Boolean = false;
         var _loc11_:CraftingFurnitureItem = null;
         var _loc5_:Array = null;
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(_loc6_ in param2)
         {
            _loc8_ = false;
            _loc10_ = param4.getFloorItemDataByName(_loc6_);
            if(!_loc10_)
            {
               _loc10_ = param4.getWallItemDataByName(_loc6_);
               _loc8_ = true;
               if(!_loc10_)
               {
                  continue;
               }
            }
            _loc11_ = new CraftingFurnitureItem(null,null,_loc10_);
            _loc5_ = handler.container.inventory.getNonRentedInventoryIds("furni",_loc11_.typeId,_loc8_);
            if(_loc5_ && _loc5_.length > 0)
            {
               _loc11_.inventoryIds = Vector.<int>(_loc5_);
            }
            _loc9_.push(_loc11_);
         }
         populateInventoryItems(_loc9_);
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(var _loc7_ in param1)
         {
            _loc10_ = param4.getFloorItemDataByName(_loc7_.furnitureClassName);
            _loc12_ = param4.getWallItemDataByName(_loc7_.furnitureClassName);
            if(_loc10_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc10_));
            }
            else if(_loc12_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc12_));
            }
         }
         populateRecipeItems(_loc9_);
      }
      
      public function showCraftableProduct(param1:CraftingFurnitureItem) : void
      {
         var_1497 = param1;
         if(!var_1497)
         {
            return;
         }
         setInfoText(var_1497.furnitureData ? var_1497.furnitureData.localizedName : "");
         handler.getCraftingRecipe(var_1497.recipeCode,var_1497.productCode);
      }
      
      public function showCraftingRecipe(param1:Vector.<class_2347>) : void
      {
         showCraftableProductView();
         var_1225.showRecipe(var_1497,param1);
      }
      
      public function clearMixerItems() : void
      {
         if(var_1044)
         {
            var_1044.clearItems();
         }
      }
      
      public function mixerContentChanged(param1:Vector.<int>) : void
      {
         if(param1.length > 0)
         {
            setInfoState(1000);
            handler.getCraftingRecipesAvailable(param1);
         }
         else
         {
            setInfoState(1);
         }
      }
      
      public function showSecretRecipeView() : void
      {
         if(var_1195 != 1)
         {
            clearMixerItems();
         }
         var_1195 = 1;
         setInfoText("");
         setInfoState(1);
      }
      
      public function showCraftableProductView() : void
      {
         if(var_1195 != 2)
         {
            clearMixerItems();
         }
         var_1195 = 2;
         setInfoState(6);
      }
      
      public function doCrafting() : void
      {
         switch(var_1195 - 1)
         {
            case 0:
               handler.doCraftingWithMixer();
               break;
            case 1:
               handler.doCraftingWithRecipe();
         }
      }
      
      public function getSelectedIngredients() : Vector.<int>
      {
         return var_1044.collectSelectedFurnitureIds();
      }
      
      public function get inSecretRecipeMode() : Boolean
      {
         return var_1195 == 1;
      }
      
      public function get craftingInProgress() : Boolean
      {
         return handler.craftingInProgress;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return handler.inventoryDirty;
      }
      
      public function get itemTemplate() : class_1812
      {
         return var_1581;
      }
      
      public function get handler() : CraftingWidgetHandler
      {
         return var_41 as CraftingWidgetHandler;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return handler.container.sessionDataManager;
      }
      
      public function get inventoryCtrl() : CraftingInventoryListController
      {
         return var_1290;
      }
      
      public function get recipeCtrl() : CraftingRecipeListController
      {
         return var_1225;
      }
      
      public function get mixerCtrl() : CraftingMixerController
      {
         return var_1044;
      }
      
      public function get infoCtrl() : CraftingInfoController
      {
         return var_1155;
      }
      
      public function get window() : class_1812
      {
         return var_298 ? var_298.rootWindow as class_1812 : null;
      }
   }
}

