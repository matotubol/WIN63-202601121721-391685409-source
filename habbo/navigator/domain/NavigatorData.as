package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.roomsettings.class_3389;
   import flash.utils.Dictionary;
   import package_17.*;
   import package_42.*;
   import package_50.class_1996;
   
   public class NavigatorData
   {
      
      private static const MAX_HISTORY_LENGTH:int = 10;
      
      private var _navigator:HabboNavigator;
      
      private var _lastMsg:class_2637;
      
      private var var_1381:class_2842;
      
      private var var_4629:Boolean;
      
      private var var_2979:Boolean;
      
      private var var_1450:Boolean;
      
      private var var_19:int;
      
      private var var_2699:int;
      
      private var _enteredGuestRoom:class_1945;
      
      private var var_4293:Boolean;
      
      private var var_4852:int;
      
      private var _hotRoomPopupOpen:Boolean;
      
      private var var_3102:int;
      
      private var var_4925:Boolean;
      
      private var var_1719:Array = [];
      
      private var var_2299:Array = [];
      
      private var var_2659:Array = [];
      
      private var var_2221:Array = [];
      
      private var var_5188:int;
      
      private var var_3323:int;
      
      private var var_2195:Dictionary = new Dictionary();
      
      private var var_1217:Boolean;
      
      private var var_4710:int;
      
      private var var_4229:Boolean;
      
      private var var_3896:Boolean;
      
      private var var_4863:int = 0;
      
      private var var_3188:class_2460;
      
      private var _promotedRooms:class_2950;
      
      private var _friendList:class_3389 = new class_3389();
      
      private var var_2916:RoomSessionTags;
      
      private var var_4870:class_1904;
      
      public function NavigatorData(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function get canAddFavourite() : Boolean
      {
         return _enteredGuestRoom != null && !var_1450;
      }
      
      public function get canEditRoomSettings() : Boolean
      {
         return _enteredGuestRoom != null && (var_1450 || _navigator.sessionData.hasSecurity(5));
      }
      
      public function onRoomEnter(param1:class_1996) : void
      {
         _enteredGuestRoom = null;
         var_1450 = false;
         var_1450 = param1.owner;
         var_19 = param1.guestRoomId;
      }
      
      public function onRoomExit() : void
      {
         if(var_1381 != null)
         {
            var_1381.dispose();
            var_1381 = null;
         }
         if(_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
            _enteredGuestRoom = null;
         }
         var_1450 = false;
      }
      
      public function set enteredRoom(param1:class_1945) : void
      {
         if(_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
         }
         _enteredGuestRoom = param1;
      }
      
      public function set roomEventData(param1:class_2842) : void
      {
         if(var_1381 != null)
         {
            var_1381.dispose();
         }
         var_1381 = param1;
      }
      
      public function get popularTagsArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as class_3323 != null;
      }
      
      public function get guestRoomSearchArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as class_3464 != null;
      }
      
      public function get officialRoomsArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as class_2638 != null;
      }
      
      public function get categoriesWithUserCountArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as class_3568 != null;
      }
      
      public function set guestRoomSearchResults(param1:class_3464) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_3188 = param1.ad;
         var_1217 = false;
      }
      
      public function set popularTags(param1:class_3323) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_1217 = false;
      }
      
      public function set officialRooms(param1:class_2638) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_1217 = false;
      }
      
      public function set categoriesWithVisitorData(param1:class_3568) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_1217 = false;
      }
      
      private function disposeCurrentMsg() : void
      {
         if(_lastMsg == null)
         {
            return;
         }
         _lastMsg.dispose();
         _lastMsg = null;
      }
      
      public function set adRoom(param1:class_2460) : void
      {
         var_3188 = param1;
      }
      
      public function set promotedRooms(param1:class_2950) : void
      {
         _promotedRooms = param1;
      }
      
      public function get adRoom() : class_2460
      {
         return var_3188;
      }
      
      public function get guestRoomSearchResults() : class_3464
      {
         return _lastMsg as class_3464;
      }
      
      public function get popularTags() : class_3323
      {
         return _lastMsg as class_3323;
      }
      
      public function get officialRooms() : class_2638
      {
         return _lastMsg as class_2638;
      }
      
      public function get categoriesWithVisitorData() : class_3568
      {
         return _lastMsg as class_3568;
      }
      
      public function get promotedRooms() : class_2950
      {
         return _promotedRooms;
      }
      
      public function get roomEventData() : class_2842
      {
         return var_1381;
      }
      
      public function get avatarId() : int
      {
         return var_2699;
      }
      
      public function get eventMod() : Boolean
      {
         return var_4629;
      }
      
      public function get roomPicker() : Boolean
      {
         return var_2979;
      }
      
      public function get currentRoomOwner() : Boolean
      {
         return var_1450;
      }
      
      public function get enteredGuestRoom() : class_1945
      {
         return _enteredGuestRoom;
      }
      
      public function get hcMember() : Boolean
      {
         return var_4293;
      }
      
      public function get createdFlatId() : int
      {
         return var_4852;
      }
      
      public function get homeRoomId() : int
      {
         return var_3102;
      }
      
      public function get hotRoomPopupOpen() : Boolean
      {
         return _hotRoomPopupOpen;
      }
      
      public function get currentRoomRating() : int
      {
         return var_4710;
      }
      
      public function get canRate() : Boolean
      {
         return var_4229;
      }
      
      public function get settingsReceived() : Boolean
      {
         return var_4925;
      }
      
      public function get adIndex() : int
      {
         return var_4863;
      }
      
      public function get currentRoomIsStaffPick() : Boolean
      {
         return var_3896;
      }
      
      public function get currentRoomId() : int
      {
         return var_19;
      }
      
      public function set avatarId(param1:int) : void
      {
         var_2699 = param1;
      }
      
      public function set createdFlatId(param1:int) : void
      {
         var_4852 = param1;
      }
      
      public function set hcMember(param1:Boolean) : void
      {
         var_4293 = param1;
      }
      
      public function set eventMod(param1:Boolean) : void
      {
         var_4629 = param1;
      }
      
      public function set roomPicker(param1:Boolean) : void
      {
         var_2979 = param1;
      }
      
      public function set hotRoomPopupOpen(param1:Boolean) : void
      {
         _hotRoomPopupOpen = param1;
      }
      
      public function set homeRoomId(param1:int) : void
      {
         var_3102 = param1;
      }
      
      public function set currentRoomRating(param1:int) : void
      {
         var_4710 = param1;
      }
      
      public function set canRate(param1:Boolean) : void
      {
         var_4229 = param1;
      }
      
      public function set settingsReceived(param1:Boolean) : void
      {
         var_4925 = param1;
      }
      
      public function set adIndex(param1:int) : void
      {
         var_4863 = param1;
      }
      
      public function set currentRoomIsStaffPick(param1:Boolean) : void
      {
         var_3896 = param1;
      }
      
      public function set categories(param1:Array) : void
      {
         var_1719 = param1;
         var_2299 = [];
         for each(var _loc2_ in var_1719)
         {
            if(_loc2_.visible)
            {
               var_2299.push(_loc2_);
            }
         }
      }
      
      public function get allCategories() : Array
      {
         return var_1719;
      }
      
      public function get visibleCategories() : Array
      {
         return var_2299;
      }
      
      public function getCategoryById(param1:int) : class_3364
      {
         for each(var _loc2_ in var_1719)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function set eventCategories(param1:Array) : void
      {
         var_2659 = param1;
         var_2221 = [];
         for each(var _loc2_ in var_2659)
         {
            if(_loc2_.visible)
            {
               var_2221.push(_loc2_);
            }
         }
      }
      
      public function get allEventCategories() : Array
      {
         return var_2659;
      }
      
      public function get visibleEventCategories() : Array
      {
         return var_2221;
      }
      
      public function getEventCategoryById(param1:int) : class_2482
      {
         for each(var _loc2_ in var_1719)
         {
            if(_loc2_.categoryId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onFavourites(param1:class_3553) : void
      {
         this.var_5188 = param1.limit;
         this.var_3323 = param1.favouriteRoomIds.length;
         this.var_2195 = new Dictionary();
         for each(var _loc2_ in param1.favouriteRoomIds)
         {
            this.var_2195[_loc2_] = "yes";
         }
      }
      
      public function favouriteChanged(param1:int, param2:Boolean) : void
      {
         var_2195[param1] = param2 ? "yes" : null;
         var_3323 += param2 ? 1 : -1;
      }
      
      public function isCurrentRoomFavourite() : Boolean
      {
         var _loc1_:int = _enteredGuestRoom.flatId;
         return var_2195[_loc1_] != null;
      }
      
      public function isCurrentRoomHome() : Boolean
      {
         if(_enteredGuestRoom == null)
         {
            return false;
         }
         var _loc1_:int = _enteredGuestRoom.flatId;
         return this.var_3102 == _loc1_;
      }
      
      public function isRoomFavourite(param1:int) : Boolean
      {
         return var_2195[param1] != null;
      }
      
      public function isFavouritesFull() : Boolean
      {
         return var_3323 >= var_5188;
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         return param1 == var_3102;
      }
      
      public function startLoading() : void
      {
         this.var_1217 = true;
      }
      
      public function isLoading() : Boolean
      {
         return this.var_1217;
      }
      
      public function get friendList() : class_3389
      {
         return _friendList;
      }
      
      public function getAndResetSessionTags() : RoomSessionTags
      {
         var _loc1_:RoomSessionTags = var_2916;
         var_2916 = null;
         return _loc1_;
      }
      
      public function set roomSessionTags(param1:RoomSessionTags) : void
      {
         var_2916 = param1;
      }
      
      public function get competitionRoomsData() : class_1904
      {
         return var_4870;
      }
      
      public function set competitionRoomsData(param1:class_1904) : void
      {
         var_4870 = param1;
      }
   }
}

