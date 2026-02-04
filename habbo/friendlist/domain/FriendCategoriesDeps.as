package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.class_1807;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.notifications.class_536;
   
   public class FriendCategoriesDeps implements class_1836
   {
      
      private var _friendList:HabboFriendList;
      
      public function FriendCategoriesDeps(param1:HabboFriendList)
      {
         super();
         this._friendList = param1;
      }
      
      public function get view() : class_1807
      {
         return _friendList.tabs.findTab(1).tabView as class_1807;
      }
      
      public function get messenger() : class_46
      {
         return this._friendList.messenger;
      }
      
      public function get notifications() : class_536
      {
         return this._friendList.notifications;
      }
      
      public function get avatarManager() : class_48
      {
         return this._friendList.avatarManager;
      }
      
      public function get localizations() : class_27
      {
         return this._friendList.localization;
      }
   }
}

