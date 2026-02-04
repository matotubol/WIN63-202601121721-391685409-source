package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2466;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import package_3.class_3489;
   
   public class GuildSelectorCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private static const CATALOG_PAGE_LAYOUT_WIDGET_NAME:String = "guild_selector";
      
      private static const const_982:String = "guild_selector_widget_item";
      
      private static const GUILD_COLORS_BMP_BORDER_COLOR:uint = 0;
      
      private static const GUILD_COLORS_BMP_BORDER_WIDTH:int = 1;
      
      private static const GUILD_COLORS_BMP_HEIGHT:int = 14;
      
      private static const GUILD_COLORS_BMP_WIDTH:int = 21;
      
      private var var_382:class_2466;
      
      protected var var_1365:GuildMembershipsController;
      
      private var var_3070:Array;
      
      private var var_2161:class_1741;
      
      private var _membersOnlyInfo:class_1741;
      
      private var _selection:int = -1;
      
      public function GuildSelectorCatalogWidget(param1:class_1812, param2:GuildMembershipsController)
      {
         super(param1);
         var_1365 = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
            page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(-1,"","",""));
            if(var_382)
            {
               var_382.procedure = null;
               var_382 = null;
            }
            var_2161 = null;
            _membersOnlyInfo = null;
            if(var_1365)
            {
               var_1365.unregisterGuildSelectorWidget(this);
               var_1365 = null;
            }
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         attachWidgetView("guildSelectorWidget");
         var_2161 = window.findChildByName("guild_selector");
         _membersOnlyInfo = window.findChildByName("members_only");
         var _loc1_:class_1741 = window.findChildByName("find_groups_button");
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onFindGroups);
         }
         var_382 = _window.findChildByName("guild_selector") as class_2466;
         if(var_382)
         {
            var_382.procedure = dropMenuEventProc;
         }
         else
         {
            class_21.log("ERROR: Missing \'guild_selector\' itemlist_dropmenu component from page layout xml");
         }
         var_2161.visible = false;
         _membersOnlyInfo.visible = false;
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var_1365.registerGuildSelectorWidget(this);
         events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
      }
      
      public function populateAndSelectFavorite(param1:Array) : void
      {
         var_3070 = filterGroupMemberships(param1);
         var _loc3_:* = param1.length > 0;
         events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",_loc3_));
         var_2161.visible = _loc3_;
         _membersOnlyInfo.visible = !_loc3_;
         var _loc6_:int = var_382.numMenuItems;
         var _loc4_:int = 0;
         while(0 < _loc6_)
         {
            var_382.removeMenuItemAt(0);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(0 < var_3070.length)
         {
            var _loc7_:class_3489 = var_3070[0];
            var_382.addMenuItem(createDropmenuItemWindow(null));
            if(null.favourite)
            {
               var _loc2_:int = 0;
            }
            _loc5_++;
         }
         if(_selection == -1)
         {
            if(var_382.numMenuItems > 0)
            {
               var_382.selection = 0;
            }
         }
         else
         {
            var_382.selection = _selection;
         }
      }
      
      protected function filterGroupMemberships(param1:Array) : Array
      {
         return param1;
      }
      
      public function selectFirstOffer() : void
      {
         if(page && page.offers && page.offers.length > 0)
         {
            page.selectOffer(Offer(page.offers[0]).offerId);
         }
      }
      
      private function dropMenuEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:* = param1.type;
         if("WE_SELECTED" === _loc3_)
         {
            selectFromDropList(var_382.selection);
            _selection = var_382.selection;
         }
      }
      
      private function selectFromDropList(param1:int) : void
      {
         if(param1 > -1)
         {
            var _loc2_:class_3489 = var_3070[param1];
            selectGroup(null);
         }
      }
      
      protected function selectGroup(param1:class_3489) : void
      {
         page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(param1.groupId,param1.primaryColor,param1.secondaryColor,param1.badgeCode));
         page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData(param1.groupId,param1.primaryColor,param1.secondaryColor,param1.badgeCode)));
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(param1.groupId.toString()));
      }
      
      private function createGuildColorsBitmap(param1:uint, param2:uint) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(21,14,false,0);
         var _loc5_:int = _loc3_.width / 2 + 1;
         var _loc6_:Rectangle = new Rectangle();
         _loc6_.left = 1;
         _loc6_.top = 1;
         _loc6_.right = _loc5_;
         _loc6_.bottom = _loc3_.height - 1;
         var _loc4_:Rectangle = new Rectangle();
         _loc4_.left = _loc5_;
         _loc4_.top = 1;
         _loc4_.right = _loc3_.width - 1;
         _loc4_.bottom = _loc3_.height - 1;
         _loc3_.fillRect(_loc6_,param1);
         _loc3_.fillRect(_loc4_,param2);
         return _loc3_;
      }
      
      private function createDropmenuItemWindow(param1:class_3489) : class_1741
      {
         var _loc4_:BitmapData = createGuildColorsBitmap(parseInt(param1.primaryColor,16),parseInt(param1.secondaryColor,16));
         var _loc2_:XML = page.viewer.catalog.assets.getAssetByName("guild_selector_widget_item").content as XML;
         var _loc6_:class_1812 = page.viewer.catalog.windowManager.buildFromXML(_loc2_) as class_1812;
         var _loc3_:class_2251 = _loc6_.findChildByName("guild_colors") as class_2251;
         var _loc5_:ILabelWindow = _loc6_.findChildByName("guild_name") as ILabelWindow;
         _loc3_.bitmap = _loc4_;
         _loc5_.caption = param1.groupName;
         return _loc6_;
      }
      
      private function onFindGroups(param1:WindowMouseEvent) : void
      {
         if(page && page.viewer && page.viewer.catalog && page.viewer.catalog.navigator)
         {
            page.viewer.catalog.navigator.performGuildBaseSearch();
         }
      }
      
      private function getPreviewerStuffData(param1:uint, param2:String, param3:String, param4:String) : IStuffData
      {
         var _loc5_:Array = [];
         _loc5_.push("0");
         _loc5_.push(param1.toString());
         _loc5_.push(param4);
         _loc5_.push(param2);
         _loc5_.push(param3);
         var _loc6_:StringArrayStuffData = new StringArrayStuffData();
         _loc6_.setArray(_loc5_);
         return _loc6_;
      }
   }
}

