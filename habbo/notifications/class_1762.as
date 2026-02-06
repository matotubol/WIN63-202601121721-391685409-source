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
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2104;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2486;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2838;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedEventParser;
   import com.sulake.habbo.communication.messages.incoming.nft.NftEmeraldConvertResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserPurchasableChatStyleChangedMessageEventParser;
   import package_136.TreasureHuntWinnerInfo;
   import package_136.TreasureHuntUpdateMessageEventParser;
   import package_136.TreasureHuntFirstWinnerMessageEventParser;
   import package_136.TreasureHuntFailMessageEventParser;
   import package_165.TreasureHuntFailMessageEvent;
   import package_165.TreasureHuntFirstWinnerMessageEvent;
   import package_165.TreasureHuntUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeReceivedEvent;
   import com.sulake.habbo.communication.messages.parser.nft.NftEmeraldConvertResultMessageEventParser;
   import package_20.RecyclerFinishedMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.NotificationDialogMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.RestoreClientMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.nft.UserPurchasableChatStyleChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationEventParser;
   import com.sulake.habbo.communication.messages.parser.notifications.NotificationDialogMessageEventParser;
   import package_48.RecyclerFinishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedEventParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorCautionEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.BanInfoMessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.moderation.BanInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorCautionEventParser;
   import com.sulake.habbo.communication.messages.parser.users.AccountSafetyLockStatusChangeMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedEventParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageEventParser;
   
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
         addMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
         addMessageEvent(new PetReceivedMessageEvent(onPetReceived));
         addMessageEvent(new ClubGiftNotificationEvent(onClubGiftNotification));
         addMessageEvent(new OpenConnectionMessageEvent(onRoomEnter));
         addMessageEvent(new HabboAchievementNotificationMessageEvent(onLevelUp));
         addMessageEvent(new TreasureHuntFirstWinnerMessageEvent(onTreasureHuntFirstWinner));
         addMessageEvent(new NotificationDialogMessageEvent(onNotificationDialogMessageEvent));
         addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
         addMessageEvent(new UserPurchasableChatStyleChangedMessageEvent(onChatStyleNotification));
         addMessageEvent(new PetLevelNotificationEvent(onPetLevelNotification));
         addMessageEvent(new TreasureHuntUpdateMessageEvent(onTreasureHuntUpdate));
         addMessageEvent(new AccountSafetyLockStatusChangeMessageEvent(onAccountSafetyLockStatusChanged));
         addMessageEvent(new ModeratorMessageEvent(onModMessageEvent));
         addMessageEvent(new RestoreClientMessageEvent(onRestoreClientMessageEvent));
         addMessageEvent(new ClubGiftSelectedEvent(onClubGiftSelected));
         addMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
         addMessageEvent(new BanInfoMessageEvent(onBanInfoMessageEvent));
         addMessageEvent(new RecyclerFinishedMessageEvent(onRecyclerFinished));
         addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
         addMessageEvent(new RoomMessageNotificationMessageEvent(onRoomMessagesNotification));
         addMessageEvent(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
         addMessageEvent(new MOTDNotificationEvent(onMOTD));
         addMessageEvent(new ModeratorCautionEvent(onModCautionEvent));
         addMessageEvent(new TreasureHuntFailMessageEvent(onTreasureHuntFail));
         addMessageEvent(new UserBannedMessageEvent(onUserBannedMessageEvent));
         addMessageEvent(new MaintenanceStatusMessageEvent(onHotelMaintenance));
         addMessageEvent(new InfoFeedEnableMessageEvent(onInfoFeedEnable));
         addMessageEvent(new PetRespectFailedEvent(onPetRespectFailed));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosing));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new BadgeReceivedEvent(onBadgeReceived));
         addMessageEvent(new NftEmeraldConvertResultMessageEvent(onNftEmeraldConvertResult));
         _notifications.activate();
      }
      
      private function getHuntName(param1:String) : String
      {
         return _notifications.localization.getLocalization("treasure_hunt." + param1 + ".name",param1);
      }
      
      private function onTreasureHuntUpdate(param1:TreasureHuntUpdateMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:TreasureHuntUpdateMessageEventParser = param1.getParser();
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
      
      private function onTreasureHuntFail(param1:TreasureHuntFailMessageEvent) : void
      {
         var _loc2_:TreasureHuntFailMessageEventParser = param1.getParser();
         var _loc3_:String = _notifications.localization.getLocalizationWithParams("treasure_hunt.level_fail.desc","","level",_loc2_.requiredLevel,"level_paying",_loc2_.requiredLevelPaying);
         _notifications.addItem(_loc3_,"treasure_hunt");
      }
      
      private function onTreasureHuntFirstWinner(param1:TreasureHuntFirstWinnerMessageEvent) : void
      {
         var _loc2_:TreasureHuntFirstWinnerMessageEventParser = param1.getParser();
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
         var _loc5_:MOTDNotificationEvent = param1 as MOTDNotificationEvent;
         var _loc3_:MOTDNotificationEventParser = _loc5_.getParser() as MOTDNotificationEventParser;
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
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         var _loc3_:HabboAchievementNotificationMessageEventParser = _loc2_.getParser();
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
         var _loc2_:BadgeReceivedEvent = param1 as BadgeReceivedEvent;
         var _loc3_:BadgeReceivedEventParser = _loc2_.getParser();
         var _loc4_:String = _notifications.localization.getBadgeName(_loc3_.badgeCode);
         _notifications.localization.registerParameter("notification.new.badge","badge_name",_loc4_);
         var _loc7_:String = _notifications.localization.getLocalization("notification.new.badge");
         var _loc6_:BitmapData = _notifications.sessionDataManager.requestBadgeImage(_loc3_.badgeCode);
         _notifications.singularController.addItem(_loc7_,"badge_received",_loc6_,null,_loc3_.badgeCode,"inventory/open/badges");
      }
      
      internal function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc3_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(_notifications.sessionDataManager.userId == _loc3_.userId)
         {
            _notifications.localization.registerParameter("notifications.text.respect.2","count",String(_loc3_.respectTotal));
            var _loc4_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.respect.1");
            var _loc2_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.respect.2");
         }
      }
      
      private function onRoomMessagesNotification(param1:RoomMessageNotificationMessageEvent) : void
      {
         var _loc2_:ILocalization = null;
         var _loc3_:RoomMessageNotificationMessageEventParser = param1.getParser();
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
         var _loc3_:RecyclerFinishedMessageEventParser = (param1 as RecyclerFinishedMessageEvent).getParser();
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
         var _loc2_:InfoFeedEnableMessageEvent = param1 as InfoFeedEnableMessageEvent;
         if(_loc2_ != null)
         {
            _notifications.disabled = !_loc2_.enabled;
         }
      }
      
      private function onModCautionEvent(param1:IMessageEvent) : void
      {
         var _loc3_:GenericNotificationItemData = null;
         var _loc2_:ModeratorCautionEventParser = (param1 as ModeratorCautionEvent).getParser();
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
         var _loc2_:ModeratorMessageEventParser = (param1 as ModeratorMessageEvent).getParser();
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
         var _loc2_:UserBannedMessageEventParser = (param1 as UserBannedMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleUserBannedMessage(_loc2_.message);
      }
      
      private function onBanInfoMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:BanInfoMessageEventParser = (param1 as BanInfoMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleBanInfoMessage(_loc2_.reason,_loc2_.banExpirySeconds,_loc2_.localizedReason);
      }
      
      private function onHotelClosing(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosingMessageEventParser = (param1 as InfoHotelClosingMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosingMessage(_loc2_.minutesUntilClosing);
      }
      
      private function onHotelMaintenance(param1:IMessageEvent) : void
      {
         var _loc2_:MaintenanceStatusMessageEventParser = (param1 as MaintenanceStatusMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelMaintenanceMessage(_loc2_.minutesUntilMaintenance,_loc2_.duration);
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosedMessageEventParser = (param1 as InfoHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute,_loc2_.userThrownOutAtClose);
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:LoginFailedHotelClosedMessageEventParser = (param1 as LoginFailedHotelClosedMessageEvent).getParser();
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
      
      private function onPetLevelNotification(param1:PetLevelNotificationEvent) : void
      {
         var _loc2_:class_2486 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:PetLevelNotificationEventParser = param1.getParser();
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
      
      private function onPetReceived(param1:PetReceivedMessageEvent) : void
      {
         var _loc2_:ILocalization = null;
         var _loc4_:class_2838 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:PetReceivedMessageEventParser = param1.getParser();
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
         var _loc4_:HabboBroadcastMessageEventParser = (param1 as HabboBroadcastMessageEvent).getParser();
         var _loc2_:String = _loc4_.messageText;
         var _loc3_:RegExp = /\\r/g;
         _loc2_ = _loc2_.replace(_loc3_,"\r");
         _notifications.windowManager.simpleAlert("${notifications.broadcast.title}","",_loc2_,"","",null,"illumina_alert_illustrations_frank_neutral_png");
      }
      
      private function onNotificationDialogMessageEvent(param1:NotificationDialogMessageEvent) : void
      {
         var _loc2_:NotificationDialogMessageEventParser = param1.getParser();
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
         var _loc2_:PetRespectFailedEventParser = (param1 as PetRespectFailedEvent).getParser();
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
      
      private function onClubGiftNotification(param1:ClubGiftNotificationEvent) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:ClubGiftNotificationEventParser = param1.getParser();
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
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         var _loc2_:UserObjectEventParser = param1.getParser();
         if(_loc2_.accountSafetyLocked)
         {
            _notifications.singularController.showSafetyLockedNotification(_loc2_.id);
         }
      }
      
      private function onAccountSafetyLockStatusChanged(param1:AccountSafetyLockStatusChangeMessageEvent) : void
      {
         var _loc2_:AccountSafetyLockStatusChangeMessageEventParser = param1.getParser();
         if(_loc2_.status == 1)
         {
            _notifications.singularController.hideSafetyLockedNotification();
         }
      }
      
      private function onClubGiftSelected(param1:ClubGiftSelectedEvent) : void
      {
         if(!param1 || !_notifications.localization)
         {
            return;
         }
         var _loc3_:ClubGiftSelectedEventParser = param1.getParser();
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
      
      private function onActivityPointNotification(param1:HabboActivityPointNotificationMessageEvent) : void
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
         var _loc3_:NftEmeraldConvertResultMessageEventParser = _loc2_.getParser();
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
      
      private function onChatStyleNotification(param1:UserPurchasableChatStyleChangedMessageEvent) : void
      {
         var _loc2_:UserPurchasableChatStyleChangedMessageEventParser = param1.getParser();
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

