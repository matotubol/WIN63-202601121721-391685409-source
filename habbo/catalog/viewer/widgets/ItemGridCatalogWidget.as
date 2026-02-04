package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.class_2050;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.catalog.viewer.class_2557;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.session.ISessionDataManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ItemGridCatalogWidget extends CatalogWidget implements class_2612, IItemGrid, class_2050
   {
      
      protected var _itemGrid:IItemGridWindow;
      
      protected var _gridItemLayout:XML;
      
      protected var var_2742:XML;
      
      protected var var_2951:XML;
      
      protected var var_488:class_2253;
      
      private var _bundleCounter:int = 0;
      
      protected var var_323:Timer;
      
      protected var var_2055:Function;
      
      protected var var_5302:Boolean = true;
      
      private var _offerInitIndex:int = 0;
      
      protected var var_70:ISessionDataManager;
      
      private var var_3738:int = -1;
      
      private var _selectedGuildColor1:String;
      
      private var _selectedGuildColor2:String;
      
      private var var_4414:String;
      
      private var var_327:String;
      
      public var itemColors:Dictionary = new Dictionary();
      
      public var chosenItemColorIndex:int = 0;
      
      public function ItemGridCatalogWidget(param1:class_1812, param2:ISessionDataManager, param3:String)
      {
         super(param1);
         var_70 = param2;
         var_327 = param3;
      }
      
      override public function dispose() : void
      {
         if(var_323 != null)
         {
            var_323.stop();
            if(var_2055 != null)
            {
               var_323.removeEventListener("timer",var_2055);
               var_2055 = null;
            }
            var_323 = null;
         }
         if(_itemGrid != null)
         {
            _itemGrid.destroyGridItems();
            _itemGrid = null;
         }
         _gridItemLayout = null;
         var_2742 = null;
         var_2951 = null;
         var_488 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         var isFixed:Boolean;
         var gridAsset:XmlAsset;
         var loadGraphics:Vector.<class_1793>;
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("itemGridWidget");
         isFixed = _window.tags.indexOf("FIXED") > -1;
         _itemGrid = _window.findChildByName("itemGrid") as IItemGridWindow;
         if(!isFixed)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         _itemGrid.verticalSpacing = 0;
         gridAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = gridAsset.content as XML;
         gridAsset = page.viewer.catalog.assets.getAssetByName("grid_item_with_price_single") as XmlAsset;
         var_2951 = gridAsset.content as XML;
         gridAsset = page.viewer.catalog.assets.getAssetByName("grid_item_with_price_multi") as XmlAsset;
         var_2742 = gridAsset.content as XML;
         loadGraphics = populateItemGrid();
         if(var_5302)
         {
            var_323 = new Timer(25);
            var_2055 = function(param1:TimerEvent):void
            {
               loadItemGridGraphics(param1,loadGraphics);
            };
            var_323.addEventListener("timer",var_2055);
            var_323.start();
         }
         else
         {
            loadItemGridGraphics(null,loadGraphics);
         }
         events.addEventListener("GUILD_SELECTED",onGuildSelected);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         return true;
      }
      
      public function select(param1:class_2253, param2:Boolean) : void
      {
         if(var_488 != null)
         {
            var_488.deactivate();
         }
         var_488 = param1;
         param1.activate();
         if(var_488.view)
         {
            var_488.view.findChildByName("border_outline").color = var_327 == "NORMAL" ? 6538729 : 16758076;
         }
         var _loc4_:ProductContainer = param1 as ProductContainer;
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.isLazy)
         {
            return;
         }
         var _loc3_:class_1793 = _loc4_.offer;
         if(_loc3_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc3_));
            if(_loc3_.product && _loc3_.product.productType == "i")
            {
               events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc3_.product.extraParam));
            }
         }
         if(param2)
         {
            events.dispatchEvent(new CatalogWidgetColoursEvent(getCurrentItemColors(),"ctlg_clr_27x22_1","ctlg_clr_27x22_2","ctlg_clr_27x22_3",getCurrentItemColourIndex()));
         }
      }
      
      public function startDragAndDrop(param1:class_2253) : Boolean
      {
         var _loc2_:class_1793 = (param1 as ProductContainer).offer;
         if(_loc2_ != null)
         {
            if(var_70.clubLevel >= _loc2_.clubLevel)
            {
               (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this,_loc2_);
            }
         }
         return true;
      }
      
      public function onDragAndDropDone(param1:Boolean, param2:String) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1)
         {
            events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false,param2));
         }
      }
      
      public function stopDragAndDrop() : void
      {
      }
      
      protected function populateItemGrid() : Vector.<class_1793>
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:class_1812 = null;
         var _loc3_:* = false;
         var _loc11_:Dictionary = new Dictionary();
         var _loc10_:Vector.<class_1793> = new Vector.<class_1793>();
         var _loc12_:* = page.layoutCode == "default_3x3_color_grouping";
         if(_loc12_)
         {
            for each(_loc1_ in page.offers)
            {
               if(!_loc1_.product.furnitureData || !_loc1_.product.isColorable)
               {
                  _loc10_.push(_loc1_);
               }
               else
               {
                  _loc6_ = _loc1_.product.furnitureData.fullName.split("*")[0];
                  _loc7_ = int(_loc1_.product.furnitureData.fullName.split("*")[1]);
                  if(!itemColors[_loc6_])
                  {
                     itemColors[_loc6_] = [];
                  }
                  if(_loc1_.product.furnitureData.colours)
                  {
                     _loc5_ = 16777215;
                     for each(_loc4_ in _loc1_.product.furnitureData.colours)
                     {
                        if(_loc4_ != 16777215)
                        {
                           _loc5_ = _loc4_;
                        }
                     }
                     if(itemColors[_loc6_].indexOf(_loc5_) == -1)
                     {
                        itemColors[_loc6_][_loc7_] = _loc5_;
                     }
                  }
                  if(_loc11_[_loc6_] == null)
                  {
                     _loc11_[_loc6_] = _loc10_.length;
                     _loc10_.push(_loc1_);
                  }
                  else if(_loc6_.indexOf("bc_") == 0 && (_loc5_ == 16777215 || _loc5_ == 16777214))
                  {
                     _loc8_ = int(_loc11_[_loc6_]);
                     _loc10_[_loc8_] = _loc1_;
                  }
               }
            }
         }
         else
         {
            _loc10_ = page.offers;
         }
         var _loc2_:Vector.<class_1793> = new Vector.<class_1793>();
         for each(_loc1_ in page.offers)
         {
            if(_loc12_ && _loc1_.product.furnitureData && _loc1_.product.isColorable)
            {
               if(_loc10_.indexOf(_loc1_) != -1)
               {
                  _loc9_ = createGridItem(_loc1_.gridItem);
                  _loc1_.gridItem.view = _loc9_;
               }
            }
            else
            {
               _loc9_ = createGridItem(_loc1_.gridItem);
               _loc1_.gridItem.view = _loc9_;
            }
            _loc1_.gridItem.grid = this;
            _loc3_ = _loc10_.indexOf(_loc1_) != -1;
            if(_loc3_)
            {
               _loc2_.push(_loc1_);
            }
            if(_loc1_.pricingModel == "pricing_model_bundle")
            {
               _bundleCounter = _bundleCounter + 1;
               if(_loc1_.productContainer is BundleProductContainer)
               {
                  (_loc1_.productContainer as BundleProductContainer).setBundleCounter(_bundleCounter);
               }
            }
         }
         return _loc2_;
      }
      
      protected function resetTimer() : void
      {
         if(var_323 != null)
         {
            var_323.reset();
         }
         _offerInitIndex = 0;
      }
      
      protected function loadItemGridGraphics(param1:TimerEvent = null, param2:Vector.<class_1793> = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:class_1793 = null;
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
         }
         if(param2 == null)
         {
            param2 = page.offers;
         }
         var _loc4_:int = int(param2.length);
         if(_loc4_ > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               if(_offerInitIndex >= 0 && _offerInitIndex < _loc4_)
               {
                  _loc3_ = param2[_offerInitIndex];
                  loadGraphics(_loc3_);
               }
               _offerInitIndex = _offerInitIndex + 1;
               if(_offerInitIndex >= _loc4_)
               {
                  resetTimer();
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      protected function createGridItem(param1:class_2253) : class_1812
      {
         var _loc2_:XML = null;
         var _loc3_:class_2557 = param1 as class_2557;
         var _loc5_:Boolean = _loc3_ != null && _loc3_.offer != null && (_loc3_.offer.priceInCredits > 0 || _loc3_.offer.priceInActivityPoints > 0 || _loc3_.offer.priceInSilver > 0);
         if(_loc5_ && var_327 != "BUILDERS_CLUB")
         {
            if(_loc3_.offer && _loc3_.offer.priceInCredits > 0 && _loc3_.offer.priceInActivityPoints > 0)
            {
               _loc2_ = var_2742;
            }
            else
            {
               _loc2_ = var_2951;
            }
         }
         else
         {
            _loc2_ = _gridItemLayout;
         }
         var _loc4_:class_1812 = page.viewer.catalog.windowManager.buildFromXML(_loc2_) as class_1812;
         _itemGrid.addGridItem(_loc4_);
         param1.view = _loc4_;
         if(var_327 != "BUILDERS_CLUB" && _loc3_ is ProductContainer)
         {
            (_loc3_ as ProductContainer).createCurrencyIndicators(page.viewer.catalog as HabboCatalog);
         }
         return _loc4_;
      }
      
      protected function loadGraphics(param1:class_1793) : void
      {
         var _loc3_:IStuffData = null;
         var _loc2_:Array = null;
         var _loc4_:StringArrayStuffData = null;
         if(param1 != null && !param1.disposed)
         {
            _loc3_ = null;
            if(var_3738 != -1)
            {
               _loc2_ = [];
               _loc2_.push("0");
               _loc2_.push(var_3738.toString());
               _loc2_.push(var_4414);
               _loc2_.push(_selectedGuildColor1);
               _loc2_.push(_selectedGuildColor2);
               _loc4_ = new StringArrayStuffData();
               _loc4_.setArray(_loc2_);
               _loc3_ = _loc4_;
            }
            param1.productContainer.initProductIcon(page.viewer.roomEngine,_loc3_);
         }
         param1.productContainer.grid = this;
      }
      
      private function onGuildSelected(param1:CatalogWidgetGuildSelectedEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var_3738 = param1.guildId;
         _selectedGuildColor1 = param1.color1;
         _selectedGuildColor2 = param1.color2;
         var_4414 = param1.badgeCode;
         _itemGrid.destroyGridItems();
         for each(var _loc2_ in page.offers)
         {
            var _loc3_:class_1812 = createGridItem(_loc2_.gridItem);
            _loc2_.gridItem.view = null;
            _loc2_.gridItem.grid = this;
            loadGraphics(_loc2_);
         }
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         var _loc4_:class_1793 = null;
         var _loc2_:* = null;
         for each(_loc2_ in page.offers)
         {
            if(_loc2_.gridItem == var_488 && _loc2_.gridItem.view != null)
            {
               _loc4_ = _loc2_;
            }
         }
         if(!_loc4_ || !_loc4_.product.isColorable)
         {
            return;
         }
         var _loc3_:class_1812 = _loc4_.gridItem.view;
         _loc4_.gridItem.view = null;
         var _loc5_:String = _loc4_.product.furnitureData.fullName.split("*")[0] + "*" + (param1.index + 1);
         for each(_loc2_ in page.offers)
         {
            if(_loc2_.product.furnitureData.fullName == _loc5_)
            {
               _loc2_.gridItem.view = _loc3_;
               select(_loc2_.gridItem,false);
               loadGraphics(_loc2_);
            }
         }
      }
      
      public function getCurrentItemColors() : Array
      {
         var _loc2_:class_1793 = null;
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.gridItem == var_488)
            {
               _loc2_ = _loc1_;
            }
         }
         if(!_loc2_ || !_loc2_.product.isColorable)
         {
            return [];
         }
         var _loc3_:String = _loc2_.product.furnitureData.fullName.split("*")[0];
         return itemColors[_loc3_];
      }
      
      private function getCurrentItemColourIndex() : int
      {
         var _loc2_:class_1793 = null;
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.gridItem == var_488)
            {
               _loc2_ = _loc1_;
            }
         }
         if(!_loc2_ || !_loc2_.product.isColorable)
         {
            return 0;
         }
         return Math.max(_loc2_.product.furnitureData.colourIndex - 1,0);
      }
   }
}

