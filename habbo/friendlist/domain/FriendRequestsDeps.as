package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.class_1747;
   
   public class FriendRequestsDeps implements class_1842
   {
      
      private var _friendList:HabboFriendList;
      
      public function FriendRequestsDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function get view() : class_1747
      {
         return _friendList.tabs.findTab(2).tabView as class_1747;
      }
   }
}

