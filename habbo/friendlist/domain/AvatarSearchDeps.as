package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.ISearchView;
   
   public class AvatarSearchDeps implements class_1801
   {
      
      private var _friendList:HabboFriendList;
      
      public function AvatarSearchDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function get view() : ISearchView
      {
         return _friendList.tabs.findTab(3).tabView as ISearchView;
      }
   }
}

