package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.friendlist.Util;
   import com.sulake.habbo.friendlist.class_1807;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import package_11.*;
   import package_14.*;
   
   public class FriendCategories
   {
      
      private static const STOP_SORTING_FRIENDLIST:int = 200;
      
      private var var_741:class_1836;
      
      private var var_143:Array = [];
      
      private var var_1739:Dictionary = new Dictionary();
      
      public function FriendCategories(param1:class_1836)
      {
         super();
         var_741 = param1;
      }
      
      public function addFriend(param1:Friend) : FriendCategory
      {
         var _loc2_:int = param1.online ? param1.categoryId : -1;
         var _loc3_:FriendCategory = findCategory(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.addFriend(param1);
            var_1739[param1.id] = param1;
            return _loc3_;
         }
         class_21.log("No category " + _loc2_ + " found for friend " + param1.id + ". Ignoring");
         return null;
      }
      
      public function sort(param1:Boolean = false) : void
      {
         for each(var _loc2_ in var_143)
         {
            if(!param1 || _loc2_.friends.length < 200)
            {
               _loc2_.sort();
            }
         }
      }
      
      public function getSelectedFriends() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in var_143)
         {
            _loc2_.getSelectedFriends(_loc1_);
         }
         return _loc1_;
      }
      
      public function getSelectedFriend() : Friend
      {
         var _loc1_:Array = getSelectedFriends();
         return _loc1_.length == 1 ? _loc1_[0] : null;
      }
      
      public function getAllFriends() : Dictionary
      {
         return var_1739;
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in var_143)
         {
            _loc3_ += _loc4_.getFriendCount(param1,param2);
         }
         return _loc3_;
      }
      
      public function getCategories() : Array
      {
         return var_143;
      }
      
      public function addCategory(param1:FriendCategory) : void
      {
         var_143.push(param1);
      }
      
      public function findFriend(param1:int) : Friend
      {
         return var_1739[param1];
      }
      
      public function findCategory(param1:int) : FriendCategory
      {
         for each(var _loc2_ in var_143)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc5_:Friend = null;
         var _loc2_:class_2429 = (param1 as class_1937).getParser();
         updateCategories(_loc2_.cats);
         for each(var _loc4_ in _loc2_.removedFriendIds)
         {
            removeFriend(_loc4_,true);
         }
         for each(var _loc7_ in _loc2_.updatedFriends)
         {
            class_21.log("Got UPDATE: " + _loc7_.id + ", " + _loc7_.online + ", " + _loc7_.name + ", " + _loc7_.followingAllowed);
            var_741.messenger.setFollowingAllowed(_loc7_.id,_loc7_.followingAllowed && _loc7_.online);
            var _loc8_:Boolean = isFriendOnline(_loc7_.id);
            if(_loc8_ && !_loc7_.online)
            {
               var_741.messenger.setOnlineStatus(_loc7_.id,_loc7_.online);
            }
            if(_loc7_.online)
            {
               var_741.messenger.setOnlineStatus(_loc7_.id,_loc7_.online);
               var_741.view.setNewMessageArrived();
            }
            var _loc3_:Friend = removeFriend(_loc7_.id,true);
            _loc5_ = new Friend(_loc7_);
            _loc5_.selected = false;
            addFriend(_loc5_);
         }
         for each(var _loc6_ in _loc2_.addedFriends)
         {
            _loc5_ = new Friend(_loc6_);
            class_21.log("Got INSERT: " + _loc6_.id + ", " + _loc6_.name);
            removeFriend(_loc6_.id,true);
            addFriend(_loc5_);
         }
         sort(true);
         this.var_741.view.refreshList();
      }
      
      internal function notifyFriendOnline(param1:Friend, param2:class_1827 = null) : void
      {
         if(!(var_741.messenger as class_17).getBoolean("friend_online_indicator.enabled"))
         {
            return;
         }
         var _loc3_:BitmapData = null;
         if(param2 == null)
         {
            var _loc4_:FriendOnlineImageListener = new FriendOnlineImageListener(param1,this);
            param2 = var_741.avatarManager.createAvatarImage(param1.figure,"h",null,null);
         }
         if(param2 == null || param2.isPlaceholder())
         {
            if(param2 != null)
            {
               param2.dispose();
            }
            return;
         }
         _loc3_ = HabboFaceFocuser.focusUserFace(param2,"head",2,1);
         _loc3_ = HabboFaceFocuser.cutCircleFromBitmap(_loc3_,22);
         param2.dispose();
         var _loc5_:String = var_741.localizations.getLocalizationWithParams("notifications.friend_online","","name",param1.name);
         var_741.notifications.addItemWithBitmap(_loc5_,"friendonline",_loc3_,"messenger/" + param1.id);
      }
      
      private function updateCategories(param1:Array) : void
      {
         var _loc3_:FriendCategory = null;
         flushReceivedStatus();
         findCategory(-1).received = true;
         findCategory(0).received = true;
         for each(var _loc4_ in param1)
         {
            _loc3_ = findCategory(_loc4_.id);
            if(_loc3_ != null)
            {
               _loc3_.received = true;
               if(_loc3_.name != _loc4_.name)
               {
                  _loc3_.name = _loc4_.name;
               }
            }
         }
         for each(var _loc2_ in getCategoriesNotReceived())
         {
            if(_loc2_.friends.length <= 0)
            {
               Util.remove(var_143,_loc2_);
               _loc2_.dispose();
            }
         }
      }
      
      private function removeFriend(param1:int, param2:Boolean) : Friend
      {
         if(param2)
         {
            var_1739[param1] = null;
         }
         var _loc4_:Friend = null;
         for each(var _loc3_ in var_143)
         {
            _loc4_ = _loc3_.removeFriend(param1);
            if(_loc4_ != null)
            {
               if(param2)
               {
                  _loc4_.dispose();
               }
            }
         }
         return _loc4_;
      }
      
      private function flushReceivedStatus() : void
      {
         for each(var _loc1_ in var_143)
         {
            _loc1_.received = false;
         }
      }
      
      private function getCategoriesNotReceived() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in var_143)
         {
            if(!_loc2_.received)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:Friend = findFriend(param1);
         return _loc2_?.online;
      }
      
      public function getFriendNames() : Array
      {
         if(var_1739 == null)
         {
            return [];
         }
         var _loc1_:Array = [];
         for each(var _loc2_ in var_1739)
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.name);
            }
         }
         return _loc1_;
      }
      
      public function get view() : class_1807
      {
         return this.var_741.view;
      }
      
      public function get deps() : class_1836
      {
         return var_741;
      }
   }
}

