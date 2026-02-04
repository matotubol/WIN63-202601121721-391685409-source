package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_3087;
   
   public class BadgesView implements IInventoryView
   {
      
      private static const GRID_UPDATE_DELAY_MS:int = 100;
      
      private static const GRID_ITEMS_PER_UPDATE:int = 25;
      
      private var _windowManager:class_38;
      
      private var var_18:class_1812;
      
      private var var_36:BadgesModel;
      
      private var var_2473:IItemGridWindow;
      
      private var _disposed:Boolean = false;
      
      private var var_265:Boolean = false;
      
      private var var_608:BadgeGridView;
      
      public function BadgesView(param1:BadgesModel, param2:class_38, param3:class_40)
      {
         super();
         var_36 = param1;
         _windowManager = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_18 && var_18.parent != null && var_18.visible;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _windowManager = null;
         var_36 = null;
         if(var_608 != null)
         {
            var_608.dispose();
            var_608 = null;
         }
         var_2473 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return null;
         }
         return var_18;
      }
      
      public function updateAll(param1:String) : void
      {
         updateListViews(param1);
         updateActionView();
      }
      
      public function updateActionView() : void
      {
         var _loc2_:* = undefined;
         if(!var_265)
         {
            return;
         }
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var _loc3_:class_1775 = var_18.findChildByName("wearBadge_button") as class_1775;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Badge = var_36.getSelectedBadge();
         if(_loc1_ == null)
         {
            _loc3_.disable();
            setBadgeName(null);
            var_18.findChildByName("badge_image").visible = false;
         }
         else
         {
            if(_loc1_.isInUse)
            {
               _loc3_.caption = "${inventory.badges.clearbadge}";
            }
            else
            {
               _loc3_.caption = "${inventory.badges.wearbadge}";
            }
            setBadgeName(_loc1_.badgeName);
            class_3087(class_2010(var_18.findChildByName("badge_image")).widget).badgeId = _loc1_.badgeId;
            var_18.findChildByName("badge_image").visible = true;
            _loc2_ = var_36.getBadges(1);
            if(_loc2_ != null && _loc2_.length >= var_36.getMaxActiveCount() && !_loc1_.isInUse)
            {
               _loc3_.disable();
            }
            else
            {
               _loc3_.enable();
            }
         }
      }
      
      private function init() : void
      {
         var_18 = var_36.controller.view.getView("badges");
         var_18.procedure = windowEventProc;
         var_18.visible = false;
         var _loc3_:class_1741 = var_18.findChildByName("wearBadge_button");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWearBadgeClick);
         }
         var _loc1_:IItemGridWindow = var_18.findChildByName("inactive_items") as IItemGridWindow;
         var _loc2_:IItemListWindow = var_18.findChildByName("item_grid_pages") as IItemListWindow;
         _loc2_.enableScrollByDragging = true;
         var_608 = new BadgeGridView(this,_loc1_,_loc2_);
         var_2473 = var_18.findChildByName("active_items") as IItemGridWindow;
         var_18.findChildByName("filter").caption = "";
         var_18.findChildByName("clear_filter_button").visible = false;
         var_265 = true;
      }
      
      private function updateListViews(param1:String) : void
      {
         var _loc2_:Badge = null;
         var _loc3_:int = 0;
         if(!var_265)
         {
            return;
         }
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var_2473.removeGridItems();
         var_608.setFilter(0,param1,param1);
         var_608.setItems(var_36.getBadges(0));
         var _loc4_:Vector.<Badge> = var_36.getBadges(1);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as Badge;
            var_2473.addGridItem(_loc2_.window);
            _loc3_++;
         }
      }
      
      private function setBadgeName(param1:String) : void
      {
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var _loc2_:ITextWindow = var_18.findChildByName("badgeName") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:WindowKeyboardEvent = null;
         if(param1.type == "WME_CLICK")
         {
            var _loc4_:* = param2.name;
            if("clear_filter_button" === _loc4_)
            {
               var_18.findChildByName("filter").caption = "";
               param2.visible = false;
               updateAll(null);
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc3_ = param1 as WindowKeyboardEvent;
            _loc4_ = param2.name;
            if("filter" === _loc4_)
            {
               var_18.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc3_.keyCode == 13)
               {
                  updateAll(param2.caption);
               }
            }
         }
      }
      
      private function onWearBadgeClick(param1:class_1758) : void
      {
         var _loc2_:Badge = var_36.getSelectedBadge();
         if(_loc2_ != null)
         {
            var_36.toggleBadgeWearing(_loc2_.badgeId);
         }
      }
   }
}

