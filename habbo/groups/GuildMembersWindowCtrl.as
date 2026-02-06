package com.sulake.habbo.groups
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.InfoText;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1864;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1893;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GroupMembershipRequestedMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.AddAdminRightsToMemberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ApproveMembershipRequestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ApproveAllMembershipRequestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.RemoveAdminRightsFromMemberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnblockGroupMemberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.RejectMembershipRequestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembersMessageComposer;
   
   public class GuildMembersWindowCtrl implements class_13
   {
      
      private static const MEMBER_SPACING:Point = new Point(5,5);
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_2250;
      
      private var _groupId:int;
      
      private var var_643:Timer = new Timer(1000,1);
      
      private var var_24:class_1864;
      
      private var var_847:InfoText;
      
      private var _loadingIcon:LoadingIcon;
      
      public function GuildMembersWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
         var_643.addEventListener("timer",onSearchTimer);
         _loadingIcon = new LoadingIcon();
      }
      
      public function dispose() : void
      {
         var_52 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_847 != null)
         {
            var_847.dispose();
            var_847 = null;
         }
         if(var_643)
         {
            var_643.removeEventListener("timer",onSearchTimer);
            var_643.stop();
            var_643 = null;
         }
         if(_loadingIcon)
         {
            _loadingIcon.dispose();
            _loadingIcon = null;
         }
      }
      
      private function setSearchingIcon(param1:Boolean) : void
      {
         if(_window)
         {
            _loadingIcon.setVisible(IIconWindow(_window.findChildByName("searching_icon")),param1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      public function onGuildMembers(param1:IMessageEvent) : void
      {
         var_24 = GuildMembersMessageEvent(param1).data;
         show();
         populateSearchTypes();
         populateUserNameFilter();
      }
      
      public function onGuildMembershipUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMembershipUpdatedMessageEvent = GuildMembershipUpdatedMessageEvent(param1);
         if(var_24 != null && var_24.groupId == _loc2_.guildId)
         {
            var_24.update(_loc2_.data);
            reload();
         }
      }
      
      public function onGuildMemberMgmtFailed(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMemberMgmtFailedMessageEvent = GuildMemberMgmtFailedMessageEvent(param1);
         var _loc3_:int = _loc2_.reason;
         var _loc4_:String = "group.membermgmt.fail." + _loc3_;
         var _loc5_:String = var_52.localization.getLocalization(_loc4_,_loc4_);
         var_52.windowManager.alert("${group.membermgmt.fail.title}",_loc5_,0,null);
         if(var_24 != null && var_24.groupId == _loc2_.guildId && _window != null && Boolean(_window.visible))
         {
            doSearch(var_24.pageIndex);
         }
      }
      
      public function onGuildMembershipRejected(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMembershipRejectedMessageEvent = GuildMembershipRejectedMessageEvent(param1);
         if(_window && _window.visible && var_24 != null && var_24.groupId == _loc2_.getParser().guildId)
         {
            doSearch(var_24.pageIndex);
         }
      }
      
      public function onMembershipRequested(param1:IMessageEvent) : void
      {
         var _loc2_:GroupMembershipRequestedMessageEventParser = GroupMembershipRequestedMessageEvent(param1).getParser();
         if(_window && _window.visible && var_24 != null && var_24.groupId == _loc2_.groupId)
         {
            doSearch(var_24.pageIndex);
         }
      }
      
      public function onMembersClick(param1:int, param2:int) : void
      {
         if(!var_52.getBoolean("groupMembers.enabled"))
         {
            return;
         }
         if(_window != null && Boolean(_window.visible) && _groupId == param1)
         {
            close();
         }
         else
         {
            if(var_847)
            {
               var_847.goBackToInitialState();
            }
            _groupId = param1;
            var_52.send(new GetGuildMembersMessageComposer(param1,0,"",param2));
         }
      }
      
      public function show() : void
      {
         prepareWindow();
         refresh();
         _window.visible = true;
         _window.activate();
      }
      
      public function reload() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            refresh();
         }
      }
      
      private function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var_52.localization.registerParameter("group.members.title","groupName",var_24.groupName);
         var _loc7_:class_1812 = class_1812(_window.findChildByName("members_cont"));
         var _loc8_:Array = var_24.entries;
         _loc4_ = 0;
         while(_loc4_ < var_24.pageSize)
         {
            refreshEntry(_loc7_,_loc4_,_loc8_[_loc4_]);
            _loc4_++;
         }
         var _loc1_:class_3087 = class_2010(_window.findChildByName("group_logo")).widget as class_3087;
         _loc1_.badgeId = var_24.badgeCode;
         _loc1_.groupId = var_24.groupId;
         var _loc3_:String = var_52.localization.getLocalization("group.members.pageinfo");
         var _loc2_:Array = _loc3_.split("%page%");
         if(_loc2_.length == 2)
         {
            _loc5_ = _loc2_[0];
            _loc6_ = _loc2_[1];
            pageTextStart.text = _loc5_.replace("%amount%",var_24.totalEntries);
            pageTextEnd.text = _loc6_.replace("%totalPages%",var_24.totalPages);
            pageNumberInput.text = var_24.pageIndex + 1 + "";
         }
         _window.findChildByName("previous_page_button").visible = hasPreviousPage();
         _window.findChildByName("next_page_button").visible = hasNextPage();
      }
      
      private function onPageInputClickAway(param1:WindowMouseEvent) : void
      {
         navigateToInputPage();
      }
      
      private function onPageInputDown(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.keyCode == 13)
         {
            navigateToInputPage();
         }
      }
      
      private function navigateToInputPage() : void
      {
         var _loc2_:int = int(pageNumberInput.text);
         var _loc1_:int = limitPageIndex(_loc2_ - 1) + 1;
         if(_loc1_ != _loc2_)
         {
            pageNumberInput.text = String(_loc1_);
         }
         doSearch(_loc1_ - 1);
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_2250(var_52.getXmlWindow("guild_members_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("previous_page_button").procedure = onPreviousPage;
         _window.findChildByName("next_page_button").procedure = onNextPage;
         var_847 = new InfoText(ITextFieldWindow(_window.findChildByName("filter_members_input")),var_52.localization.getLocalization("group.members.searchinfo"));
         pageNumberInput.restrict = "0-9";
         pageNumberInput.addEventListener("WKE_KEY_DOWN",onPageInputDown);
         pageNumberInput.addEventListener("WME_CLICK_AWAY",onPageInputClickAway);
         _window.center();
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _groupId = 0;
            _window.visible = false;
         }
      }
      
      private function refreshEntry(param1:class_1812, param2:int, param3:class_1893) : void
      {
         var _loc4_:class_1812 = class_1812(param1.getChildAt(param2));
         if(_loc4_ == null)
         {
            if(param3 == null)
            {
               return;
            }
            _loc4_ = getListEntry();
            _loc4_.tags[0] = "" + param2;
            param1.addChild(_loc4_);
            _loc4_.x = param2 % 2 == 0 ? 0 : _loc4_.width + MEMBER_SPACING.x;
            _loc4_.y = Math.floor(param2 / 2) * (_loc4_.height + MEMBER_SPACING.y);
         }
         if(param3 != null)
         {
            refreshUserEntry(_loc4_,param3);
            _loc4_.visible = true;
         }
         else
         {
            _loc4_.visible = false;
         }
      }
      
      public function refreshUserEntry(param1:class_1812, param2:class_1893) : void
      {
         var _loc8_:* = false;
         param1.findChildByName("user_name_txt").caption = param2.userName;
         param1.findChildByName("icon_owner").visible = param2.owner;
         this.setAdminState(param2.member,param2.admin,param1);
         var _loc5_:class_1741 = param1.findChildByName("admin_container");
         _loc5_.visible = !_loc8_ && (param2.admin || var_24.allowedToManage);
         var _loc9_:IRegionWindow = IRegionWindow(param1.findChildByName("bg_region"));
         _loc9_.id = param2.userId;
         this.setRemoveState(false,param1);
         this.setActionLinkState(false,param1);
         _loc8_ = param2.userId == var_52.avatarId;
         var _loc11_:IRegionWindow = IRegionWindow(param1.findChildByName("remove_region"));
         _loc11_.toolTipCaption = var_52.localization.getLocalization(param2.member ? "group.members.kick" : "group.members.reject");
         _loc11_.visible = !param2.owner && !_loc8_ && var_24.allowedToManage && !param2.blocked;
         _loc11_.id = param2.userId;
         var _loc6_:Boolean = param2.member && !param2.owner && !_loc8_ && var_24.allowedToManage && var_52.getBoolean("group.blocking.enabled") && !param2.blocked;
         var _loc3_:IRegionWindow = IRegionWindow(param1.findChildByName("block_region"));
         _loc3_.toolTipCaption = var_52.localization.getLocalization("group.members.block");
         _loc3_.visible = _loc6_;
         _loc3_.id = param2.userId;
         var _loc4_:Boolean = !_loc8_ && var_24.allowedToManage;
         var _loc10_:IRegionWindow = IRegionWindow(param1.findChildByName("action_link_region"));
         _loc10_.visible = _loc4_;
         _loc10_.id = param2.userId;
         var _loc7_:ITextWindow = ITextWindow(param1.findChildByName("member_since_txt"));
         _loc7_.visible = !_loc4_ && param2.memberSince != "";
         var_52.localization.registerParameter("group.members.since","date",param2.memberSince);
         _loc7_.caption = var_52.localization.getLocalization("group.members.since");
         class_2478(class_2010(param1.findChildByName("avatar_image")).widget).figure = param2.figure;
         if(param2.blocked)
         {
            setActionLink(param1,"group.members.unblock",false);
         }
         else if(param2.owner)
         {
            setActionLink(param1,"group.members.owner",false);
         }
         else if(param2.admin)
         {
            setActionLink(param1,"group.members.removerights",true);
         }
         else if(param2.member)
         {
            setActionLink(param1,"group.members.giverights",true);
         }
         else
         {
            setActionLink(param1,"group.members.accept",true);
         }
      }
      
      public function getListEntry() : class_1812
      {
         var _loc1_:class_1812 = class_1812(var_52.getXmlWindow("member_entry"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("bg_region"));
         _loc3_.procedure = onBg;
         var _loc2_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("block_region"));
         _loc2_.addEventListener("WME_OVER",onRemoveMouseOver);
         _loc2_.addEventListener("WME_OUT",onRemoveMouseOut);
         _loc2_.addEventListener("WME_CLICK",onBlockMouseClick);
         var _loc5_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("remove_region"));
         _loc5_.addEventListener("WME_OVER",onRemoveMouseOver);
         _loc5_.addEventListener("WME_OUT",onRemoveMouseOut);
         _loc5_.addEventListener("WME_CLICK",onRemoveMouseClick);
         var _loc4_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("action_link_region"));
         _loc4_.addEventListener("WME_OVER",onActionLinkMouseOver);
         _loc4_.addEventListener("WME_OUT",onActionLinkMouseOut);
         _loc4_.addEventListener("WME_CLICK",onActionLinkClick);
         return _loc1_;
      }
      
      private function onRemoveMouseOver(param1:class_1758) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setRemoveState(true,_loc2_);
      }
      
      private function onRemoveMouseOut(param1:class_1758) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setRemoveState(false,_loc2_);
      }
      
      private function onRemoveMouseClick(param1:class_1758) : void
      {
         var _loc3_:class_1741 = param1.target;
         var _loc2_:class_1893 = var_24.getUser(_loc3_.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.member)
         {
            var_52.handleUserKick(_loc3_.id,var_24.groupId);
         }
         else
         {
            var_52.send(new RejectMembershipRequestMessageComposer(var_24.groupId,_loc2_.userId));
         }
      }
      
      private function onBlockMouseClick(param1:class_1758) : void
      {
         var _loc3_:class_1741 = param1.target;
         var _loc2_:class_1893 = var_24.getUser(_loc3_.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.member)
         {
            var_52.handleUserBlock(_loc3_.id,var_24.groupId);
         }
      }
      
      private function setActionLink(param1:class_1812, param2:String, param3:Boolean) : void
      {
         var _loc4_:ITextWindow = ITextWindow(param1.findChildByName("action_link"));
         _loc4_.text = var_52.localization.getLocalization(param2,param2);
         _loc4_.underline = param3;
      }
      
      private function setRemoveState(param1:Boolean, param2:class_1812) : void
      {
         param2.findChildByName("icon_close_off").visible = !param1;
         param2.findChildByName("icon_close_over").visible = param1;
         param2.findChildByName("icon_close_down").visible = false;
      }
      
      private function setActionLinkState(param1:Boolean, param2:class_1812) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param2.findChildByName("action_link"));
         _loc3_.textColor = param1 ? 4280984060 : 4285492837;
      }
      
      private function onActionLinkMouseOver(param1:class_1758) : void
      {
         var _loc3_:IRegionWindow = IRegionWindow(param1.target);
         var _loc2_:class_1893 = var_24.getUser(param1.target.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         setActionLinkState(true,_loc3_);
         setAdminState(_loc2_.member,!_loc2_.admin,class_1812(_loc3_.parent));
      }
      
      private function onActionLinkMouseOut(param1:class_1758) : void
      {
         var _loc3_:IRegionWindow = IRegionWindow(param1.target);
         setActionLinkState(false,_loc3_);
         var _loc2_:class_1893 = var_24.getUser(param1.target.id);
         if(_loc2_ != null)
         {
            setAdminState(_loc2_.member,_loc2_.admin,class_1812(_loc3_.parent));
         }
      }
      
      private function onActionLinkClick(param1:class_1758) : void
      {
         var _loc2_:class_1893 = var_24.getUser(param1.target.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.blocked)
         {
            var_52.send(new UnblockGroupMemberMessageComposer(var_24.groupId,_loc2_.userId));
         }
         else if(_loc2_.admin)
         {
            var_52.send(new RemoveAdminRightsFromMemberMessageComposer(var_24.groupId,_loc2_.userId));
         }
         else if(_loc2_.member)
         {
            var_52.send(new AddAdminRightsToMemberMessageComposer(var_24.groupId,_loc2_.userId));
         }
         else
         {
            var_52.send(new ApproveMembershipRequestMessageComposer(var_24.groupId,_loc2_.userId));
         }
      }
      
      private function setAdminState(param1:Boolean, param2:Boolean, param3:class_1812) : void
      {
         param3.findChildByName("icon_admin_off").visible = param1 && param2;
         param3.findChildByName("icon_admin_over").visible = param1 && !param2;
      }
      
      private function onBg(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_52.send(new GetExtendedProfileMessageComposer(param2.id));
         }
      }
      
      private function onFilterMembers(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_CHANGE")
         {
            var_643.reset();
            var_643.start();
            setSearchingIcon(true);
         }
      }
      
      private function onTypeDropmenu(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            doSearch(0);
         }
      }
      
      private function doSearch(param1:int) : void
      {
         var_643.stop();
         var_643.reset();
         setSearchingIcon(true);
         var _loc2_:class_1864 = var_24;
         var _loc3_:String = var_847.getText();
         var _loc4_:int = getTypeDropMenu().selection;
         var_52.send(new GetGuildMembersMessageComposer(_loc2_.groupId,param1,_loc3_,_loc4_));
      }
      
      private function onAcceptAll(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.send(new ApproveAllMembershipRequestsMessageComposer(var_24.groupId));
      }
      
      private function getTypeDropMenu() : class_2261
      {
         return class_2261(_window.findChildByName("type_drop_menu"));
      }
      
      private function onSearchTimer(param1:Event) : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            doSearch(0);
         }
      }
      
      private function onNextPage(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         doSearch(limitPageIndex(var_24.pageIndex + 1));
      }
      
      private function onPreviousPage(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         doSearch(limitPageIndex(var_24.pageIndex - 1));
      }
      
      private function hasPreviousPage() : Boolean
      {
         return var_24.pageIndex != limitPageIndex(var_24.pageIndex - 1);
      }
      
      private function hasNextPage() : Boolean
      {
         return var_24.pageIndex != limitPageIndex(var_24.pageIndex + 1);
      }
      
      private function limitPageIndex(param1:int) : int
      {
         var _loc2_:int = Math.ceil(var_24.totalEntries / var_24.pageSize);
         return Math.max(0,Math.min(param1,_loc2_ - 1));
      }
      
      public function get data() : class_1864
      {
         return var_24;
      }
      
      private function populateSearchTypes() : void
      {
         var _loc2_:Array = [];
         _loc2_.push("${group.members.search.all}");
         _loc2_.push("${group.members.search.admins}");
         if(var_24.allowedToManage)
         {
            _loc2_.push("${group.members.search.pending}");
            if(var_52.getBoolean("group.blocking.enabled"))
            {
               _loc2_.push("${group.members.search.blocked}");
            }
         }
         var _loc1_:class_2261 = getTypeDropMenu();
         _loc1_.procedure = null;
         _loc1_.populate(_loc2_);
         _loc1_.selection = var_24.allowedToManage ? var_24.searchType : Math.min(var_24.searchType,1);
         _loc1_.procedure = onTypeDropmenu;
      }
      
      private function populateUserNameFilter() : void
      {
         var _loc1_:ITextFieldWindow = var_847.input;
         _loc1_.procedure = null;
         if(var_847.getText() != var_24.userNameFilter)
         {
            var_847.setText(var_24.userNameFilter);
         }
         _loc1_.procedure = onFilterMembers;
         var_643.stop();
         setSearchingIcon(false);
      }
      
      private function get pageTextStart() : ITextWindow
      {
         return _window.findChildByName("pagina_text_start") as ITextWindow;
      }
      
      private function get pageNumberInput() : ITextFieldWindow
      {
         return _window.findChildByName("pagina_number_input") as ITextFieldWindow;
      }
      
      private function get pageTextEnd() : ITextWindow
      {
         return _window.findChildByName("pagina_text_end") as ITextWindow;
      }
   }
}

