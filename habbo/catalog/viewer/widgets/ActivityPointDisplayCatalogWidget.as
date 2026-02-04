package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.purse.class_2085;
   
   public class ActivityPointDisplayCatalogWidget extends CatalogWidget implements class_2612
   {
      
      public function ActivityPointDisplayCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         _loc1_.events.removeEventListener("catalog_purse_update",onPurseUpdate);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("activityPointDisplayWidget");
         _window.findChildByName("activity_points_txt").caption = "";
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         _loc1_.events.addEventListener("catalog_purse_update",onPurseUpdate);
         return updateAmount();
      }
      
      private function updateAmount() : Boolean
      {
         if(disposed)
         {
            return false;
         }
         if(_window == null)
         {
            return false;
         }
         var _loc3_:int = getActivityPointType();
         if(_loc3_ < 1 || !class_2085.isVisible(_loc3_))
         {
            _window.visible = false;
            return false;
         }
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         _loc1_.localization.registerParameter("catalog.purchase.youractivitypoints","activitypoints","" + _loc1_.getPurse().getActivityPointsForType(_loc3_));
         _loc1_.localization.registerParameter("catalog.purchase.youractivitypoints","currencyname",_loc1_.getActivityPointName(_loc3_));
         _window.findChildByName("activity_points_txt").caption = _loc1_.localization.getLocalization("catalog.purchase.youractivitypoints");
         var _loc4_:class_1741 = _window.findChildByName("activity_point_icon");
         _loc4_.style = class_2085.getIconStyleFor(_loc3_,_loc1_,true);
         _window.visible = true;
         return true;
      }
      
      private function onPurseUpdate(param1:PurseUpdateEvent) : void
      {
         updateAmount();
      }
      
      private function getActivityPointType() : int
      {
         if(page == null || page.offers == null)
         {
            return 0;
         }
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.activityPointType > 0)
            {
               return _loc1_.activityPointType;
            }
         }
         return 0;
      }
   }
}

