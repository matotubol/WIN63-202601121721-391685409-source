package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_2468;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class SingularNotificationController implements class_31
   {
      
      private static const MODERATION_DISCLAIMER_DELAY_MS:int = 5000;
      
      private var _notifications:HabboNotifications;
      
      private var var_2415:Array;
      
      private var var_2026:class_55;
      
      private var var_1222:HabboNotificationViewManager;
      
      private var var_1992:HabboAlertDialogManager;
      
      private var var_4057:Boolean;
      
      private var var_1464:ClubGiftNotification;
      
      private var var_2002:Vector.<NewFeatureNotification>;
      
      private var var_1139:SafetyLockedNotification;
      
      private var var_5272:Dictionary;
      
      private var var_837:Timer;
      
      private var var_1134:Boolean;
      
      public function SingularNotificationController(param1:HabboNotifications)
      {
         super();
         _notifications = param1;
         var_2415 = [];
         var_2026 = new class_55();
         var_5272 = new Dictionary();
         var_1992 = new HabboAlertDialogManager(_notifications.windowManager,_notifications.localization,_notifications.habboHelp);
         var _loc8_:IAsset = _notifications.assetLibrary.getAssetByName("habbo_notifications_config_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc8_);
         if(_loc2_ != null)
         {
            class_2468.parseVariableList(XML(_loc2_.content).children(),var_2026);
         }
         var _loc6_:class_55 = var_2026["styles"];
         if(_loc6_ != null)
         {
            var _loc5_:int = 0;
            while(0 < _loc6_.length)
            {
               var _loc7_:class_55 = _loc6_.getWithIndex(0);
               if(_loc7_["icon"] != null)
               {
                  var _loc3_:BitmapDataAsset = _notifications.assetLibrary.getAssetByName(null["icon"]) as BitmapDataAsset;
                  var _loc4_:BitmapData = null.content as BitmapData;
                  null["icon"] = null;
               }
               _loc5_++;
            }
         }
         var_1222 = new HabboNotificationViewManager(_notifications,_notifications.assetLibrary,_notifications.windowManager,_notifications.toolBar,var_2026["styles"],var_2026);
         _notifications.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImage);
         _notifications.registerUpdateReceiver(this,2);
         setTimeout(maybeShowNewFeatureNotification,2000);
      }
      
      public function get alertDialogManager() : HabboAlertDialogManager
      {
         return var_1992;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function dispose() : void
      {
         if(var_837)
         {
            var_837.removeEventListener("timerComplete",onShowModerationDisclaimer);
            var_837 = null;
         }
         if(var_1222 != null)
         {
            var_1222.dispose();
            var_1222 = null;
         }
         if(var_1992 != null)
         {
            var_1992.dispose();
            var_1992 = null;
         }
         if(var_1464 != null)
         {
            var_1464.dispose();
            var_1464 = null;
         }
         if(var_2002 != null)
         {
            for each(var _loc1_ in var_2002)
            {
               _loc1_.dispose();
            }
            var_2002 = null;
         }
         if(var_1139 != null)
         {
            var_1139.dispose();
            var_1139 = null;
         }
         if(_notifications != null)
         {
            _notifications.removeUpdateReceiver(this);
            _notifications = null;
         }
         var_1134 = true;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:HabboNotificationItem = null;
         if(var_2415.length > 0 && var_1222.isSpaceAvailable())
         {
            _loc2_ = getNextItemFromQueue();
            if(!var_1222.showItem(_loc2_))
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function addItem(param1:String, param2:String, param3:BitmapData, param4:String = null, param5:String = null, param6:String = null, param7:Array = null) : int
      {
         if(_notifications.disabled)
         {
            return 0;
         }
         var _loc9_:class_55 = var_2026["styles"];
         if(_loc9_ == null)
         {
            return 0;
         }
         var _loc11_:class_55 = _loc9_[param2];
         if(_loc11_ == null)
         {
            return 0;
         }
         var _loc10_:HabboNotificationItemStyle = new HabboNotificationItemStyle(_loc11_,param3,param4,true,param5,param7 == null ? [] : param7,param2);
         if(param6)
         {
            _loc10_.internalLink = param6;
         }
         var _loc8_:HabboNotificationItem = new HabboNotificationItem(param1,_loc10_,this);
         var_2415.push(_loc8_);
         return var_2415.length;
      }
      
      private function getNextItemFromQueue() : HabboNotificationItem
      {
         var _loc1_:Array = var_2415.splice(0,1);
         return _loc1_[0] as HabboNotificationItem;
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         _notifications.localization.registerParameter("soundmachine.notification.playing","songname",param1);
         _notifications.localization.registerParameter("soundmachine.notification.playing","songauthor",param2);
         var _loc3_:ILocalization = _notifications.localization.getLocalizationRaw("soundmachine.notification.playing");
         if(_loc3_)
         {
            addItem(_loc3_.value,"soundmachine",null);
         }
      }
      
      public function onInternalLink(param1:String) : void
      {
         _notifications.createLinkEvent(param1);
      }
      
      private function onShowModerationDisclaimer(param1:TimerEvent) : void
      {
         var_837.removeEventListener("timerComplete",onShowModerationDisclaimer);
         var_837 = null;
         showModerationDisclaimer();
      }
      
      public function showModerationDisclaimer() : void
      {
         var _loc1_:String = null;
         if(RoomEnterEffect.isRunning())
         {
            if(var_837 == null)
            {
               var_837 = new Timer(RoomEnterEffect.totalRunningTime + 5000,1);
               var_837.addEventListener("timerComplete",onShowModerationDisclaimer);
               var_837.start();
            }
         }
         else if(!var_4057)
         {
            _loc1_ = _notifications.localization.getLocalization("mod.chatdisclaimer","NA");
            this.addItem(_loc1_,"info",null);
            var_4057 = true;
            class_21.log("DISPLAYED MOD INFO: " + _loc1_);
         }
      }
      
      public function showClubGiftNotification(param1:int) : void
      {
         if(var_1464 && (var_1464.visible || var_1464.isCancelled))
         {
            return;
         }
         var_1464 = new ClubGiftNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function maybeShowNewFeatureNotification() : void
      {
         var_2002 = new Vector.<NewFeatureNotification>();
         var _loc1_:Array = _notifications.getProperty("notifications.new_feature.active").split(",");
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.length != 0)
            {
               var_2002.push(new NewFeatureNotification(_notifications.assets,_notifications.windowManager,_notifications.toolBar,_notifications.localization,_notifications,_loc2_));
            }
         }
      }
      
      public function showSafetyLockedNotification(param1:int) : void
      {
         if(var_1139 && var_1139.visible)
         {
            return;
         }
         var_1139 = new SafetyLockedNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function hideSafetyLockedNotification() : void
      {
         if(!var_1139)
         {
            return;
         }
         var_1139.dispose();
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
         if(param1 != null && this.var_1222 != null)
         {
            var_1222.replaceIcon(param1);
         }
      }
   }
}

