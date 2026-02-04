package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.widgets.class_3087;
   import package_3.class_1846;
   import package_71.class_2196;
   import package_9.class_2315;
   import package_9.class_2585;
   import package_9.class_3543;
   
   public class GroupDetailsCtrl implements class_13
   {
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_1812;
      
      private var _selectedGroup:class_1846;
      
      public function GroupDetailsCtrl(param1:HabboGroupsManager, param2:Boolean)
      {
         super();
         var_52 = param1;
      }
      
      public function dispose() : void
      {
         var_52 = null;
         _selectedGroup = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      private function prepareWindow(param1:class_1812) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_1812(var_52.getXmlWindow("group"));
         setProc("group_room_link_region",onRoomLink);
         setProc("manage_guild_region",onManageGuild);
         setProc("delete_guild_region",onDeleteGuild);
         setProc("members_region",onMembers);
         setProc("pending_members_region",onPendingMembers);
         setProc("show_groups_link_region",onShowGroups);
         setProc("buy_furni_link_region",onBuyFurni);
         _window.findChildByName("leave_button").procedure = onLeave;
         _window.findChildByName("join_button").procedure = onJoin;
         _window.findChildByName("request_membership_button").procedure = onJoin;
      }
      
      private function attachWindow(param1:class_1812) : void
      {
         if(param1.getChildIndex(_window) == -1)
         {
            param1.addChild(_window);
         }
      }
      
      public function onGroupDetails(param1:class_1812, param2:class_1846) : void
      {
         _selectedGroup = param2;
         prepareWindow(param1);
         attachWindow(param1);
         var _loc10_:class_1741 = _window.findChildByName("group_decorate_icon_region");
         var _loc9_:class_1741 = _window.findChildByName("group_name");
         _loc9_.caption = param2.groupName;
         _loc10_.visible = param2.membersCanDecorate;
         _loc9_.x = param2.membersCanDecorate ? _loc10_.x + _loc10_.width : _loc10_.x;
         var _loc6_:ITextWindow = ITextWindow(_window.findChildByName("group_description"));
         _loc6_.caption = param2.description;
         _loc6_.height = _loc6_.textHeight + 5;
         _window.findChildByName("group_description_scrollbar").visible = _loc6_.height > _window.findChildByName("group_description_item_list").height;
         var _loc8_:Boolean = _selectedGroup.hasBoard;
         _window.findChildByName("show_forum_link_region").visible = _loc8_;
         _window.findChildByName("show_forum_link").visible = _loc8_;
         if(_loc8_)
         {
            setProc("show_forum_link_region",onForumLink);
         }
         var_52.windowManager.registerLocalizationParameter("group.created","date","" + param2.creationDate);
         var_52.windowManager.registerLocalizationParameter("group.created","owner","" + param2.ownerName);
         _window.findChildByName("created_txt").caption = var_52.localization.getLocalization("group.created");
         var_52.windowManager.registerLocalizationParameter("group.membercount","totalMembers","" + param2.totalMembers);
         _window.findChildByName("members_txt").caption = var_52.localization.getLocalization("group.membercount");
         _window.findChildByName("group_room_link_region").visible = param2.roomId > -1;
         var_52.windowManager.registerLocalizationParameter("group.linktobase","room_name",param2.roomName);
         _window.findChildByName("group_room_link").caption = var_52.localization.getLocalization("group.linktobase");
         var _loc4_:class_3087 = class_2010(_window.findChildByName("group_logo")).widget as class_3087;
         _loc4_.badgeId = _selectedGroup.badgeCode;
         _loc4_.groupId = _selectedGroup.groupId;
         _window.findChildByName("join_button").visible = param2.joiningAllowed;
         _window.findChildByName("join_button").enable();
         _window.findChildByName("request_membership_button").visible = param2.requestMembershipAllowed;
         _window.findChildByName("leave_button").visible = param2.leaveAllowed;
         _window.findChildByName("membership_pending_txt").visible = param2.status == 2;
         _window.findChildByName("youaremember_txt").visible = !_selectedGroup.isGuild && param2.status == 1;
         _window.findChildByName("youaremember_icon").visible = !_selectedGroup.isGuild && param2.status == 1;
         var _loc5_:class_1741 = _window.findChildByName("pending_members_region");
         _loc5_.visible = _selectedGroup.pendingMemberCount > 0;
         if(_selectedGroup.pendingMemberCount > 0)
         {
            var_52.windowManager.registerLocalizationParameter("group.pendingmembercount","amount","" + param2.pendingMemberCount);
            _window.findChildByName("pending_members_txt").caption = var_52.localization.getLocalization("group.pendingmembercount");
         }
         var _loc3_:class_1741 = _window.findChildByName("manage_guild_region");
         _loc3_.visible = _selectedGroup.isOwner && _selectedGroup.isGuild;
         _loc3_.y = _loc5_.visible ? _loc5_.y + 16 : _loc5_.y;
         var _loc7_:class_1741 = _window.findChildByName("delete_guild_region");
         _loc7_.visible = _selectedGroup.isGuild && var_52.groupDeletionEnabled && (_selectedGroup.isOwner || var_52.sessionDataManager.hasSecurity(5));
         _loc7_.y = _loc3_.visible ? _loc3_.y + 16 : _loc5_.y;
         _window.findChildByName("you_are_owner_region").visible = _selectedGroup.isGuild && _selectedGroup.isOwner;
         _window.findChildByName("you_are_admin_region").visible = _selectedGroup.isGuild && _selectedGroup.isAdmin && !_selectedGroup.isOwner;
         _window.findChildByName("you_are_member_region").visible = _selectedGroup.isGuild && (_selectedGroup.status == 1 && !(_selectedGroup.isAdmin || _selectedGroup.isOwner));
         getGroupTypeRegion(0).visible = false;
         getGroupTypeRegion(1).visible = false;
         getGroupTypeRegion(2).visible = false;
         if(getGroupTypeRegion(param2.type) != null)
         {
            getGroupTypeRegion(param2.type).visible = true;
         }
      }
      
      private function getGroupTypeRegion(param1:int) : class_1741
      {
         return _window.findChildByName("grouptype_region_" + param1);
      }
      
      private function getGroupTypeIcon(param1:int) : class_1741
      {
         return _window.findChildByName("grouptype_icon_" + param1);
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         var _loc3_:class_1741 = _window.findChildByName(param1);
         _loc3_.mouseThreshold = 0;
         _loc3_.procedure = param2;
      }
      
      private function onLeave(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","leaveGroup");
         var_52.handleUserKick(var_52.avatarId,_selectedGroup.groupId);
      }
      
      private function onJoin(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","joinGroup");
         _window.findChildByName("join_button").disable();
         var_52.send(new class_2585(_selectedGroup.groupId));
         var_52.send(new class_2196("HabboGroups","" + _selectedGroup.groupId,"join"));
      }
      
      private function onRoomLink(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","groupBaseRoom");
         var_52.navigator.goToPrivateRoom(_selectedGroup.roomId);
         var_52.send(new class_2196("HabboGroups","" + _selectedGroup.groupId,"base"));
      }
      
      private function onForumLink(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.openGroupForum(_selectedGroup.groupId);
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            var_52.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"_empty");
         }
      }
      
      private function onExternalLink(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function onManageGuild(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","groupManage");
         var_52.send(new class_2315(_selectedGroup.groupId));
      }
      
      private function onDeleteGuild(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.windowManager.confirm("${group.deleteconfirm.title}","${group.deleteconfirm.desc}",0,onDeleteGuildConfirmation);
      }
      
      private function onDeleteGuildConfirmation(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_52.trackGoogle("groupDetails","groupDelete");
            var_52.send(new class_3543(_selectedGroup.groupId));
         }
      }
      
      private function onMembers(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","groupMembers");
         var_52.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId,0);
      }
      
      private function onPendingMembers(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","groupPendingMembers");
         var_52.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId,2);
      }
      
      private function onShowGroups(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","hottestGroups");
         var_52.navigator.performGuildBaseSearch();
      }
      
      private function onBuyFurni(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.trackGoogle("groupDetails","groupFurni");
         var_52.openCatalog("guild_custom_furni");
      }
   }
}

