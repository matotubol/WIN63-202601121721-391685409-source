package com.sulake.habbo.notifications.feed
{
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import com.sulake.habbo.notifications.feed.view.content.EntityFactory;
   import com.sulake.habbo.notifications.feed.view.content.class_3007;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class NotificationController
   {
      
      private var var_59:HabboNotifications;
      
      private var var_1011:NotificationView;
      
      private var var_925:FeedSettings;
      
      private var var_2146:EntityFactory;
      
      public function NotificationController(param1:HabboNotifications)
      {
         super();
         var_59 = param1;
         var_925 = new FeedSettings(this);
         var_1011 = new NotificationView(this,param1);
         var_2146 = new EntityFactory();
         var_59.roomSessionManager.events.addEventListener("RSE_CREATED",roomSessionStateEventHandler);
         var_59.roomSessionManager.events.addEventListener("RSE_STARTED",roomSessionStateEventHandler);
         var_59.roomSessionManager.events.addEventListener("RSE_ENDED",roomSessionStateEventHandler);
      }
      
      public function dispose() : void
      {
         if(var_1011)
         {
            var_1011.dispose();
            var_1011 = null;
         }
         var_59.roomSessionManager.events.removeEventListener("RSE_CREATED",roomSessionStateEventHandler);
         var_59.roomSessionManager.events.removeEventListener("RSE_STARTED",roomSessionStateEventHandler);
         var_59.roomSessionManager.events.removeEventListener("RSE_ENDED",roomSessionStateEventHandler);
         var_59 = null;
         if(var_925)
         {
            var_925.dispose();
            var_925 = null;
         }
         if(var_2146)
         {
            var_2146.dispose();
            var_2146 = null;
         }
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_CREATED":
            case "RSE_STARTED":
            case "RSE_ENDED":
               if(var_1011)
               {
                  var_1011.setGameMode(param1.session.isGameSession);
               }
         }
      }
      
      public function setFeedEnabled(param1:Boolean) : void
      {
         if(var_1011)
         {
            var_1011.setViewEnabled(param1);
         }
      }
      
      public function getSettings() : FeedSettings
      {
         return var_925;
      }
      
      public function updateFeedCategoryFiltering() : void
      {
      }
      
      public function addFeedItem(param1:int, param2:GenericNotificationItemData) : void
      {
         var _loc3_:class_3007 = var_2146.createNotificationEntity(param2);
         var_1011.addNotificationFeedItem(param1,_loc3_);
      }
      
      public function executeAction(param1:String) : void
      {
         if(param1.indexOf("http") == 0)
         {
            HabboWebTools.openWebPage(param1);
         }
      }
   }
}

