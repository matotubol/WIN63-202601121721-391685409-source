package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.catalog.recycler.DealPrizeContainer;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.PrizeContainer;
   import com.sulake.habbo.catalog.recycler.PrizeLevelContainer;
   import com.sulake.habbo.catalog.recycler.RecycleRewardDisplayWrapper;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.class_2253;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.widgets.class_1902;
   import flash.events.TimerEvent;
   
   public class RecyclerPrizesCatalogWidget extends CatalogWidget implements class_2612, IItemGrid
   {
      
      private static const STAR_LEVELS:Array = ["bronze","silver","gold","diamond","ruby","pink","green","grey"];
      
      private var var_1475:Array;
      
      private var _itemList:IItemListWindow;
      
      private var _gridItemLayout:XML;
      
      private var _levelItemLayout:XML;
      
      private var var_488:class_2253;
      
      public function RecyclerPrizesCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1475 = null;
         _itemList = null;
         _gridItemLayout = null;
         _levelItemLayout = null;
         var_488 = null;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _itemList = _window.findChildByName("itemList") as IItemListWindow;
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = null.content as XML;
         _loc2_ = page.viewer.catalog.assets.getAssetByName("recyclerPrizesWidgetLevelItem") as XmlAsset;
         _levelItemLayout = null.content as XML;
         var _loc1_:Array = recycler.getPrizeTable(onPrizesReceived);
         if(_loc1_ != null)
         {
            onPrizesReceived(_loc1_);
         }
         return true;
      }
      
      private function onPrizesReceived(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1475 = param1;
         populateItemGrid();
         if(var_1475.length > 0 && var_1475[0].prizes.length > 0)
         {
            select(var_1475[0].prizes[0] as class_2253,false);
         }
      }
      
      private function populateItemGrid(param1:TimerEvent = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_1475.length)
         {
            createLevelItem(var_1475[_loc2_]);
            _loc2_++;
         }
      }
      
      private function createLevelItem(param1:PrizeLevelContainer) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PrizeContainer = null;
         var _loc3_:class_1812 = page.viewer.catalog.windowManager.buildFromXML(_levelItemLayout) as class_1812;
         _itemList.addListItem(_loc3_);
         var _loc4_:class_1741 = _loc3_.findChildByName("level_title");
         _loc4_.caption = page.viewer.catalog.localization.getLocalization("recycler.prizes.category." + param1.prizeLevelId);
         _loc4_ = _loc3_.findChildByName("level_chances");
         if(param1.prizeLevelId == 1)
         {
            _loc4_.visible = false;
         }
         else
         {
            _loc4_.visible = true;
            _loc4_.caption = page.viewer.catalog.localization.getLocalizationWithParams("recycler.prizes.odds","","odds","1:" + param1.probabilityDenominator);
         }
         _loc3_.findChildByName("level_splitter").visible = param1.prizeLevelId > 1;
         IStaticBitmapWrapperWindow(_loc3_.findChildByName("star_icon")).assetUri = "star_small_" + STAR_LEVELS[param1.prizeLevelId - 1];
         var _loc2_:IItemGridWindow = _loc3_.findChildByName("itemGrid") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < param1.prizes.length)
         {
            _loc6_ = param1.prizes[_loc5_];
            createPrizeItem(_loc6_,_loc2_);
            _loc5_++;
         }
      }
      
      private function createPrizeItem(param1:PrizeContainer, param2:IItemGridWindow) : void
      {
         if(param1 == null || param2 == null || Boolean(param2.disposed))
         {
            return;
         }
         var _loc3_:class_1812 = page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as class_1812;
         _loc3_.findChildByName("clubLevelIcon").visible = false;
         param1.view = _loc3_;
         param1.grid = this;
         param1.setIcon(page.viewer.roomEngine);
         param2.addGridItem(_loc3_);
         param2.height = param2.scrollableRegion.height;
         if(param1 is DealPrizeContainer)
         {
            param2.width = param2.scrollableRegion.width;
         }
      }
      
      public function select(param1:class_2253, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_488 != null)
         {
            var_488.deactivate();
         }
         var_488 = param1;
         param1.activate();
         var _loc3_:class_1812 = window.findChildByName("productView") as class_1812;
         var _loc5_:PrizeContainer = param1 as PrizeContainer;
         var _loc4_:String = "";
         viewProduct(page.viewer.roomEngine,_loc3_,_loc5_.productItemType,_loc5_.productItemTypeId,_loc5_.title,_loc4_);
      }
      
      public function viewProduct(param1:IRoomEngine, param2:class_1812, param3:String, param4:int, param5:String, param6:String) : void
      {
         var _loc7_:class_2010 = param2.findChildByName("product_viewer") as class_2010;
         var _loc8_:class_1902 = _loc7_.widget as class_1902;
         _loc8_.productInfo = new RecycleRewardDisplayWrapper(param3,param4);
         param2.findChildByName("ctlg_product_name").caption = param5;
         param2.findChildByName("ctlg_description").caption = param6 ? param6 : "";
      }
      
      public function startDragAndDrop(param1:class_2253) : Boolean
      {
         return false;
      }
      
      private function get recycler() : IRecycler
      {
         return page.viewer.catalog.getRecycler();
      }
   }
}

