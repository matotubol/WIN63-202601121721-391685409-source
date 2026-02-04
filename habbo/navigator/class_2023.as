package com.sulake.habbo.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1892;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import package_1.class_2003;
   import package_1.class_3280;
   import package_1.class_3493;
   import package_14.class_1915;
   import package_14.class_1937;
   import package_140.class_2540;
   import package_143.class_2635;
   import package_17.class_2257;
   import package_17.class_2330;
   import package_17.class_2382;
   import package_17.class_2907;
   import package_17.class_2963;
   import package_17.class_2975;
   import package_17.class_3005;
   import package_17.class_3209;
   import package_17.class_3258;
   import package_17.class_3383;
   import package_17.class_3447;
   import package_17.class_3553;
   import package_25.class_1995;
   import package_25.class_2338;
   import package_25.class_2621;
   import package_25.class_2647;
   import package_25.class_3112;
   import package_25.class_3189;
   import package_25.class_3433;
   import package_3.class_2123;
   import package_32.class_2584;
   import package_32.class_2887;
   import package_32.class_3120;
   import package_32.class_3199;
   import package_32.class_3289;
   import package_32.class_3397;
   import package_32.class_3448;
   import package_32.class_3479;
   import package_32.class_3549;
   import package_32.class_3578;
   import package_32.class_3606;
   import package_35.class_3142;
   import package_35.class_3365;
   import package_4.class_1757;
   import package_4.class_2005;
   import package_42.class_1945;
   import package_42.class_2102;
   import package_42.class_2312;
   import package_42.class_2543;
   import package_42.class_2767;
   import package_42.class_2789;
   import package_42.class_2822;
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
   import package_42.class_3544;
   import package_44.class_1913;
   import package_54.class_2039;
   import package_54.class_2634;
   import package_54.class_3332;
   import package_61.class_2936;
   import package_72.class_2589;
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
   
   [SecureSWF(rename="true")]
   public class class_2023
   {
      
      private var _navigator:HabboNewNavigator;
      
      private var _messageListeners:Array = [];
      
      public function class_2023(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         var _loc2_:class_57 = _navigator.communication;
         addMessageListeners();
      }
      
      public function addMessageListeners() : void
      {
         var _loc1_:class_57 = _navigator.communication;
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3549(onFlatControllerAdded)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2887(onRoomSettingsSaved)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_3112(onSavedSearches)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3199(onRoomSettingsData)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3285(onDoorbell)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3544(onFlatAccessDenied)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2822(onRoomInfoUpdated)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3415(onPopularRoomTagsResult)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_3189(onNavigatorMetaData)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3578(onUserUnbannedFromRoom)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2039(onRoomExit)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2936(onRoomFilterSettings)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3125(onCanCreateRoomEventEvent)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2312(onFavourites)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_2123(onGroupDetails)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_1937(onFriendListUpdate)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2881(onCompetitionData)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2969(onUserFlatCats)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3397(onBannedUsersFromRoom)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3190(onFavouriteChanged)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_2647(onNavigatorPreferences)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3479(onRoomSettingsSaveError)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_3433(onCollapsedCategories)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3448(onMuteAllEvent)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_2338(onNavigatorSearchResultBlocks)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3332(onCantConnect)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2102(onFlatCreated)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2868(onUserEventCats)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2789(onCategoriesWithUserCount)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3289(onFlatControllerRemoved)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2540(onNoOwnedRoomsAlert)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3003(onRoomEventEvent)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3174(onRoomEventCancel)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2543(onOfficialRooms)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new class_2621(onNavigatorLiftedRooms)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3606(onNoSuchFlat)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2767(onGuestRoomSearchResult)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3167(onRoomRating)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_3120(onFlatControllers)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_1915(onFriendsListFragment)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2634(onDoorOpened)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new class_2584(onRoomSettingsError)));
      }
      
      public function removeLegacyMessageListeners() : void
      {
         var _loc1_:class_57 = _navigator.communication;
         for each(var _loc2_ in _messageListeners)
         {
            _loc1_.removeHabboConnectionMessageEvent(_loc2_);
         }
         _messageListeners = [];
      }
      
      private function onNavigatorMetaData(param1:class_3189) : void
      {
         _navigator.initialize(param1.getParser());
      }
      
      private function onNavigatorSearchResultBlocks(param1:class_2338) : void
      {
         _navigator.onSearchResult(new class_1995(param1.getParser().searchResult));
      }
      
      private function onNavigatorLiftedRooms(param1:class_2621) : void
      {
         _navigator.onLiftedRooms(param1.getParser());
      }
      
      private function onNavigatorPreferences(param1:class_2647) : void
      {
         _navigator.onPreferences(param1.getParser());
      }
      
      private function onSavedSearches(param1:class_3112) : void
      {
         _navigator.onSavedSearches(param1.getParser());
      }
      
      private function onGroupDetails(param1:class_2123) : void
      {
         _navigator.onGroupDetails(param1.data);
      }
      
      private function onCollapsedCategories(param1:class_3433) : void
      {
         _navigator.onCollapsedCategories(param1.getParser().collapsedCategories);
      }
      
      private function get data() : NavigatorData
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
            if(LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl != null)
            {
               LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
            }
         }
      }
      
      private function onNoSuchFlat(param1:IMessageEvent) : void
      {
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1913 = class_2005(param1).getParser();
         _navigator.data.avatarId = _loc2_.id;
         LegacyNavigator(_navigator.legacyNavigator).send(new class_3280());
         LegacyNavigator(_navigator.legacyNavigator).send(new class_3493());
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         if(_navigator)
         {
            var _loc2_:class_1757 = class_1757(param1);
            if(null.securityLevel >= 5)
            {
               _navigator.data.eventMod = true;
            }
            if(null.securityLevel >= 7)
            {
               _navigator.data.roomPicker = true;
            }
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
         class_21.log("Received GuestRoomSearch: " + (data.guestRoomSearchResults.rooms ? data.guestRoomSearchResults.rooms.length : " no rooms"));
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
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
      }
      
      private function onRoomEventCancel(param1:IMessageEvent) : void
      {
         data.roomEventData = null;
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
      }
      
      private function onCanCreateRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc3_:SimpleAlertView = null;
         var _loc2_:class_2907 = class_3125(param1).getParser();
         class_21.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
         if(_loc2_.canCreateEvent)
         {
            LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.show();
         }
         else
         {
            _loc3_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.cannotcreateevent.title}","${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
            _loc3_.show();
            class_21.log("Cannot create an event just now...");
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
         LegacyNavigator(_navigator.legacyNavigator).goToRoom(_loc2_.flatId,true);
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
         LegacyNavigator(_navigator.legacyNavigator).goToMainView();
         LegacyNavigator(_navigator.legacyNavigator).closeNavigator();
      }
      
      private function onGameStarted(param1:IMessageEvent) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.close();
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         class_21.log("Navigator: exiting room");
         data.onRoomExit();
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.close();
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
         var _loc2_:RoomsTabPageDecorator = RoomsTabPageDecorator(LegacyNavigator(_navigator.legacyNavigator).tabs.getTab(2).tabPageDecorator);
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
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettings(_loc2_.data);
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
         LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.onRoomFilterSettings(_loc2_.badWords);
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
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
      }
      
      private function onRoomSettingsSaveError(param1:IMessageEvent) : void
      {
         var _loc2_:class_2512 = (param1 as class_3479).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettingsSaveError(_loc2_.roomId,_loc2_.errorCode,_loc2_.info);
      }
      
      private function onRoomInfoUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:class_3258 = (param1 as class_2822).getParser();
         LegacyNavigator(_navigator.legacyNavigator).send(new class_2003(_loc2_.flatId,false,false));
      }
      
      private function onFavourites(param1:IMessageEvent) : void
      {
         var _loc2_:class_3553 = (param1 as class_2312).getParser();
         _navigator.data.onFavourites(_loc2_);
      }
      
      private function onFavouriteChanged(param1:IMessageEvent) : void
      {
         var _loc2_:class_3209 = (param1 as class_3190).getParser();
         data.favouriteChanged(_loc2_.flatId,_loc2_.added);
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.refresh();
      }
      
      private function onFlatControllers(param1:IMessageEvent) : void
      {
         var _loc2_:class_2454 = (param1 as class_3120).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllers(_loc2_.roomId,_loc2_.controllers);
      }
      
      private function onFlatControllerAdded(param1:IMessageEvent) : void
      {
         var _loc2_:class_3053 = (param1 as class_3549).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerAdded(_loc2_.flatId,_loc2_.data);
      }
      
      private function onFlatControllerRemoved(param1:IMessageEvent) : void
      {
         var _loc2_:class_2744 = (param1 as class_3289).getParser();
         class_21.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerRemoved(_loc2_.flatId,_loc2_.userId);
      }
      
      private function onBannedUsersFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:class_3144 = (param1 as class_3397).getParser();
         class_21.log("Got Banned users for room: " + _loc2_.roomId + ", " + _loc2_.bannedUsers.length);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onBannedUsersFromRoom(_loc2_.roomId,_loc2_.bannedUsers);
      }
      
      private function onUserUnbannedFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:class_3093 = (param1 as class_3578).getParser();
         class_21.log("User was unbanned from room. User Id: " + _loc2_.userId + " Room Id: " + _loc2_.roomId);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onUserUnbannedFromRoom(_loc2_.roomId,_loc2_.userId);
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
         LegacyNavigator(_navigator.legacyNavigator).doorbell.showWaiting();
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
            LegacyNavigator(_navigator.legacyNavigator).doorbell.hide();
         }
      }
      
      private function onRoomRating(param1:IMessageEvent) : void
      {
         var _loc2_:class_3383 = (param1 as class_3167).getParser();
         data.currentRoomRating = _loc2_.rating;
         data.canRate = _loc2_.canRate;
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:class_3447 = (param1 as class_3544).getParser();
         if(_loc2_.userName == null || _loc2_.userName == "")
         {
            LegacyNavigator(_navigator.legacyNavigator).doorbell.showNoAnswer();
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         data.friendList.onFriendsListFragment(param1);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         data.friendList.onFriendListUpdate(param1);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFriendListUpdate();
      }
      
      private function onCompetitionData(param1:class_2881) : void
      {
         data.competitionRoomsData = param1.getParser().data;
      }
      
      private function forwardToRoom(param1:int) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).send(new class_2003(param1,false,true));
         LegacyNavigator(_navigator.legacyNavigator).trackNavigationDataPoint("Room Forward","go.roomforward","",param1);
      }
      
      private function onNoOwnedRoomsAlert(param1:class_2540) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).startRoomCreation();
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
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.guestroomfull.title}","${navigator.guestroomfull.text}");
               _loc2_.show();
               break;
            case 2:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${room.queue.error.title}","${room.queue.error." + _loc3_.parameter + "}");
               _loc2_.show();
               break;
            case 3:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.banned.title}","${navigator.banned.text}");
               _loc2_.show();
               break;
            case 4:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.blocked.title}","${navigator.blocked.text}");
               _loc2_.show();
               break;
            default:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${room.queue.error.title}","${room.queue.error.title}");
               _loc2_.show();
         }
         LegacyNavigator(_navigator.legacyNavigator).send(new class_2589());
         var _loc4_:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
         _loc4_.iconId = "HTIE_ICON_RECEPTION";
         LegacyNavigator(_navigator.legacyNavigator).toolbar.events.dispatchEvent(_loc4_);
      }
   }
}

