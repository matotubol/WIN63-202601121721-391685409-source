package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.recycler.FurniSlotItem;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class InventoryMainView
   {
      
      private static const COUNTER_MARGIN:int = 3;
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(120,150);
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_30:class_2250;
      
      private var var_441:String;
      
      private var var_2876:class_1812;
      
      private var var_1231:String;
      
      private var var_3586:class_1812;
      
      private var var_55:HabboInventory;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_1991:class_1812;
      
      private var var_1672:class_1812;
      
      private var var_2170:class_1812;
      
      private var var_1889:class_1812;
      
      private var var_1893:class_1812;
      
      private var var_2020:class_1812;
      
      private var var_3653:Dictionary;
      
      private var var_3504:ITabButtonWindow;
      
      private var var_1962:Boolean;
      
      private var var_4590:int;
      
      public function InventoryMainView(param1:HabboInventory, param2:class_38, param3:class_40)
      {
         super();
         var_55 = param1;
         var_909 = param3;
         _windowManager = param2;
      }
      
      public function get isVisible() : Boolean
      {
         return var_30 ? var_30.visible : false;
      }
      
      public function get isActive() : Boolean
      {
         return var_30 ? var_30.getStateFlag(1) : false;
      }
      
      public function get emptyContainer() : class_1812
      {
         if(!var_30)
         {
            return null;
         }
         return var_30.findChildByName("empty_container") as class_1812;
      }
      
      public function get loadingContainer() : class_1812
      {
         if(!var_30)
         {
            return null;
         }
         return var_30.findChildByName("loading_container") as class_1812;
      }
      
      public function get mainContainer() : class_1812
      {
         if(!var_30)
         {
            return null;
         }
         return var_30.findChildByName("contentArea") as class_1812;
      }
      
      public function dispose() : void
      {
         var_1991 = null;
         var_1672 = null;
         var_1893 = null;
         var_1889 = null;
         var_2170 = null;
         var_2020 = null;
         var_55 = null;
         var_2876 = null;
         var_3586 = null;
         if(var_30)
         {
            var_30.dispose();
            var_30 = null;
         }
         if(_toolbar)
         {
            if(_toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
            }
            _toolbar = null;
         }
         _windowManager = null;
         var_909 = null;
      }
      
      private function getWindow() : class_2250
      {
         var _loc4_:IAsset = null;
         var _loc1_:XmlAsset = null;
         if(!var_30)
         {
            _loc4_ = var_909.getAssetByName("inventory_xml");
            _loc1_ = XmlAsset(_loc4_);
            var_3653 = new Dictionary();
            var_30 = _windowManager.buildFromXML(XML(_loc1_.content)) as class_2250;
            if(var_30 != null)
            {
               var_30.position = DEFAULT_VIEW_LOCATION;
               var_30.visible = false;
               var_30.procedure = windowEventProc;
               var_30.setParamFlag(65536,var_55.getBoolean("inventory.allow.scaling"));
               extractWindow("furni");
               extractWindow("collectibles");
               extractWindow("pets");
               extractWindow("bots");
               extractWindow("badges");
               var _loc2_:ITabContextWindow = var_30.findChildByName("tabs") as ITabContextWindow;
               var _loc3_:Array = [];
               while(null.numTabItems > 0)
               {
                  var _loc5_:ITabButtonWindow = null.getTabItemAt(0);
                  null.push(null);
                  null.removeTabItem(null);
               }
               for each(_loc5_ in null)
               {
                  switch(_loc5_.name)
                  {
                     case "collectibles":
                        if(var_55.web3tradeEnabled)
                        {
                           var_3504 = null;
                           var_4590 = null.numTabItems;
                           if(var_1962)
                           {
                              null.addTabItem(null);
                           }
                        }
                        break;
                     case "bots":
                        if(var_55.getBoolean("inventory.bots.enabled"))
                        {
                           null.addTabItem(null);
                        }
                        break;
                     case "rentables":
                        if(!var_55.mergeRentFurni && var_55.getBoolean("duckets.enabled"))
                        {
                           null.addTabItem(null);
                        }
                        break;
                     default:
                        null.addTabItem(null);
                  }
               }
               var_55.preparingInventoryView();
            }
            var_55.updateUnseenItemCounts();
         }
         if(var_30.y < 0)
         {
            var_30.y = 0;
         }
         if(var_30.x < 0)
         {
            var_30.x = 0;
         }
         return var_30;
      }
      
      public function disableNonTradingTabs(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ITabButtonWindow = null;
         var _loc3_:ITabContextWindow = var_30.findChildByName("tabs") as ITabContextWindow;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numTabItems)
         {
            _loc2_ = _loc3_.getTabItemAt(_loc4_);
            if(_loc2_.name != "collectibles" && _loc2_.name != "furni")
            {
               Util.disableSection(_loc2_,param1);
            }
            _loc4_ += 1;
         }
      }
      
      public function showCollectiblesTab(param1:Boolean) : void
      {
         if(!var_30)
         {
            var_1962 = param1;
            return;
         }
         var _loc2_:ITabContextWindow = var_30.findChildByName("tabs") as ITabContextWindow;
         if(var_1962 && !param1)
         {
            _loc2_.removeTabItem(var_3504);
         }
         else if(!var_1962 && param1)
         {
            _loc2_.addTabItemAt(var_3504,var_4590);
         }
         var_1962 = param1;
      }
      
      public function getCategoryViewId() : String
      {
         return var_441;
      }
      
      public function getSubCategoryViewId() : String
      {
         return var_1231;
      }
      
      public function hideInventory() : void
      {
         var_55.closingInventoryView();
         var _loc1_:class_1741 = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function showInventory() : void
      {
         var _loc1_:class_1741 = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         var_55.inventoryViewOpened(var_1231 && var_1231.length > 0 ? var_1231 : var_441);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = true, param3:Boolean = false) : Boolean
      {
         var _loc4_:class_1741 = getWindow();
         if(_loc4_ == null)
         {
            return false;
         }
         if(_loc4_.visible)
         {
            if(var_441 == param1)
            {
               if(param2)
               {
                  if(!WindowToggle.isHiddenByOtherWindows(_loc4_))
                  {
                     hideInventory();
                     return false;
                  }
                  _loc4_.activate();
               }
            }
            else
            {
               setViewToCategory(param1);
            }
         }
         else
         {
            if(param3 && var_441 != null && var_441 != param1)
            {
               setViewToCategory(param1);
            }
            _loc4_.visible = true;
            _loc4_.activate();
            if(param1 != var_441 || !var_55.isInventoryCategoryInit(param1))
            {
               setViewToCategory(param1);
            }
            var_55.inventoryViewOpened(param1);
         }
         return true;
      }
      
      public function toggleSubCategoryView(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:class_1741 = getWindow();
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.visible)
         {
            if(var_1231 == param1)
            {
               if(param2)
               {
                  _loc3_.visible = false;
               }
            }
            else
            {
               setSubViewToCategory(param1);
            }
         }
         else
         {
            _loc3_.visible = true;
            if(param1 != var_1231)
            {
               setSubViewToCategory(param1);
            }
         }
      }
      
      public function updateSubCategoryView() : void
      {
         if(var_1231 == null)
         {
            return;
         }
         setSubViewToCategory(var_1231);
      }
      
      public function setToolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      public function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            var _loc3_:String = ITabContextWindow(param2).selector.getSelected().name;
            if(null != var_441)
            {
               resetUnseenCounters(var_441);
               var_55.toggleInventoryPage(null);
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            if(param2.name == "header_button_close")
            {
               hideInventory();
            }
            if(param2.name == "open_catalog_btn")
            {
               var_55.catalog.openCatalog();
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            if(param2.name == "titlebar")
            {
               var_30.height = var_30.limits.minHeight;
            }
         }
      }
      
      public function updateUnseenFurniCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_1991)
         {
            var_1991 = createCounter("furni");
         }
         updateCounter(var_1991,param1);
      }
      
      public function updateUnseenRentedFurniCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_1672)
         {
            var_1672 = createCounter("rentables");
         }
         updateCounter(var_1672,param1);
      }
      
      public function updateUnseenPetsCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_1889)
         {
            var_1889 = createCounter("pets");
         }
         updateCounter(var_1889,param1);
         var_55.petsModel.updateView();
      }
      
      public function updateUnseenBadgeCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_2170)
         {
            var_2170 = createCounter("badges");
         }
         updateCounter(var_2170,param1);
         var_55.badgesModel.updateView();
      }
      
      public function updateUnseenBotCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_1893)
         {
            var_1893 = createCounter("bots");
         }
         updateCounter(var_1893,param1);
         var_55.botsModel.updateView();
      }
      
      public function updateUnseenCollectiblesCount(param1:int) : void
      {
         if(!var_30)
         {
            return;
         }
         if(!var_2020)
         {
            var_2020 = createCounter("collectibles");
         }
         updateCounter(var_2020,param1);
         var_55.collectiblesModel.updateView();
      }
      
      public function getView(param1:String) : class_1812
      {
         return var_3653[param1] as class_1812;
      }
      
      private function extractWindow(param1:String) : void
      {
         var _loc2_:class_1741 = mainContainer.getChildByName(param1);
         if(_loc2_)
         {
            var_3653[param1] = mainContainer.removeChild(_loc2_);
         }
      }
      
      private function resetUnseenCounters(param1:String) : void
      {
         switch(param1)
         {
            case "furni":
               var_55.furniModel.resetUnseenItems();
               break;
            case "rentables":
               var_55.furniModel.resetUnseenItems();
               break;
            case "pets":
               var_55.petsModel.resetUnseenItems();
               break;
            case "badges":
               var_55.badgesModel.resetUnseenItems();
               break;
            case "collectibles":
               var_55.collectiblesModel.resetUnseenItems();
               break;
            case "bots":
               var_55.botsModel.resetUnseenItems();
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         if(emptyContainer)
         {
            emptyContainer.visible = false;
         }
         if(loadingContainer)
         {
            loadingContainer.visible = false;
         }
         var_55.checkCategoryInitilization(param1);
         if(mainContainer == null)
         {
            return;
         }
         mainContainer.removeChild(var_2876);
         mainContainer.invalidate();
         var _loc2_:class_1812 = var_55.getCategoryWindowContainer(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.addChild(_loc2_);
         _loc2_.height = mainContainer.height;
         var_55.updateView(param1);
         var_2876 = _loc2_;
         var_441 = param1;
         var _loc3_:ITabContextWindow = var_30.findChildByName("tabs") as ITabContextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selector.setSelected(_loc3_.selector.getSelectableByName(param1));
         emptyFurnimaticSlots();
      }
      
      private function emptyFurnimaticSlots() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FurniSlotItem = null;
         var _loc3_:IRecycler = var_55.catalog.getRecycler();
         if(_loc3_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.numberOfSlots)
            {
               _loc1_ = _loc3_.getSlotContent(_loc2_);
               if(_loc1_ != null)
               {
                  _loc3_.releaseSlot(_loc2_);
               }
               _loc2_++;
            }
         }
      }
      
      private function enableScaling() : void
      {
         var_30.height = var_30.limits.minHeight;
         var_30.setParamFlag(65536,true);
         var_30.findChildByName("top_content").setParamFlag(2048,true);
      }
      
      private function disableScaling() : void
      {
         var_30.height = var_30.limits.minHeight;
         var_30.setParamFlag(65536,false);
         var_30.findChildByName("top_content").setParamFlag(2048,false);
      }
      
      private function setSubViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var_55.checkCategoryInitilization(param1);
         var _loc2_:class_1812 = var_30.findChildByName("subContentArea") as class_1812;
         while(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
         var _loc3_:class_1812 = var_55.getCategorySubWindowContainer(param1);
         if(_loc3_ != null)
         {
            disableScaling();
            _loc2_.visible = true;
            _loc3_.visible = true;
            _loc2_.addChild(_loc3_);
         }
         else
         {
            enableScaling();
            _loc2_.visible = false;
         }
         _loc2_.y = var_30.findChildByName("top_content").rectangle.bottom + 5;
         resizeToFitContents();
         if(var_30.parent != null)
         {
            if(var_30.x + var_30.width > var_30.parent.width)
            {
               var_30.x = var_30.parent.width - var_30.width;
            }
            if(var_30.y + var_30.height > var_30.parent.height)
            {
               var_30.y = (var_30.parent.height - var_30.height) * 0.5;
            }
            if(var_30.y < 0)
            {
               var_30.y = 0;
            }
         }
         var_3586 = _loc3_;
         var_1231 = param1;
      }
      
      public function resizeToFitContents() : void
      {
         var _loc1_:class_1812 = var_30.findChildByName("subContentArea") as class_1812;
         if(_loc1_.visible)
         {
            _loc1_.height = Util.getLowestPoint(_loc1_);
         }
         else
         {
            _loc1_.height = 0;
         }
         var_30.resizeToFitContent();
      }
      
      private function createCounter(param1:String) : class_1812
      {
         var _loc3_:class_1812 = _windowManager.createUnseenItemCounter();
         var _loc2_:class_1812 = var_30.findChildByName(param1) as class_1812;
         if(_loc2_)
         {
            _loc2_.addChild(_loc3_);
            _loc3_.x = _loc2_.width - _loc3_.width - 3;
            _loc3_.y = 3;
         }
         return _loc3_;
      }
      
      private function updateCounter(param1:class_1812, param2:int) : void
      {
         var _loc5_:ILabelWindow = null;
         param1.findChildByName("count").caption = param2.toString();
         param1.visible = param2 > 0;
         var _loc3_:String = "";
         switch(param1)
         {
            case var_1893:
               _loc3_ = "bots";
               break;
            case var_2020:
               _loc3_ = "collectibles";
               break;
            case var_1889:
               _loc3_ = "pets";
               break;
            case var_2170:
               _loc3_ = "badges";
               break;
            case var_1991:
               _loc3_ = "furni";
               break;
            case var_1672:
               _loc3_ = "rentables";
               break;
            case var_1672:
               _loc3_ = "rentables";
         }
         var _loc4_:class_1812 = var_30.findChildByName(_loc3_) as class_1812;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getChildByTag("TITLE") as ILabelWindow;
            if(_loc5_)
            {
               if(param1.visible)
               {
                  _loc5_.margins.right = param1.width + 2 * 3;
               }
               else
               {
                  _loc5_.margins.right = _loc5_.margins.left;
               }
               _loc4_.width = _loc5_.width;
               param1.x = _loc4_.width - param1.width - 3;
            }
         }
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId != "HTIE_ICON_INVENTORY")
         {
            return;
         }
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(var_441 == "pets")
            {
               toggleCategoryView("pets");
            }
            else if(var_441 == "furni")
            {
               toggleCategoryView("furni");
            }
            else if(var_441 == "rentables")
            {
               toggleCategoryView("rentables");
            }
            else if(var_441 == "badges")
            {
               toggleCategoryView("badges");
            }
            else if(var_441 == "bots")
            {
               toggleCategoryView("bots");
            }
            else if(var_441 == "collectibles")
            {
               toggleCategoryView("furni");
            }
            else if(var_55 != null)
            {
               var_55.toggleInventoryPage("furni");
            }
         }
      }
   }
}

