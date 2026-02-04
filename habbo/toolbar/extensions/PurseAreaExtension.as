package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.extensions.purse.PurseClubArea;
   import flash.geom.Rectangle;
   
   public class PurseAreaExtension implements class_13
   {
      
      private static const MENU_HELP:String = "HELP";
      
      private var _toolbar:HabboToolbar;
      
      private var _window:class_1812;
      
      private var _clubArea:PurseClubArea;
      
      private var _catalog:IHabboCatalog;
      
      public function PurseAreaExtension(param1:HabboToolbar, param2:IHabboCatalog)
      {
         super();
         _toolbar = param1;
         _window = _toolbar.windowManager.buildFromXML(param1.assets.getAssetByName("purse_xml").content as XML) as class_1812;
         _window.procedure = windowProcedure;
         _clubArea = new PurseClubArea(param1,_window as class_1812);
         _catalog = param2;
         _catalog.events.addEventListener("catalog_purse_credit_balance",onCreditsBalance);
         _catalog.events.addEventListener("catalog_purse_activity_point_balance",onPointBalance);
         updateCreditAndPointValues();
         param1.extensionView.attachExtension("purse",_window,0);
         var _loc3_:class_1741 = _window.findChildByName("credit_count");
         _toolbar.windowManager.registerHintWindow("credit_count",_loc3_);
         refreshIndicators();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _clubArea.dispose();
         _catalog = null;
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
      
      public function getClubArea() : PurseClubArea
      {
         return _clubArea;
      }
      
      private function updateCreditAndPointValues() : void
      {
         var _loc2_:class_1741 = null;
         var _loc3_:class_1741 = null;
         var _loc5_:IItemListWindow = null;
         var _loc1_:class_1741 = _window.findChildByName("credit_count");
         if(_loc1_ != null)
         {
            _loc1_.caption = _catalog.getPurse().credits.toString();
         }
         var _loc4_:class_1741 = _window.findChildByName("ducket_count");
         if(_loc4_ != null)
         {
            _loc4_.caption = _catalog.getPurse().getActivityPointsForType(0).toString();
         }
         if(_toolbar.getBoolean("diamonds.enabled"))
         {
            _loc2_ = _window.findChildByName("diamond_count");
            if(_loc2_)
            {
               _loc2_.caption = _catalog.getPurse().getActivityPointsForType(5).toString();
            }
         }
         else
         {
            _loc3_ = _window.findChildByName("diamond_count_button");
            _loc5_ = _window.findChildByName("purse_itemlist") as IItemListWindow;
            if(_loc3_ && _loc5_)
            {
               _loc5_.removeListItem(_loc3_);
            }
         }
      }
      
      public function onCreditsBalance(param1:PurseEvent) : void
      {
         var _loc3_:String = param1.balance.toString();
         var _loc2_:class_1741 = _window.findChildByName("credit_count");
         if(_loc2_ != null)
         {
            _loc2_.caption = _loc3_.toString();
         }
      }
      
      public function onPointBalance(param1:PurseEvent) : void
      {
         var _loc2_:class_1741 = null;
         var _loc3_:String = null;
         switch(param1.activityPointType)
         {
            case 0:
               _loc2_ = _window.findChildByName("ducket_count");
               break;
            case 5:
               _loc2_ = _window.findChildByName("diamond_count");
         }
         if(_loc2_ != null)
         {
            _loc3_ = param1.balance.toString();
            _loc2_.caption = _loc3_.toString();
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc2_:Rectangle = null;
         var _loc3_:class_1741 = _window.findChildByName(param1);
         if(_loc3_)
         {
            _loc2_ = _loc3_.rectangle;
            _loc2_.x += _window.desktop.width - _window.width;
            _loc2_.y += _window.y;
         }
         return _loc2_;
      }
      
      public function getIcon(param1:String) : class_1741
      {
         return _window.findChildByName(param1);
      }
      
      public function refreshIndicators() : void
      {
         var _loc1_:Boolean = _catalog.getEarnings().showingIndicator;
         earningsUnseenIndicator.visible = _loc1_;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _toolbar.windowManager.hideMatchingHint(param2.name);
         switch(param2.name)
         {
            case "earnings_button":
               _toolbar.catalog.openVault();
               break;
            case "hc_join_button":
               _toolbar.catalog.openClubCenter();
               break;
            case "help_button":
               _toolbar.toggleWindowVisibility("HELP");
               break;
            case "settings_button":
               _toolbar.toggleSettingVisibility();
               break;
            case "credit_count_button":
               _catalog.openCreditsHabblet();
               break;
            case "ducket_count_button":
               _catalog.openCatalogPage("ducket_info");
               break;
            case "diamond_count_button":
               _catalog.openCatalogPage("loyalty_info");
               break;
            case "logout_button":
               _toolbar.reboot();
         }
      }
      
      private function get earningsUnseenIndicator() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("earnings_unseen_indicator") as IStaticBitmapWrapperWindow;
      }
   }
}

