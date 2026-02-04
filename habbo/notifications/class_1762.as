package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import com.sulake.habbo.notifications.singular.MOTDNotification;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import package_10.class_2104;
   import package_10.class_3423;
   import package_100.class_3006;
   import package_105.class_2486;
   import package_105.class_2838;
   import package_105.class_3182;
   import package_109.class_2433;
   import package_127.NftEmeraldConvertResultMessageEvent;
   import package_132.class_2481;
   import package_136.TreasureHuntWinnerInfo;
   import package_136.class_2513;
   import package_136.class_3404;
   import package_136.class_3522;
   import package_165.class_2808;
   import package_165.class_3132;
   import package_165.class_3638;
   import package_168.class_3521;
   import package_176.class_3039;
   import package_20.class_2084;
   import package_23.class_3074;
   import package_23.class_3442;
   import package_23.class_3610;
   import package_23.class_3617;
   import package_26.class_1799;
   import package_26.class_1961;
   import package_26.class_2358;
   import package_26.class_2494;
   import package_26.class_2660;
   import package_26.class_2865;
   import package_26.class_3240;
   import package_26.class_3310;
   import package_26.class_3441;
   import package_3.class_1808;
   import package_3.class_3234;
   import package_33.class_1973;
   import package_37.class_1865;
   import package_39.class_1980;
   import package_4.class_2005;
   import package_44.class_1913;
   import package_46.class_1918;
   import package_46.class_2949;
   import package_46.class_3113;
   import package_46.class_3161;
   import package_46.class_3231;
   import package_46.class_3338;
   import package_48.class_1935;
   import package_54.class_3653;
   import package_6.class_3450;
   import package_74.class_2420;
   import package_74.class_2588;
   import package_74.class_3068;
   import package_74.class_3226;
   import package_75.class_2539;
   import package_75.class_2628;
   import package_75.class_2641;
   import package_75.class_3411;
   import package_79.class_2360;
   import package_79.class_2774;
   import package_79.class_2835;
   import package_79.class_3519;
   import package_8.class_2234;
   import package_87.class_2569;
   import package_90.class_3229;
   import package_91.class_2340;
   
   [SecureSWF(rename="true")]
   public class class_1762 implements class_259
   {
      
      private var _notifications:HabboNotifications;
      
      private var _communication:class_57;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _bufferedTreasureHuntWinnerInfo:TreasureHuntWinnerInfo;
      
      private const CALL_FOR_HELP_NOTIFICATION_TYPE:String = "cfh.created";
      
      public function class_1762(param1:HabboNotifications, param2:class_57)
      {
         super();
         _notifications = param1;
         _communication = param2;
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_3610(onLoginFailedHotelClosed));
         addMessageEvent(new class_2569(onPetReceived));
         addMessageEvent(new class_2358(onClubGiftNotification));
         addMessageEvent(new class_3653(onRoomEnter));
         addMessageEvent(new class_1799(onLevelUp));
         addMessageEvent(new class_3132(onTreasureHuntFirstWinner));
         addMessageEvent(new class_2865(onNotificationDialogMessageEvent));
         addMessageEvent(new class_3234(onRespectNotification));
         addMessageEvent(new class_1973(onChatStyleNotification));
         addMessageEvent(new class_3310(onPetLevelNotification));
         addMessageEvent(new class_3638(onTreasureHuntUpdate));
         addMessageEvent(new class_1808(onAccountSafetyLockStatusChanged));
         addMessageEvent(new class_2588(onModMessageEvent));
         addMessageEvent(new class_3441(onRestoreClientMessageEvent));
         addMessageEvent(new class_3423(onClubGiftSelected));
         addMessageEvent(new class_3442(onHotelClosed));
         addMessageEvent(new class_3226(onBanInfoMessageEvent));
         addMessageEvent(new class_1935(onRecyclerFinished));
         addMessageEvent(new class_1961(onActivityPointNotification));
         addMessageEvent(new class_3006(onRoomMessagesNotification));
         addMessageEvent(new class_2494(onBroadcastMessageEvent));
         addMessageEvent(new class_2660(onMOTD));
         addMessageEvent(new class_3068(onModCautionEvent));
         addMessageEvent(new class_2808(onTreasureHuntFail));
         addMessageEvent(new class_2420(onUserBannedMessageEvent));
         addMessageEvent(new class_3617(onHotelMaintenance));
         addMessageEvent(new class_3240(onInfoFeedEnable));
         addMessageEvent(new class_1865(onPetRespectFailed));
         addMessageEvent(new class_1980(onRoomEnter));
         addMessageEvent(new class_3074(onHotelClosing));
         addMessageEvent(new class_2005(onUserObject));
         addMessageEvent(new class_3521(onBadgeReceived));
         addMessageEvent(new NftEmeraldConvertResultMessageEvent(onNftEmeraldConvertResult));
         _notifications.activate();
      }
      
      private function getHuntName(param1:String) : String
      {
         return _notifications.localization.getLocalization("treasure_hunt." + param1 + ".name",param1);
      }
      
      private function onTreasureHuntUpdate(param1:class_3638) : void
      {
         var _loc3_:String = null;
         var _loc2_:class_2513 = param1.getParser();
         if(!_loc2_.isCompleted)
         {
            _loc3_ = _notifications.localization.getLocalizationWithParams("treasure_hunt.progress.desc","","current",_loc2_.stepsCompleted,"total",_loc2_.totalSteps,"hunt_name",getHuntName(_loc2_.huntId));
         }
         else
         {
            _loc3_ = _notifications.localization.getLocalizationWithParams("treasure_hunt.won.desc","","hunt_name",getHuntName(_loc2_.huntId));
         }
         _notifications.addItem(_loc3_,"treasure_hunt");
      }
      
      private function onTreasureHuntFail(param1:class_2808) : void
      {
         var _loc2_:class_3522 = param1.getParser();
         var _loc3_:String = _notifications.localization.getLocalizationWithParams("treasure_hunt.level_fail.desc","","level",_loc2_.requiredLevel,"level_paying",_loc2_.requiredLevelPaying);
         _notifications.addItem(_loc3_,"treasure_hunt");
      }
      
      private function onTreasureHuntFirstWinner(param1:class_3132) : void
      {
         var _loc2_:class_3404 = param1.getParser();
         _bufferedTreasureHuntWinnerInfo = _loc2_.winnerInfo;
         showTreasureHuntWinner();
      }
      
      private function showTreasureHuntWinner(param1:Boolean = false) : void
      {
         var _loc5_:TreasureHuntWinnerInfo = _bufferedTreasureHuntWinnerInfo;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:String = _notifications.localization.getLocalizationWithParams("treasure_hunt.winner.desc","","user_name",_loc5_.userName,"hunt_name",getHuntName(_loc5_.huntId));
         var _loc4_:class_1827 = _notifications.avatarRenderManager.createAvatarImage(_loc5_.userFigure,"h",_loc5_.userGender,param1 ? null : this);
         var _loc2_:BitmapData = null;
         if(_loc4_ != null && !_loc4_.isPlaceholder())
         {
            _loc2_ = HabboFaceFocuser.focusUserFace(_loc4_,"head",3,1);
            _loc4_.dispose();
         }
         if(_loc4_ != null || param1)
         {
            _notifications.addItemWithBitmap(_loc3_,"treasure_hunt",_loc2_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_bufferedTreasureHuntWinnerInfo != null && _bufferedTreasureHuntWinnerInfo.userFigure == param1)
         {
            showTreasureHuntWinner(true);
         }
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      public function dispose() : void
      {
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         _messageEvents = null;
         _notifications = null;
         _communication = null;
      }
      
      private function useNotificationFeed() : Boolean
      {
         return _notifications.getBoolean("notification.feed.enabled");
      }
      
      private function useNotifications() : Boolean
      {
         return _notifications.getBoolean("notification.items.enabled");
      }
      
      internal function onMOTD(param1:IMessageEvent) : void
      {
         var _loc4_:GenericNotificationItemData = null;
         var _loc5_:class_2660 = param1 as class_2660;
         var _loc3_:class_2949 = _loc5_.getParser() as class_2949;
         if(_loc3_.messages && _loc3_.messages.length > 0)
         {
            if(useNotifications())
            {
               new MOTDNotification(_loc3_.messages,_notifications.assetLibrary,_notifications.windowManager);
            }
            if(useNotificationFeed())
            {
               for each(var _loc2_ in _loc3_.messages)
               {
                  _loc4_ = new GenericNotificationItemData();
                  _loc4_.title = _loc2_;
                  _loc4_.timeStamp = getTimer();
                  _notifications.feedController.addFeedItem(3,_loc4_);
               }
            }
         }
      }
      
      private function onLevelUp(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         _loc4_ = "notification.new.achievement";
         var _loc2_:class_1799 = param1 as class_1799;
         var _loc3_:class_1918 = _loc2_.getParser();
         var _loc6_:String = _notifications.localization.getBadgeName(_loc3_.data.badgeCode);
         _notifications.localization.registerParameter("notification.new.achievement","achievement_name",_loc6_);
         var _loc7_:String = _notifications.localization.getLocalization("notification.new.achievement");
         var _loc5_:BitmapData = _notifications.sessionDataManager.requestBadgeImage(_loc3_.data.badgeCode);
         _notifications.singularController.addItem(_loc7_,"achievement",_loc5_,null,_loc3_.data.badgeCode,"questengine/achievements/" + _loc3_.data.category);
      }
      
      private function onBadgeReceived(param1:IMessageEvent) : void
      {
         var _loc5_:String = null;
         _loc5_ = "notification.new.badge";
         var _loc2_:class_3521 = param1 as class_3521;
         var _loc3_:class_2433 = _loc2_.getParser();
         var _loc4_:String = _notifications.localization.getBadgeName(_loc3_.badgeCode);
         _notifications.localization.registerParameter("notification.new.badge","badge_name",_loc4_);
         var _loc7_:String = _notifications.localization.getLocalization("notification.new.badge");
         var _loc6_:BitmapData = _notifications.sessionDataManager.requestBadgeImage(_loc3_.badgeCode);
         _notifications.singularController.addItem(_loc7_,"badge_received",_loc6_,null,_loc3_.badgeCode,"inventory/open/badges");
      }
      
      internal function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc3_:class_3234 = param1 as class_3234;
         if(_notifications.sessionDataManager.userId == _loc3_.userId)
         {
            _notifications.localization.registerParameter("notifications.text.respect.2","count",String(_loc3_.respectTotal));
            var _loc4_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.respect.1");
            var _loc2_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.respect.2");
         }
      }
      
      private function onRoomMessagesNotification(param1:class_3006) : void
      {
         var _loc2_:ILocalization = null;
         var _loc3_:class_2340 = param1.getParser();
         _notifications.localization.registerParameter("notifications.text.room.messages.posted","room_name",_loc3_.roomName);
         _notifications.localization.registerParameter("notifications.text.room.messages.posted","messages_count",_loc3_.messageCount.toString());
         _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.room.messages.posted");
         var _loc6_:BitmapDataAsset = _notifications.assets.getAssetByName("if_icon_temp_png") as BitmapDataAsset;
         var _loc4_:BitmapData = _loc6_.content as BitmapData;
         if(_loc2_)
         {
            _notifications.singularController.addItem(_loc2_.value,"roommessagesposted",_loc4_.clone());
         }
      }
      
      private function onRecyclerFinished(param1:IMessageEvent) : void
      {
         var _loc3_:class_2084 = (param1 as class_1935).getParser();
         if(_loc3_ == null || _loc3_.recyclerFinishedStatus != 1)
         {
            return;
         }
         var _loc2_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.recycle.ok");
         if(_loc2_)
         {
            _notifications.singularController.addItem(_loc2_.value,"recyclerok",null);
         }
         class_21.log("[HabboNotifications] recycle ok");
      }
      
      private function onInfoFeedEnable(param1:IMessageEvent) : void
      {
         var _loc2_:class_3240 = param1 as class_3240;
         if(_loc2_ != null)
         {
            _notifications.disabled = !_loc2_.enabled;
         }
      }
      
      private function onModCautionEvent(param1:IMessageEvent) : void
      {
         var _loc3_:GenericNotificationItemData = null;
         var _loc2_:class_3519 = (param1 as class_3068).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         if(useNotifications())
         {
            _notifications.singularController.alertDialogManager.handleModeratorCaution(_loc2_.message,_loc2_.url);
         }
         if(useNotificationFeed())
         {
            _loc3_ = new GenericNotificationItemData();
            _loc3_.title = _loc2_.message;
            _loc3_.buttonAction = _loc2_.url;
            _loc3_.buttonCaption = _loc2_.url;
            _loc3_.timeStamp = getTimer();
            _notifications.feedController.addFeedItem(3,_loc3_);
         }
      }
      
      private function onModMessageEvent(param1:IMessageEvent) : void
      {
         var _loc3_:GenericNotificationItemData = null;
         var _loc2_:class_2835 = (param1 as class_2588).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         if(useNotifications())
         {
            _notifications.singularController.alertDialogManager.handleModeratorMessage(_loc2_.message,_loc2_.url);
         }
         if(useNotificationFeed())
         {
            _loc3_ = new GenericNotificationItemData();
            _loc3_.title = _loc2_.message;
            _loc3_.buttonAction = _loc2_.url;
            _loc3_.buttonCaption = _loc2_.url;
            _loc3_.timeStamp = getTimer();
            _notifications.feedController.addFeedItem(3,_loc3_);
         }
      }
      
      private function onUserBannedMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:class_2774 = (param1 as class_2420).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleUserBannedMessage(_loc2_.message);
      }
      
      private function onBanInfoMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:class_2360 = (param1 as class_3226).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleBanInfoMessage(_loc2_.reason,_loc2_.banExpirySeconds,_loc2_.localizedReason);
      }
      
      private function onHotelClosing(param1:IMessageEvent) : void
      {
         var _loc2_:class_2641 = (param1 as class_3074).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosingMessage(_loc2_.minutesUntilClosing);
      }
      
      private function onHotelMaintenance(param1:IMessageEvent) : void
      {
         var _loc2_:class_2539 = (param1 as class_3617).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelMaintenanceMessage(_loc2_.minutesUntilMaintenance,_loc2_.duration);
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:class_2628 = (param1 as class_3442).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute,_loc2_.userThrownOutAtClose);
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:class_3411 = (param1 as class_3610).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleLoginFailedHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute);
      }
      
      private function onRestoreClientMessageEvent(param1:IMessageEvent) : void
      {
         HabboWebTools.closeWebPageAndRestoreClient();
      }
      
      private function onPetLevelNotification(param1:class_3310) : void
      {
         var _loc2_:class_2486 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:class_3113 = param1.getParser();
         _notifications.localization.registerParameter("notifications.text.petlevel","pet_name",_loc4_.petName);
         _notifications.localization.registerParameter("notifications.text.petlevel","level",_loc4_.level.toString());
         var _loc3_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.petlevel");
         if(_loc3_)
         {
            _loc2_ = _loc4_.figureData;
            _loc5_ = _notifications.petImageUtility.getPetImage(_loc2_.typeId,_loc2_.paletteId,_loc2_.color);
            _notifications.singularController.addItem(_loc3_.value,"petlevel",_loc5_);
         }
      }
      
      private function onPetReceived(param1:class_2569) : void
      {
         var _loc2_:ILocalization = null;
         var _loc4_:class_2838 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:class_3182 = param1.getParser();
         if(_loc3_.boughtAsGift)
         {
            _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.petbought");
         }
         else
         {
            _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.petreceived");
         }
         if(_loc2_)
         {
            _loc4_ = _loc3_.pet;
            _loc5_ = _notifications.petImageUtility.getPetImage(_loc4_.typeId,_loc4_.paletteId,_loc4_.color);
            _notifications.singularController.addItem(_loc2_.value,"petlevel",_loc5_);
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         _notifications.singularController.showModerationDisclaimer();
      }
      
      private function onBroadcastMessageEvent(param1:IMessageEvent) : void
      {
         var _loc4_:class_3161 = (param1 as class_2494).getParser();
         var _loc2_:String = _loc4_.messageText;
         var _loc3_:RegExp = /\\r/g;
         _loc2_ = _loc2_.replace(_loc3_,"\r");
         _notifications.windowManager.simpleAlert("${notifications.broadcast.title}","",_loc2_,"","",null,"illumina_alert_illustrations_frank_neutral_png");
      }
      
      private function onNotificationDialogMessageEvent(param1:class_2865) : void
      {
         var _loc2_:class_3338 = param1.getParser();
         if("cfh.created" == _loc2_.type)
         {
            showCallCreatedNotification(_loc2_.parameters["message"],_loc2_.parameters["linkUrl"]);
         }
         else
         {
            _notifications.showNotification(_loc2_.type,_loc2_.parameters);
         }
      }
      
      private function showCallCreatedNotification(param1:String, param2:String) : void
      {
         var _loc3_:String = param1.replace(/\\r/g,"\r");
         if(param2 != null)
         {
            _notifications.windowManager.simpleAlert("${help.cfh.sent.title}","",_loc3_,"${help.main.faq.link.text}",param2,null,"illumina_alert_illustrations_frank_neutral_png");
         }
         else
         {
            _notifications.windowManager.simpleAlert("${help.cfh.sent.title}","",_loc3_,null,null,null,"illumina_alert_illustrations_frank_neutral_png");
         }
      }
      
      private function onPetRespectFailed(param1:IMessageEvent) : void
      {
         var _loc2_:class_3229 = (param1 as class_1865).getParser();
         this._notifications.localization.registerParameter("room.error.pets.respectfailed","required_age","" + _loc2_.requiredDays);
         this._notifications.localization.registerParameter("room.error.pets.respectfailed","avatar_age","" + _loc2_.avatarAgeInDays);
         _notifications.windowManager.alert("${error.title}","${room.error.pets.respectfailed}",0,onAlert);
      }
      
      public function onAlert(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      private function onClubGiftNotification(param1:class_2358) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:class_3231 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.numGifts < 1)
         {
            return;
         }
         _notifications.singularController.showClubGiftNotification(_loc2_.numGifts);
      }
      
      private function onUserObject(param1:class_2005) : void
      {
         var _loc2_:class_1913 = param1.getParser();
         if(_loc2_.accountSafetyLocked)
         {
            _notifications.singularController.showSafetyLockedNotification(_loc2_.id);
         }
      }
      
      private function onAccountSafetyLockStatusChanged(param1:class_1808) : void
      {
         var _loc2_:class_2234 = param1.getParser();
         if(_loc2_.status == 1)
         {
            _notifications.singularController.hideSafetyLockedNotification();
         }
      }
      
      private function onClubGiftSelected(param1:class_3423) : void
      {
         if(!param1 || !_notifications.localization)
         {
            return;
         }
         var _loc3_:class_3450 = param1.getParser();
         if(!_loc3_)
         {
            return;
         }
         var _loc6_:Array = _loc3_.products;
         if(!_loc6_ || _loc6_.length == 0)
         {
            return;
         }
         var _loc2_:class_2104 = _loc6_[0] as class_2104;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:String = _notifications.localization.getLocalization("notifications.text.club_gift.received");
         var _loc4_:BitmapData = _notifications.productImageUtility.getProductImage(_loc2_.productType,_loc2_.furniClassId,_loc2_.extraParam);
         _notifications.singularController.addItem(_loc5_,"info",_loc4_);
      }
      
      private function onActivityPointNotification(param1:class_1961) : void
      {
         if(param1.change <= 0)
         {
            return;
         }
         switch(param1.type - 5)
         {
            case 0:
               var _loc3_:String = _notifications.localization.getLocalizationWithParams("notifications.text.loyalty.received","","amount",param1.change);
               var _loc2_:BitmapData = _notifications.assets.getAssetByName("if_icon_diamond_png").content as BitmapData;
               _notifications.singularController.addItem(null,"info",null.clone());
               return;
            default:
               return;
         }
      }
      
      private function onNftEmeraldConvertResult(param1:IMessageEvent) : void
      {
         var _loc2_:NftEmeraldConvertResultMessageEvent = param1 as NftEmeraldConvertResultMessageEvent;
         var _loc3_:class_3039 = _loc2_.getParser();
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         if(_loc3_.result == 0)
         {
            return;
         }
         if(_loc3_.result == 5)
         {
            _notifications.addItem(_notifications.localization.getLocalization("notification.nft.emerald_convert.not_in_collector","To convert this Emerald furni, it needs to be in your Collector Wallet"),"info");
            return;
         }
         _notifications.addItem(_notifications.localization.getLocalization("notification.nft.emerald_convert_failed"),"info");
      }
      
      private function onChatStyleNotification(param1:class_1973) : void
      {
         var _loc2_:class_2481 = param1.getParser();
         var _loc4_:String = _notifications.localization.getLocalization(_loc2_.added ? "notification.chatstyles.added" : "notification.chatstyles.removed");
         var _loc3_:BitmapData = _notifications.freeFlowChat.chatStyleLibrary.getStyle(_loc2_.styleId).selectorPreview.clone();
         _notifications.addItemWithBitmap(_loc4_,"info",_loc3_);
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

