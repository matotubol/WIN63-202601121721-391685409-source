package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   
   public class GroupRoomInfoCtrl implements class_13
   {
      
      private static const TOOLBAR_EXTENSION_ID:String = "room_group_info";
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_1812;
      
      private var _expanded:Boolean = true;
      
      private var _group:class_1846;
      
      private var var_1238:int;
      
      public function GroupRoomInfoCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            var_52.toolbar.extensionView.detachExtension("room_group_info");
         }
         var_52 = null;
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
      
      public function onRoomInfo(param1:class_1945) : void
      {
         if(!var_52.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.habboGroupId > 0)
         {
            var_1238 = param1.habboGroupId;
            var_52.send(new GetHabboGroupDetailsMessageComposer(param1.habboGroupId,false));
         }
         else
         {
            var_1238 = 0;
            close();
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(param1 == _group.groupId || param1 == var_1238)
         {
            expectedGroupId = 0;
            close();
         }
      }
      
      public function onGroupDetails(param1:class_1846) : void
      {
         if(!var_52.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.groupId == var_1238)
         {
            _expanded = true;
            _group = param1;
            refresh();
         }
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && _group != null && param1 == _group.groupId;
      }
      
      private function refresh() : void
      {
         if(!_group.isGuild)
         {
            return;
         }
         prepareWindow();
         _window.findChildByName("bg_expanded").visible = _expanded;
         _window.findChildByName("bg_contracted").visible = !_expanded;
         _window.findChildByName("group_name_txt").visible = _expanded;
         _window.findChildByName("join_button").visible = _expanded && _group.joiningAllowed;
         _window.findChildByName("join_button").enable();
         _window.findChildByName("request_membership_button").visible = _expanded && _group.requestMembershipAllowed;
         _window.findChildByName("manage_button").visible = _expanded && _group.isOwner;
         _window.findChildByName("group_logo").visible = _expanded;
         _window.findChildByName("group_name_txt").caption = _group.groupName;
         _window.findChildByName("info_region").visible = _expanded;
         var _loc1_:class_3087 = class_2010(_window.findChildByName("group_logo")).widget as class_3087;
         _loc1_.badgeId = _group.badgeCode;
         _loc1_.groupId = _group.groupId;
         _window.x = 0;
         _window.y = 0;
         _window.height = _expanded ? _window.findChildByName("bg_expanded").height : int(_window.findChildByName("bg_contracted").height);
         if(toolbarAttachAllowed())
         {
            var_52.toolbar.extensionView.attachExtension("room_group_info",_window,-1,["next_quest_timer","quest_tracker","event_info_window"]);
         }
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_1812(var_52.getXmlWindow("group_room_info"));
         _window.findChildByName("join_button").procedure = onJoin;
         _window.findChildByName("request_membership_button").procedure = onJoin;
         _window.findChildByName("manage_button").procedure = onManage;
         _window.findChildByName("title_region").procedure = onTitleClick;
         _window.findChildByName("info_region").procedure = onInfoClick;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               var_52.toolbar.extensionView.detachExtension("room_group_info");
            }
            var_1238 = 0;
            _group = null;
         }
      }
      
      private function onTitleClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _expanded = !_expanded;
         refresh();
         var_52.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
      }
      
      private function onInfoClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_52.trackGoogle("groupRoomInfo","groupInfo");
            var_52.send(new GetHabboGroupDetailsMessageComposer(_group.groupId,true));
            var_52.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onManage(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_52.trackGoogle("groupRoomInfo","manageGroup");
            var_52.send(new GetGuildEditInfoMessageComposer(_group.groupId));
            var_52.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onJoin(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_52.trackGoogle("groupRoomInfo","joinGroup");
            _window.findChildByName("join_button").disable();
            var_52.send(new JoinHabboGroupMessageComposer(_group.groupId));
            var_52.send(new EventLogMessageComposer("HabboGroups","" + _group.groupId,"join"));
            var_52.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      public function set expectedGroupId(param1:int) : void
      {
         var_1238 = param1;
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return var_52 != null && var_52.toolbar != null && var_52.toolbar.extensionView != null && var_52.toolbarAttachEnabled;
      }
   }
}

