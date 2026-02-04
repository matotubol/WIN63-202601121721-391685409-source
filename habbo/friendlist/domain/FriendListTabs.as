package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.*;
   
   public class FriendListTabs
   {
      
      private var var_741:class_2235;
      
      private var var_817:Array = [];
      
      private var var_3520:FriendListTab;
      
      private var var_1752:int = 200;
      
      private var var_3891:int = 200;
      
      private var _windowWidth:int = 230;
      
      public function FriendListTabs(param1:class_2235)
      {
         super();
         var_741 = param1;
         var_817.push(new FriendListTab(var_741.getFriendList(),1,new FriendsView(),"${friendlist.friends}","friends_footer","hdr_friends"));
         var_817.push(new FriendListTab(var_741.getFriendList(),2,new class_3396(),"${friendlist.tab.friendrequests}","friend_requests_footer","hdr_friend_requests"));
         var_817.push(new FriendListTab(var_741.getFriendList(),3,new SearchView(),"${generic.search}","search_footer","hdr_search"));
         toggleSelected(null);
      }
      
      public function getTabs() : Array
      {
         return var_817;
      }
      
      public function findTab(param1:int) : FriendListTab
      {
         for each(var _loc2_ in var_817)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function clearSelections() : void
      {
         for each(var _loc1_ in var_817)
         {
            _loc1_.setSelected(false);
         }
      }
      
      public function findSelectedTab() : FriendListTab
      {
         for each(var _loc1_ in var_817)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function toggleSelected(param1:FriendListTab) : void
      {
         var _loc2_:FriendListTab = findSelectedTab();
         if(_loc2_ == null)
         {
            var_1752 = var_3891;
            setSelected(determineDisplayedTab(param1),true);
         }
         else if(_loc2_ == param1 || param1 == null)
         {
            var_3891 = var_1752;
            var_1752 = 0;
            clearSelections();
         }
         else
         {
            setSelected(determineDisplayedTab(param1),true);
         }
      }
      
      private function setSelected(param1:FriendListTab, param2:Boolean) : void
      {
         var _loc3_:FriendListTab = findSelectedTab();
         clearSelections();
         param1.setSelected(param2);
         if(param2)
         {
            var_3520 = param1;
         }
      }
      
      private function determineDisplayedTab(param1:FriendListTab) : FriendListTab
      {
         if(param1 != null)
         {
            return param1;
         }
         if(var_3520 != null)
         {
            return var_3520;
         }
         return var_817[0];
      }
      
      public function get tabContentHeight() : int
      {
         return var_1752;
      }
      
      public function get windowWidth() : int
      {
         return _windowWidth;
      }
      
      public function get tabContentWidth() : int
      {
         return _windowWidth - 2;
      }
      
      public function set tabContentHeight(param1:int) : void
      {
         var_1752 = param1;
      }
      
      public function set windowWidth(param1:int) : void
      {
         _windowWidth = param1;
      }
   }
}

