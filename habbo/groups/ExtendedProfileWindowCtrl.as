package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.friendlist.class_2242;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.users.class_2228;
   import com.sulake.habbo.communication.messages.incoming.users.class_3489;
   import com.sulake.habbo.communication.messages.incoming.users.class_3604;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
   
   public class ExtendedProfileWindowCtrl implements class_13, ILinkEventTracker
   {
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_1812;
      
      private var var_1326:IItemListWindow;
      
      private var var_3591:class_1812;
      
      private var var_372:int;
      
      private var var_1867:GroupDetailsCtrl;
      
      private var var_1817:class_1812;
      
      private var var_24:class_2228;
      
      private var var_2797:Boolean;
      
      private var var_4555:Boolean = false;
      
      private var var_950:class_55 = new class_55();
      
      private var var_4324:Boolean = false;
      
      public function ExtendedProfileWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
         var_1867 = new GroupDetailsCtrl(param1,false);
      }
      
      public function dispose() : void
      {
         var_52 = null;
         var_1326 = null;
         var_24 = null;
         if(var_950)
         {
            var_950.dispose();
            var_950 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1867)
         {
            var_1867.dispose();
            var_1867 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         if(var_3591 == null)
         {
            var_3591 = class_1812(var_52.getXmlWindow("group_entry"));
         }
         if(var_1817 == null)
         {
            var_1817 = class_1812(var_52.getXmlWindow("no_groups"));
            var_1817.findChildByName("view_groups_button").procedure = onViewGroups;
         }
         _window = class_2250(var_52.getXmlWindow("new_extended_profile"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("addasfriend_button").procedure = onAddAsFriend;
         _window.findChildByName("rooms_button").procedure = onRooms;
         var_1326 = IItemListWindow(_window.findChildByName("groups_list"));
         _window.center();
         _window.findChildByName("change_looks").procedure = onChangeLooks;
         _window.findChildByName("change_badges").procedure = onChangeBadges;
         _window.findChildByName("user_activity_points").visible = var_52.isActivityDisplayEnabled;
         _window.findChildByName("block_button").procedure = onBlock;
         for each(var _loc1_ in class_2242.displayableStatuses)
         {
            _window.findChildByName(class_2242.statusAsString(_loc1_) + "_friend_name_link_region").procedure = onRelationshipLink;
         }
      }
      
      public function onProfileChanged(param1:int) : void
      {
         if(var_24 != null && var_24.userId == param1 && _window != null && Boolean(_window.visible))
         {
            var_52.send(new GetExtendedProfileMessageComposer(param1));
            var_2797 = true;
         }
      }
      
      public function onProfile(param1:class_2228) : void
      {
         var_24 = param1;
         var _loc2_:class_3489 = getSelectedGroup();
         if(_loc2_ == null)
         {
            if(var_24.guilds.length > 0)
            {
               var_372 = var_24.guilds[0].groupId;
               _loc2_ = var_24.guilds[0];
            }
            else
            {
               var_372 = 0;
            }
         }
         if(var_372 > 0)
         {
            var_52.send(new GetHabboGroupDetailsMessageComposer(var_372,false));
         }
         refresh();
         _window.visible = true;
         if(!var_2797)
         {
            _window.activate();
         }
         var_2797 = false;
      }
      
      private function getSelectedGroup() : class_3489
      {
         for each(var _loc1_ in var_24.guilds)
         {
            if(_loc1_.groupId == var_372)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function refresh() : void
      {
         var_52.send(new GetRelationshipStatusInfoMessageComposer(var_24.userId));
         var_52.send(new GetSelectedBadgesMessageComposer(var_24.userId));
         prepareWindow();
         refreshHeader();
         refreshGroupList();
      }
      
      private function refreshGroupList() : void
      {
         var _loc1_:class_1812 = null;
         var _loc2_:class_3087 = null;
         var _loc4_:class_1812 = null;
         var _loc3_:* = var_24.userId == var_52.avatarId;
         var_1326.visible = var_24.guilds.length > 0;
         var_1326.destroyListItems();
         for each(var _loc5_ in var_24.guilds)
         {
            _loc1_ = class_1812(var_3591.clone());
            _loc1_.id = _loc5_.groupId;
            _loc1_.findChildByName("bg_region").procedure = onSelectGroup;
            _loc1_.findChildByName("bg_region").id = _loc5_.groupId;
            _loc1_.findChildByName("clear_favourite").procedure = onClearFavourite;
            _loc1_.findChildByName("clear_favourite").visible = _loc5_.favourite && _loc3_;
            _loc1_.findChildByName("clear_favourite").id = _loc5_.groupId;
            _loc1_.findChildByName("make_favourite").procedure = onMakeFavourite;
            _loc1_.findChildByName("make_favourite").visible = !_loc5_.favourite && _loc3_;
            _loc1_.findChildByName("make_favourite").id = _loc5_.groupId;
            _loc2_ = class_3087(class_2010(_loc1_.findChildByName("group_pic_bitmap")).widget);
            _loc2_.type = "group";
            _loc2_.badgeId = _loc5_.badgeCode;
            _loc2_.groupId = _loc5_.groupId;
            var_1326.addListItem(_loc1_);
         }
         refreshGroupListSelection();
         var_52.localization.registerParameter("extendedprofile.groups.count","count",var_24.guilds.length.toString());
         if(var_24.guilds.length < 1)
         {
            _loc4_ = class_1812(_window.findChildByName("group_cont"));
            _loc4_.removeChildAt(0);
            _loc4_.addChild(var_1817);
            var_1817.findChildByName("no_groups_caption").caption = var_52.localization.getLocalization(_loc3_ ? "extendedprofile.nogroups.me" : "extendedprofile.nogroups.user");
            var_1817.findChildByName("view_groups_button").visible = true;
         }
      }
      
      private function refreshGroupListSelection() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_1812 = null;
         _loc2_ = 0;
         while(_loc2_ < var_1326.numListItems)
         {
            _loc1_ = class_1812(var_1326.getListItemAt(_loc2_));
            _loc1_.findChildByName("bg_selected_bitmap").visible = var_372 == _loc1_.id;
            _loc1_.findChildByName("bg_unselected_bitmap").visible = var_372 != _loc1_.id;
            _loc2_++;
         }
      }
      
      private function refreshHeader() : void
      {
         var _loc1_:* = var_24.userId == var_52.avatarId;
         var _loc2_:Boolean = var_24.isHidden && !_loc1_;
         _window.findChildByName("motto_txt").caption = var_24.motto;
         _window.findChildByName("status_txt").visible = var_24.isFriend || _loc1_;
         _window.findChildByName("friend_request_sent_txt").visible = var_24.isFriendRequestSent;
         _window.findChildByName("online_icon").visible = var_24.isOnline;
         _window.findChildByName("offline_icon").visible = !var_24.isOnline && !var_24.isHidden;
         _window.findChildByName("hidden_icon").visible = !var_24.isOnline && var_24.isHidden;
         _window.findChildByName("status").invalidate();
         var_52.localization.registerParameter("extendedprofile.username","username",var_24.userName);
         var_52.localization.registerParameter("extendedprofile.created","created",var_24.creationDate);
         var_52.localization.registerParameter("extendedprofile.activitypoints","activitypoints",var_24.achievementScore.toString());
         var_52.localization.registerParameter("extendedprofile.last.login","lastlogin",var_24.lastAccessSinceInSeconds == -1 ? "-" : FriendlyTime.getFriendlyTime(var_52.localization,var_24.lastAccessSinceInSeconds,".ago"));
         var_52.localization.registerParameter("extendedprofile.friends.count","count",var_24.friendCount == -1 ? "-" : var_24.friendCount.toString());
         _window.findChildByName("bottom").visible = !_loc2_;
         _window.findChildByName("full_profile_hidden").visible = _loc2_;
         refreshAvatarImage();
         var _loc3_:Boolean = var_24.isFriend || _loc1_;
         _window.findChildByName("addasfriend_button").visible = !var_24.isFriend && !var_24.isFriendRequestSent && !_loc1_ && var_52.friendlist.canBeAskedForAFriend(var_24.userId);
         _window.findChildByName("ok_icon").visible = _loc3_;
         _window.findChildByName("status_txt").visible = _loc3_;
         _window.findChildByName("status_txt").caption = var_52.localization.getLocalization(var_24.isFriend ? "extendedprofile.friend" : "extendedprofile.me");
         _window.findChildByName("change_own_attributes").visible = _loc1_;
         _window.findChildByName("levelValue").caption = var_24.accountLevel.toString();
         _window.findChildByName("starGemCount").caption = var_24.starGemCount.toString();
         _window.findChildByName("blocked_container").visible = var_52.sessionDataManager.isBlocked(var_24.userId);
         _window.findChildByName("block_button").visible = !_loc1_;
      }
      
      private function refreshRelationships() : void
      {
         var _loc1_:Boolean = var_52.getBoolean("relationship.status.enabled");
         if(_loc1_ && _window)
         {
            _window.findChildByName("rel_status_label_txt").visible = true;
            for each(var _loc2_ in class_2242.displayableStatuses)
            {
               setRelationshipDetails(_loc2_);
            }
         }
      }
      
      private function setRelationshipDetails(param1:int) : void
      {
         var _loc4_:class_3604 = var_950.getValue(param1);
         var _loc5_:String = class_2242.statusAsString(param1);
         var _loc6_:class_1741 = _window.findChildByName(_loc5_ + "_txt");
         var _loc3_:class_1741 = _window.findChildByName(_loc5_ + "_friend_name_link_text");
         var _loc2_:class_2010 = class_2010(_window.findChildByName(_loc5_ + "_head"));
         if(_loc4_ && _loc4_.friendCount > 0)
         {
            _loc3_.caption = _loc4_.randomFriendName;
            _loc2_.visible = true;
            class_2478(_loc2_.widget).figure = _loc4_.randomFriendFigure;
            if(_loc4_.friendCount > 1)
            {
               _loc6_.visible = true;
               _loc6_.invalidate();
               _loc6_.caption = var_52.localization.getLocalizationWithParams("extendedprofile.relstatus.others." + _loc5_,"","count","" + (_loc4_.friendCount - 1));
            }
            else
            {
               _loc6_.visible = false;
            }
         }
         else
         {
            _loc2_.visible = false;
            _loc3_.caption = "${extendedprofile.add.friends}";
            _loc6_.caption = "${extendedprofile.no.friends.in.this.category}";
            _loc6_.visible = true;
         }
      }
      
      public function onGroupDetails(param1:class_1846) : void
      {
         var _loc2_:class_1812 = null;
         if(var_372 == param1.groupId)
         {
            _loc2_ = class_1812(_window.findChildByName("group_cont"));
            _loc2_.removeChildAt(0);
            _loc2_.invalidate();
            var_1867.onGroupDetails(_loc2_,param1);
         }
      }
      
      public function onRelationshipStatusInfo(param1:int, param2:class_55) : void
      {
         if(var_24 && relationshipUpdateExpected)
         {
            var_950 = param2.clone();
            refreshRelationships();
            relationshipUpdateExpected = false;
         }
      }
      
      public function onUserBadges(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_3087 = null;
         if(var_24 && badgeUpdateExpected && _window != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               _loc3_ = class_3087(class_2010(_window.findChildByName("badge_" + _loc4_)).widget);
               _loc3_.type = "normal";
               _loc3_.badgeId = _loc4_ < param2.length ? param2[_loc4_] : "";
               _loc4_++;
            }
            badgeUpdateExpected = false;
         }
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         var _loc3_:class_1741 = _window.findChildByName(param1);
         _loc3_.mouseThreshold = 0;
         _loc3_.procedure = param2;
      }
      
      private function onAddAsFriend(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.friendlist.askForAFriend(var_24.userId,var_24.userName);
         var_24.isFriendRequestSent = true;
         refresh();
      }
      
      private function onRooms(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.newNavigator.performSearch("hotel_view","owner:" + var_24.userName);
      }
      
      private function onBlock(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.windowManager.confirm("${extendedprofile.block_player.title}","${extendedprofile.block_player.desc}",0,onConfirmBlock);
      }
      
      private function onConfirmBlock(param1:class_2001, param2:class_1758) : void
      {
         if(param1 == null || Boolean(param1.disposed))
         {
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_52.sessionDataManager.blockUser(var_24.userId);
            _window.findChildByName("blocked_container").visible = true;
         }
      }
      
      private function onConfirmUnblock(param1:class_2001, param2:class_1758) : void
      {
         if(param1 == null || Boolean(param1.disposed))
         {
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_52.sessionDataManager.unblockUser(var_24.userId);
            _window.findChildByName("blocked_container").visible = false;
         }
      }
      
      public function get linkPattern() : String
      {
         return "profile/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length != 2)
         {
            return;
         }
         var _loc3_:String = _loc2_[1];
         if(_loc3_ == "unblock")
         {
            var_52.windowManager.confirm("${extendedprofile.unblock_player.title}","${extendedprofile.unblock_player.desc}",0,onConfirmUnblock);
         }
      }
      
      private function onRelationshipLink(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:String = null;
         var _loc3_:class_3604 = null;
         var _loc5_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param1.target != null && param2.name != null && var_950 != null)
         {
            _loc4_ = param2.name.substr(0,param2.name.indexOf("_"));
            _loc3_ = var_950.getValue(class_2242.stringAsStatus(_loc4_));
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_.randomFriendId;
               if(_loc5_)
               {
                  var_52.showExtendedProfile(_loc5_);
               }
            }
            else
            {
               var_52.windowManager.alert("${extendedprofile.add.friends.alert.title}","${extendedprofile.add.friends.alert.body}",0,addFriendsAlertCallback);
            }
         }
      }
      
      private function onViewGroups(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.navigator.performGuildBaseSearch();
      }
      
      private function onSelectGroup(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_372 = param2.id;
         var_52.send(new GetHabboGroupDetailsMessageComposer(var_372,false));
         var_52.send(new EventLogMessageComposer("HabboGroups","" + param2.id,"select"));
         this.refreshGroupListSelection();
      }
      
      private function onMakeFavourite(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.send(new SelectFavouriteHabboGroupMessageComposer(param2.id));
         var_52.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"make favourite"));
         var_372 = param2.id;
      }
      
      private function onClearFavourite(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.send(new DeselectFavouriteHabboGroupMessageComposer(param2.id));
         var_52.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"clear favourite"));
         var_372 = param2.id;
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onChangeLooks(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.context.createLinkEvent("avatareditor/open");
      }
      
      private function onChangeBadges(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.context.createLinkEvent("inventory/open/badges");
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function refreshAvatarImage(param1:Boolean = false) : void
      {
         var _loc2_:class_2010 = class_2010(_window.findChildByName("avatar_image"));
         var _loc3_:class_2478 = class_2478(_loc2_.widget);
         _loc3_.figure = var_24.figure;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         if(_window != null && Boolean(_window.visible) && var_24 != null && var_24.userId != param1)
         {
            var_52.send(new GetExtendedProfileMessageComposer(param1));
         }
      }
      
      public function get badgeUpdateExpected() : Boolean
      {
         return var_4555;
      }
      
      public function set badgeUpdateExpected(param1:Boolean) : void
      {
         var_4555 = param1;
      }
      
      public function set relationshipUpdateExpected(param1:Boolean) : void
      {
         var_4324 = param1;
      }
      
      public function get relationshipUpdateExpected() : Boolean
      {
         return var_4324;
      }
      
      private function addFriendsAlertCallback(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            var_52.context.createLinkEvent("friendbar/findfriends");
            close();
         }
         param1.dispose();
      }
   }
}

