package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   
   public class UserBadgeSelectorCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private static const BADGE_GRID_ITEM_NAME:String = "badgeGridItem";
      
      private var _itemGrid:IItemGridWindow;
      
      private var _gridItemLayout:XML;
      
      private var _catalog:HabboCatalog;
      
      private var var_1727:int = -1;
      
      private var var_3292:IMessageEvent;
      
      private var var_1801:Array;
      
      public function UserBadgeSelectorCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
         var_1801 = _catalog.getProperty("badge.display.excluded.badgeCodes").split(",");
      }
      
      override public function dispose() : void
      {
         if(var_3292)
         {
            _catalog.connection.removeMessageEvent(var_3292);
         }
         _catalog = null;
         var_1801 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         _itemGrid = _window.findChildByName("badgeGrid") as IItemGridWindow;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("badgeGridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         resetBadgeSelectorGrid();
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var_3292 = new BadgesEvent(onUserBadgesUpdated);
         _catalog.connection.addMessageEvent(var_3292);
         return true;
      }
      
      private function resetBadgeSelectorGrid() : void
      {
         _itemGrid.destroyGridItems();
         var _loc2_:int = 0;
         for each(var _loc1_ in _catalog.inventory.getAllMyBadgeIds(var_1801))
         {
            _itemGrid.addGridItem(createGridItem(_loc1_,_loc2_++));
         }
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         if(page.offers.length == 0)
         {
            return;
         }
         var _loc2_:class_1793 = page.offers[0];
         events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
         events.dispatchEvent(new SelectProductEvent(_loc2_));
      }
      
      protected function createGridItem(param1:String, param2:int) : class_1812
      {
         var _loc4_:class_1812 = page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as class_1812;
         var _loc3_:class_3087 = class_3087(class_2010(_loc4_.findChildByName("badgeWidget")).widget);
         _loc3_.type = "normal";
         _loc3_.badgeId = param1;
         _loc4_.id = param2;
         _loc4_.name = "badgeGridItem";
         _loc4_.procedure = badgeGridItemWindowProc;
         return _loc4_;
      }
      
      private function setBadgeGridItemSelectionBg(param1:int, param2:Boolean) : void
      {
         var _loc3_:class_1812 = class_1812(_itemGrid.getGridItemAt(param1));
         if(_loc3_ != null)
         {
            class_1993(_loc3_.findChildByName("bg")).style = param2 ? 0 : 2;
         }
      }
      
      private function getBadgeIdOfGridItem(param1:int) : String
      {
         var _loc3_:class_1812 = class_1812(_itemGrid.getGridItemAt(param1));
         var _loc2_:class_3087 = class_3087(class_2010(_loc3_.findChildByName("badgeWidget")).widget);
         return _loc2_.badgeId;
      }
      
      private function badgeGridItemWindowProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "badgeGridItem")
         {
            if(var_1727 != -1)
            {
               setBadgeGridItemSelectionBg(var_1727,false);
            }
            var_1727 = param2.id;
            if(var_1727 < _catalog.inventory.getAllMyBadgeIds(var_1801).length)
            {
               setBadgeGridItemSelectionBg(var_1727,true);
               events.dispatchEvent(new SetExtraPurchaseParameterEvent(getBadgeIdOfGridItem(var_1727)));
               page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData()));
            }
         }
      }
      
      private function getPreviewerStuffData() : IStuffData
      {
         var _loc1_:Array = [];
         _loc1_.push("0");
         _loc1_.push(_catalog.inventory.getAllMyBadgeIds(var_1801)[var_1727]);
         _loc1_.push("");
         _loc1_.push("");
         var _loc2_:StringArrayStuffData = new StringArrayStuffData();
         _loc2_.setArray(_loc1_);
         return _loc2_;
      }
      
      private function onUserBadgesUpdated(param1:IMessageEvent) : void
      {
         resetBadgeSelectorGrid();
      }
   }
}

