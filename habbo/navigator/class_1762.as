package com.sulake.habbo.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import package_1.class_2003;
   import package_1.class_3280;
   import package_1.class_3493;
   import package_14.class_1915;
   import package_14.class_1937;
   import package_140.class_2540;
   import package_143.class_2635;
   import package_144.class_2723;
   import package_17.class_1781;
   import package_17.class_2257;
   import package_17.class_2330;
   import package_17.class_2382;
   import package_17.class_2444;
   import package_17.class_2673;
   import package_17.class_2907;
   import package_17.class_2963;
   import package_17.class_2975;
   import package_17.class_3005;
   import package_17.class_3209;
   import package_17.class_3258;
   import package_17.class_3298;
   import package_17.class_3383;
   import package_17.class_3447;
   import package_17.class_3553;
   import package_28.class_2765;
   import package_3.class_2238;
   import package_32.class_2584;
   import package_32.class_2887;
   import package_32.class_3120;
   import package_32.class_3199;
   import package_32.class_3289;
   import package_32.class_3397;
   import package_32.class_3448;
   import package_32.class_3479;
   import package_32.class_3538;
   import package_32.class_3549;
   import package_32.class_3578;
   import package_32.class_3606;
   import package_35.class_2523;
   import package_35.class_3142;
   import package_35.class_3365;
   import package_39.class_1980;
   import package_4.class_1757;
   import package_4.class_2005;
   import package_4.class_2819;
   import package_42.class_1945;
   import package_42.class_2102;
   import package_42.class_2168;
   import package_42.class_2312;
   import package_42.class_2543;
   import package_42.class_2767;
   import package_42.class_2789;
   import package_42.class_2822;
   import package_42.class_2826;
   import package_42.class_2868;
   import package_42.class_2881;
   import package_42.class_2969;
   import package_42.class_3003;
   import package_42.class_3125;
   import package_42.class_3167;
   import package_42.class_3174;
   import package_42.class_3190;
   import package_42.class_3285;
   import package_42.class_3323;
   import package_42.class_3415;
   import package_42.class_3464;
   import package_42.class_3470;
   import package_42.class_3544;
   import package_42.class_3601;
   import package_44.class_1913;
   import package_50.class_1996;
   import package_54.class_2039;
   import package_54.class_2311;
   import package_54.class_2634;
   import package_54.class_3332;
   import package_61.class_2936;
   import package_72.class_2589;
   import package_8.class_2014;
   import package_83.class_2306;
   import package_83.class_2454;
   import package_83.class_2512;
   import package_83.class_2744;
   import package_83.class_2757;
   import package_83.class_2973;
   import package_83.class_3053;
   import package_83.class_3093;
   import package_83.class_3144;
   import package_83.class_3363;
   import package_83.class_3551;
   
   [SecureSWF(rename="true")]
   public class class_1762
   {
      
      private var _navigator:HabboNavigator;
      
      public function class_1762(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var _loc2_:class_57 = _navigator.communication;
         _loc2_.addHabboConnectionMessageEvent(new class_2819(onError));
         _loc2_.addHabboConnectionMessageEvent(new class_3578(onUserUnbannedFromRoom));
         _loc2_.addHabboConnectionMessageEvent(new class_1980(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new class_2238(onSubscriptionInfo));
         _loc2_.addHabboConnectionMessageEvent(new class_1937(onFriendListUpdate));
         _loc2_.addHabboConnectionMessageEvent(new class_2881(onCompetitionData));
         _loc2_.addHabboConnectionMessageEvent(new class_3448(onMuteAllEvent));
         _loc2_.addHabboConnectionMessageEvent(new class_3003(onRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new class_3174(onRoomEventCancel));
         _loc2_.addHabboConnectionMessageEvent(new class_3125(onCanCreateRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new class_2826(onNavigatorSettings));
         _loc2_.addHabboConnectionMessageEvent(new class_3167(onRoomRating));
         _loc2_.addHabboConnectionMessageEvent(new class_2789(onCategoriesWithUserCount));
         _loc2_.addHabboConnectionMessageEvent(new class_2039(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new class_3606(onNoSuchFlat));
         _loc2_.addHabboConnectionMessageEvent(new class_2005(onUserObject));
         _loc2_.addHabboConnectionMessageEvent(new class_2634(onDoorOpened));
         _loc2_.addHabboConnectionMessageEvent(new class_2312(onFavourites));
         _loc2_.addHabboConnectionMessageEvent(new class_3332(onCantConnect));
         _loc2_.addHabboConnectionMessageEvent(new class_1915(onFriendsListFragment));
         _loc2_.addHabboConnectionMessageEvent(new class_3601(onConvertedRoomId));
         _loc2_.addHabboConnectionMessageEvent(new class_3190(onFavouriteChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_2887(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new class_2311(onRoomForward));
         _loc2_.addHabboConnectionMessageEvent(new class_2969(onUserFlatCats));
         _loc2_.addHabboConnectionMessageEvent(new class_2102(onFlatCreated));
         _loc2_.addHabboConnectionMessageEvent(new class_1757(onUserRights));
         _loc2_.addHabboConnectionMessageEvent(new class_2584(onRoomSettingsError));
         _loc2_.addHabboConnectionMessageEvent(new class_3397(onBannedUsersFromRoom));
         _loc2_.addHabboConnectionMessageEvent(new class_2936(onRoomFilterSettings));
         _loc2_.addHabboConnectionMessageEvent(new class_3199(onRoomSettingsData));
         _loc2_.addHabboConnectionMessageEvent(new class_2767(onGuestRoomSearchResult));
         _loc2_.addHabboConnectionMessageEvent(new class_3285(onDoorbell));
         _loc2_.addHabboConnectionMessageEvent(new class_2822(onRoomInfoUpdated));
         _loc2_.addHabboConnectionMessageEvent(new class_3289(onFlatControllerRemoved));
         _loc2_.addHabboConnectionMessageEvent(new class_3120(onFlatControllers));
         _loc2_.addHabboConnectionMessageEvent(new class_2868(onUserEventCats));
         _loc2_.addHabboConnectionMessageEvent(new class_3415(onPopularRoomTagsResult));
         _loc2_.addHabboConnectionMessageEvent(new class_3470(onCanCreateRoom));
         _loc2_.addHabboConnectionMessageEvent(new class_2540(onNoOwnedRoomsAlert));
         _loc2_.addHabboConnectionMessageEvent(new class_2723(onGameStarted));
         _loc2_.addHabboConnectionMessageEvent(new class_3479(onRoomSettingsSaveError));
         _loc2_.addHabboConnectionMessageEvent(new class_3549(onFlatControllerAdded));
         _loc2_.addHabboConnectionMessageEvent(new class_2168(onRoomInfo));
         _loc2_.addHabboConnectionMessageEvent(new class_3538(onEnforceRoomCategorySelection));
         _loc2_.addHabboConnectionMessageEvent(new class_3544(onFlatAccessDenied));
         _loc2_.addHabboConnectionMessageEvent(new class_2543(onOfficialRooms));
      }
      
      public function get data() : NavigatorData
      {
         return _navigator.data;
      }
      
      private function onMuteAllEvent(param1:IMessageEvent) : void
      {
         var _loc4_:class_3448 = param1 as class_3448;
         var _loc3_:class_2973 = _loc4_.getParser();
         var _loc2_:class_1945 = _navigator.data.enteredGuestRoom;
         if(_loc2_ != null)
         {
            _loc2_.allInRoomMuted = _loc3_.allMuted;
            if(_navigator.roomInfoViewCtrl != null)
            {
               _navigator.roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
            }
         }
      }
      
      private function onNoSuchFlat(param1:IMessageEvent) : void
      {
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1913 = class_2005(param1).getParser();
         data.avatarId = _loc2_.id;
         _navigator.send(new class_3280());
         _navigator.send(new class_3493());
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:class_1757 = class_1757(param1);
         if(_loc2_.securityLevel >= 5)
         {
            _navigator.data.eventMod = true;
         }
         if(_loc2_.securityLevel >= 7)
         {
            _navigator.data.roomPicker = true;
         }
      }
      
      private function onCategoriesWithUserCount(param1:IMessageEvent) : void
      {
         var _loc2_:class_3005 = class_2789(param1).getParser();
         data.categoriesWithVisitorData = _loc2_.data;
         class_21.log("Received Categories with user count: " + data.categoriesWithVisitorData.categoryToCurrentUserCountMap.length);
      }
      
      private function onOfficialRooms(param1:IMessageEvent) : void
      {
         var _loc2_:class_2963 = class_2543(param1).getParser();
         data.officialRooms = _loc2_.data;
         data.adRoom = _loc2_.adRoom;
         data.promotedRooms = _loc2_.promotedRooms;
         class_21.log("Received Official rooms: " + data.officialRooms.entries.length);
      }
      
      private function onGuestRoomSearchResult(param1:IMessageEvent) : void
      {
         var _loc2_:class_3464 = class_2767(param1).getParser().data;
         data.guestRoomSearchResults = _loc2_;
         class_21.log("Received GuestRoomSearch: " + data.guestRoomSearchResults.rooms.length);
      }
      
      private function onPopularRoomTagsResult(param1:IMessageEvent) : void
      {
         var _loc2_:class_3323 = class_3415(param1).getParser().data;
         data.popularTags = _loc2_;
         class_21.log("Received popular room tags: " + data.popularTags.tags.length);
      }
      
      private function onRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc2_:class_2382 = class_3003(param1).getParser();
         class_21.log("Got room event: " + _loc2_.data.ownerAvatarId + ", " + _loc2_.data.eventName);
         data.roomEventData = _loc2_.data.ownerAvatarId > 0 ? _loc2_.data : null;
         _navigator.roomEventInfoCtrl.refresh();
      }
      
      private function onRoomEventCancel(param1:IMessageEvent) : void
      {
         data.roomEventData = null;
         _navigator.roomEventInfoCtrl.refresh();
      }
      
      private function onCanCreateRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc3_:SimpleAlertView = null;
         var _loc2_:class_2907 = class_3125(param1).getParser();
         class_21.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
         if(_loc2_.canCreateEvent)
         {
            _navigator.roomEventViewCtrl.show();
         }
         else
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.cannotcreateevent.title}","${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
            _loc3_.show();
            class_21.log("Cannot create an event just now...");
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:class_1996 = class_1980(param1).getParser();
         class_21.log("Navigator: entering room");
         data.onRoomEnter(_loc2_);
         closeOpenCantConnectAlerts();
         _navigator.roomInfoViewCtrl.close();
         _navigator.send(new class_2003(_loc2_.guestRoomId,true,false));
         class_21.log("Sent get guest room...");
         _navigator.roomEventInfoCtrl.refresh();
         _navigator.roomEventViewCtrl.close();
         _navigator.roomSettingsCtrl.close();
         _navigator.roomFilterCtrl.close();
         HabboWebTools.closeNews();
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1781 = class_2168(param1).getParser();
         class_21.log("Got room info: " + _loc2_.enterRoom + ", " + _loc2_.roomForward);
         if(_loc2_.enterRoom)
         {
            data.enteredRoom = _loc2_.data;
            data.currentRoomIsStaffPick = _loc2_.staffPick;
            var _loc3_:* = data.createdFlatId == _loc2_.data.flatId;
            if(_loc2_.data.displayRoomEntryAd)
            {
               requestRoomEnterAd();
            }
            data.createdFlatId = 0;
            if(data.enteredGuestRoom != null && data.enteredGuestRoom.habboGroupId > 0)
            {
               _navigator.roomEventInfoCtrl.expanded = false;
               _navigator.roomEventInfoCtrl.refresh();
            }
            var _loc4_:RoomSessionTags = _navigator.data.getAndResetSessionTags();
            if(_loc4_ != null)
            {
               _navigator.send(null.getMsg());
            }
         }
         else if(_loc2_.roomForward)
         {
            if(_loc2_.openingConnection)
            {
               _navigator.goToRoom(_loc2_.data.flatId,false,"",-1,true);
            }
            else if(_loc2_.data.doorMode == 1 && (!_loc2_.isGroupMember && _navigator.sessionData.userName != _loc2_.data.ownerName))
            {
               _navigator.doorbell.show(_loc2_.data);
            }
            else if(_loc2_.data.doorMode == 2 && (_navigator.sessionData.userName != _loc2_.data.ownerName && !_loc2_.isGroupMember))
            {
               _navigator.passwordInput.show(_loc2_.data);
            }
            else
            {
               if(_loc2_.data.doorMode == 4 && !_navigator.sessionData.isAmbassador && !_navigator.sessionData.isRealNoob && !_navigator.sessionData.isAnyRoomController)
               {
                  return;
               }
               _navigator.goToRoom(_loc2_.data.flatId,false);
            }
         }
         else
         {
            data.enteredRoom = _loc2_.data;
            data.currentRoomIsStaffPick = _loc2_.staffPick;
            _navigator.roomInfoViewCtrl.reload();
         }
      }
      
      private function requestRoomEnterAd() : void
      {
         if(_navigator.getProperty("roomenterad.habblet.enabled") == "true")
         {
            HabboWebTools.openRoomEnterAd();
         }
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:class_2257 = class_2102(param1).getParser();
         ErrorReportStorage.addDebugData("IncomingEvent","Flat created: " + _loc2_.flatId + ", " + _loc2_.flatName);
         data.createdFlatId = _loc2_.flatId;
         _navigator.goToRoom(_loc2_.flatId,true);
         _navigator.mainViewCtrl.reloadRoomList(5);
         _navigator.goToMainView();
         _navigator.closeNavigator();
      }
      
      private function onGameStarted(param1:IMessageEvent) : void
      {
         _navigator.mainViewCtrl.close();
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_2014 = class_2238(param1).getParser();
         class_21.log("Got subscription info: " + _loc2_.productName + ", " + _loc2_.daysToPeriodEnd + ", " + _loc2_.memberPeriods + ", " + _loc2_.periodsSubscribedAhead + ", " + _loc2_.responseType);
         data.hcMember = _loc2_.daysToPeriodEnd > 0;
      }
      
      private function onRoomForward(param1:IMessageEvent) : void
      {
         var _loc2_:class_2523 = class_2311(param1).getParser();
         class_21.log("Got room forward: " + _loc2_.roomId);
         forwardToRoom(_loc2_.roomId);
      }
      
      private function onConvertedRoomId(param1:IMessageEvent) : void
      {
         var _loc2_:class_2444 = class_3601(param1).getParser();
         if(_navigator.webRoomReport)
         {
            _navigator.habboHelp.reportRoom(_loc2_.convertedId,_navigator.webRoomReportedName,"");
         }
         else
         {
            class_21.log("Got converted room ID for " + _loc2_.globalId + ", forward to room " + _loc2_.convertedId);
            forwardToRoom(_loc2_.convertedId);
         }
      }
      
      private function onNavigatorSettings(param1:IMessageEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:* = false;
         var _loc7_:int = 0;
         var _loc5_:Boolean = false;
         var _loc2_:class_2673 = class_2826(param1).getParser();
         class_21.log("Got navigator settings: " + _loc2_.homeRoomId);
         var _loc3_:* = !_navigator.data.settingsReceived;
         _navigator.data.homeRoomId = _loc2_.homeRoomId;
         _navigator.data.settingsReceived = true;
         _navigator.mainViewCtrl.refresh();
         var _loc8_:int = -1;
         var _loc9_:int = -1;
         if(_loc3_ && !HabboComponentFlags.isRoomViewerMode(_navigator.flags))
         {
            _loc6_ = false;
            _loc4_ = false;
            if(_navigator.propertyExists("friend.id"))
            {
               _loc8_ = 0;
               _navigator.send(new class_2765(int(_navigator.getProperty("friend.id"))));
            }
            if(_navigator.propertyExists("forward.type") && _navigator.propertyExists("forward.id"))
            {
               _loc8_ = int(_navigator.getProperty("forward.type"));
               _loc9_ = int(_navigator.getProperty("forward.id"));
            }
            _loc4_ = _loc2_.roomIdToEnter <= 0;
            if(_loc8_ == 2)
            {
               class_21.log("Guest room forward on enter: " + _loc9_);
               forwardToRoom(_loc9_);
            }
            else if(_loc8_ == -1)
            {
               if(!_loc4_)
               {
                  _loc7_ = _loc2_.roomIdToEnter;
                  if(_loc7_ != _navigator.data.homeRoomId)
                  {
                     this._navigator.goToRoom(_loc7_,true);
                  }
                  else
                  {
                     _loc5_ = this._navigator.goToHomeRoom();
                     if(!_loc5_)
                     {
                        _loc6_ = true;
                     }
                  }
               }
            }
            if(_loc6_ && !_navigator.mainViewCtrl.isOpen())
            {
               _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
            }
         }
         else
         {
            _navigator.roomInfoViewCtrl.reload();
         }
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         class_21.log("Navigator: exiting room");
         data.onRoomExit();
         _navigator.roomInfoViewCtrl.close();
         _navigator.roomEventInfoCtrl.close();
         _navigator.roomEventViewCtrl.close();
         _navigator.roomSettingsCtrl.close();
         _navigator.roomFilterCtrl.close();
         var _loc2_:Boolean = _navigator.getBoolean("news.auto_popup.enabled");
         if(_loc2_)
         {
            HabboWebTools.openNews();
         }
      }
      
      private function onUserFlatCats(param1:IMessageEvent) : void
      {
         var _loc3_:class_2975 = (param1 as class_2969).getParser();
         _navigator.data.categories = _loc3_.nodes;
         var _loc2_:RoomsTabPageDecorator = RoomsTabPageDecorator(_navigator.tabs.getTab(2).tabPageDecorator);
         _loc2_.prepareRoomCategories();
      }
      
      private function onUserEventCats(param1:IMessageEvent) : void
      {
         var _loc2_:class_2330 = (param1 as class_2868).getParser();
         _navigator.data.eventCategories = _loc2_.eventCategories;
      }
      
      private function onRoomSettingsData(param1:IMessageEvent) : void
      {
         var _loc2_:class_2306 = null;
         try
         {
            _loc2_ = (param1 as class_3199).getParser();
            _navigator.roomSettingsCtrl.onRoomSettings(_loc2_.data);
            class_21.log("GOT ROOM SETTINGS DATA: " + _loc2_.data.name + ", " + _loc2_.data.maximumVisitors + ", " + _loc2_.data.maximumVisitorsLimit);
         }
         catch(e:Error)
         {
            class_21.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
         }
      }
      
      private function onRoomFilterSettings(param1:IMessageEvent) : void
      {
         var _loc2_:class_2635 = (param1 as class_2936).getParser();
         _navigator.roomFilterCtrl.onRoomFilterSettings(_loc2_.badWords);
         class_21.log("GOT ROOM FILTER SETTINGS: " + _loc2_.badWords);
      }
      
      private function onRoomSettingsError(param1:IMessageEvent) : void
      {
         var _loc2_:class_2757 = (param1 as class_2584).getParser();
      }
      
      private function onRoomSettingsSaved(param1:IMessageEvent) : void
      {
         var _loc2_:class_3363 = (param1 as class_2887).getParser();
         ErrorReportStorage.addDebugData("IncomingEvent","Room settings saved: " + _loc2_.roomId);
         _navigator.mainViewCtrl.reloadRoomList(5);
      }
      
      private function onRoomSettingsSaveError(param1:IMessageEvent) : void
      {
         var _loc2_:class_2512 = (param1 as class_3479).getParser();
         _navigator.roomSettingsCtrl.onRoomSettingsSaveError(_loc2_.roomId,_loc2_.errorCode,_loc2_.info);
      }
      
      private function onRoomInfoUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:class_3258 = (param1 as class_2822).getParser();
         class_21.log("ROOM UPDATED: " + _loc2_.flatId);
         _navigator.send(new class_2003(_loc2_.flatId,false,false));
      }
      
      private function onFavourites(param1:IMessageEvent) : void
      {
         var _loc2_:class_3553 = (param1 as class_2312).getParser();
         _navigator.data.onFavourites(_loc2_);
      }
      
      private function onFavouriteChanged(param1:IMessageEvent) : void
      {
         var _loc2_:class_3209 = (param1 as class_3190).getParser();
         class_21.log("Received favourite changed: " + _loc2_.flatId + ", " + _loc2_.added);
         _navigator.data.favouriteChanged(_loc2_.flatId,_loc2_.added);
         _navigator.roomInfoViewCtrl.reload();
         _navigator.mainViewCtrl.refresh();
      }
      
      private function onCanCreateRoom(param1:IMessageEvent) : void
      {
         var _loc2_:AlertView = null;
         var _loc3_:class_3298 = (param1 as class_3470).getParser();
         class_21.log("Can create room: " + _loc3_.resultCode + ", " + _loc3_.roomLimit);
         if(_loc3_.resultCode == 0)
         {
            _navigator.roomCreateViewCtrl.show();
         }
         else
         {
            _navigator.registerParameter("navigator.createroom.limitreached","limit","" + _loc3_.roomLimit);
            if(_navigator.sessionData.hasVip)
            {
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.createroom.error}","${navigator.createroom.limitreached}");
            }
            else
            {
               _loc2_ = new ClubPromoAlertView(_navigator,"${navigator.createroom.error}","${navigator.createroom.limitreached}","${navigator.createroom.vippromo}");
            }
            _loc2_.show();
         }
      }
      
      private function onFlatControllers(param1:IMessageEvent) : void
      {
         var _loc2_:class_2454 = (param1 as class_3120).getParser();
         class_21.log("Got flat controllers: " + _loc2_.roomId + ", " + _loc2_.controllers.length);
         _navigator.roomSettingsCtrl.onFlatControllers(_loc2_.roomId,_loc2_.controllers);
      }
      
      private function onFlatControllerAdded(param1:IMessageEvent) : void
      {
         var _loc2_:class_3053 = (param1 as class_3549).getParser();
         class_21.log("Flat controller added: " + _loc2_.flatId + ", " + _loc2_.data.userId + ", " + _loc2_.data.userName);
         _navigator.roomSettingsCtrl.onFlatControllerAdded(_loc2_.flatId,_loc2_.data);
      }
      
      private function onFlatControllerRemoved(param1:IMessageEvent) : void
      {
         var _loc2_:class_2744 = (param1 as class_3289).getParser();
         class_21.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
         _navigator.roomSettingsCtrl.onFlatControllerRemoved(_loc2_.flatId,_loc2_.userId);
      }
      
      private function onBannedUsersFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:class_3144 = (param1 as class_3397).getParser();
         class_21.log("Got Banned users for room: " + _loc2_.roomId + ", " + _loc2_.bannedUsers.length);
         _navigator.roomSettingsCtrl.onBannedUsersFromRoom(_loc2_.roomId,_loc2_.bannedUsers);
      }
      
      private function onUserUnbannedFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:class_3093 = (param1 as class_3578).getParser();
         class_21.log("User was unbanned from room. User Id: " + _loc2_.userId + " Room Id: " + _loc2_.roomId);
         _navigator.roomSettingsCtrl.onUserUnbannedFromRoom(_loc2_.roomId,_loc2_.userId);
      }
      
      private function onError(param1:IMessageEvent) : void
      {
         var event:IMessageEvent = param1;
         var error:class_2819 = event as class_2819;
         if(error == null)
         {
            return;
         }
         switch(error.getParser().errorCode)
         {
            case -100002:
               _navigator.passwordInput.showRetry();
               break;
            case 4009:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.need.to.be.vip}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               break;
            case 4010:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.invalid_room_name}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               break;
            case 4011:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.cannot_perm_ban}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               break;
            case 4013:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.room_in_maintenance}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               break;
            case -100005:
               _navigator.windowManager.alert("${generic.alert.title}","${notification.nft_token_required}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
         }
      }
      
      private function onDoorbell(param1:IMessageEvent) : void
      {
         var _loc2_:class_3285 = param1 as class_3285;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.userName != "")
         {
            return;
         }
         _navigator.doorbell.showWaiting();
      }
      
      private function onDoorOpened(param1:IMessageEvent) : void
      {
         var _loc3_:class_2634 = param1 as class_2634;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_3365 = _loc3_.getParser();
         if(_loc2_ != null && (_loc2_.userName == null || _loc2_.userName.length == 0))
         {
            _navigator.doorbell.hide();
         }
      }
      
      private function onRoomRating(param1:IMessageEvent) : void
      {
         var _loc2_:class_3383 = (param1 as class_3167).getParser();
         _navigator.data.currentRoomRating = _loc2_.rating;
         _navigator.data.canRate = _loc2_.canRate;
         this._navigator.roomInfoViewCtrl.reload();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:class_3447 = (param1 as class_3544).getParser();
         if(_loc2_.userName == null || _loc2_.userName == "")
         {
            _navigator.doorbell.showNoAnswer();
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         _navigator.data.friendList.onFriendsListFragment(param1);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         _navigator.data.friendList.onFriendListUpdate(param1);
         _navigator.roomSettingsCtrl.onFriendListUpdate();
      }
      
      private function onCompetitionData(param1:class_2881) : void
      {
         _navigator.data.competitionRoomsData = param1.getParser().data;
      }
      
      private function forwardToRoom(param1:int) : void
      {
         _navigator.send(new class_2003(param1,false,true));
         _navigator.trackNavigationDataPoint("Room Forward","go.roomforward","",param1);
      }
      
      private function onNoOwnedRoomsAlert(param1:class_2540) : void
      {
         _navigator.startRoomCreation();
      }
      
      private function closeOpenCantConnectAlerts() : void
      {
         var _loc1_:Array = null;
         var _loc7_:class_1892 = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:class_1741 = null;
         var _loc3_:AlertView = null;
         if(_navigator != null)
         {
            _loc1_ = [];
            _loc7_ = _navigator.windowManager.getWindowContext(2);
            _loc4_ = int(_loc7_.getDesktopWindow().numChildren);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc7_.getDesktopWindow().getChildAt(_loc5_);
               if(_loc6_.tags.indexOf("SimpleAlertView") > -1)
               {
                  _loc1_.push(_loc6_);
               }
               _loc5_++;
            }
            if(_loc1_.length > 0)
            {
               for each(var _loc2_ in _loc1_)
               {
                  _loc3_ = AlertView.findAlertView(_loc2_);
                  if(_loc3_ != null)
                  {
                     _loc3_.dispose();
                  }
               }
            }
         }
      }
      
      private function onCantConnect(param1:IMessageEvent) : void
      {
         var _loc2_:SimpleAlertView = null;
         var _loc3_:class_3142 = (param1 as class_3332).getParser();
         class_21.log("FAILED TO CONNECT: REASON: " + _loc3_.reason);
         switch(_loc3_.reason - 1)
         {
            case 0:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.guestroomfull.title}","${navigator.guestroomfull.text}");
               _loc2_.show();
               break;
            case 2:
               _loc2_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error." + _loc3_.parameter + "}");
               _loc2_.show();
               break;
            case 3:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.banned.title}","${navigator.banned.text}");
               _loc2_.show();
               break;
            case 4:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.blocked.title}","${navigator.blocked.text}");
               _loc2_.show();
               break;
            default:
               _loc2_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error.title}");
               _loc2_.show();
         }
         _navigator.send(new class_2589());
         var _loc4_:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
         _loc4_.iconId = "HTIE_ICON_RECEPTION";
         _navigator.toolbar.events.dispatchEvent(_loc4_);
      }
      
      private function onEnforceRoomCategorySelection(param1:IMessageEvent) : void
      {
         var _loc2_:class_3551 = (param1 as class_3538).getParser();
         _navigator.enforceCategoryCtrl.show(_loc2_.selectionType);
      }
   }
}

