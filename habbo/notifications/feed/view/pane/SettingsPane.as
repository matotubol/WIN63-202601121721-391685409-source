package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.notifications.feed.FeedSettings;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class SettingsPane extends AbstractPane
   {
      
      public function SettingsPane(param1:String, param2:NotificationView, param3:class_1812)
      {
         super(param1,param2,param3,2);
         applySettingsToView();
         _window.procedure = onWindowEventProc;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      private function applySettingsToView() : void
      {
         var _loc1_:FeedSettings = var_172.controller.getSettings();
         _loc1_.getVisibleFeedCategories();
      }
      
      public function onWindowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:FeedSettings = null;
         var _loc5_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_172.controller.getSettings();
            for each(var _loc4_ in param2.tags)
            {
               switch(_loc4_)
               {
                  case "ME":
                     _loc5_ = 0;
                     break;
                  case "HOTEL":
                     _loc5_ = 2;
                     break;
                  case "FRIENDS":
                     _loc5_ = 1;
               }
               _loc3_.toggleVisibleFeedCategory(_loc5_);
            }
            applySettingsToView();
         }
      }
   }
}

