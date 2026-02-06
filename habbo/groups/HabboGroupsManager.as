package com.sulake.habbo.groups
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultEventParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedEventParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1819;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDeactivatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1843;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreationInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.users.class_1864;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1893;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberFurniCountInHQMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1957;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_2228;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectEventParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoEventParser;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditorDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.KickMemberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer;
   
   public class HabboGroupsManager extends class_17 implements class_140, ILinkEventTracker
   {
      
      public static const GROUPS_TRACKING_CATEGORY:String = "HabboGroups";
      
      private var _communication:class_57;
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _navigator:class_41;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _friendlist:class_258;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _habboTracking:class_53;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_1012:DetailsWindowCtrl;
      
      private var var_661:GuildMembersWindowCtrl;
      
      private var var_879:GuildManagementWindowCtrl;
      
      private var var_529:ExtendedProfileWindowCtrl;
      
      private var var_1562:HcRequiredWindowCtrl;
      
      private var var_2165:GroupCreatedWindowCtrl;
      
      private var var_615:GroupRoomInfoCtrl;
      
      private var var_3514:class_1957;
      
      private var var_2699:int;
      
      private var var_1951:int;
      
      private var var_3870:Boolean;
      
      private var var_709:GuildKickData;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function HabboGroupsManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_1012 = new DetailsWindowCtrl(this);
         var_661 = new GuildMembersWindowCtrl(this);
         var_879 = new GuildManagementWindowCtrl(this);
         var_529 = new ExtendedProfileWindowCtrl(this);
         var_1562 = new HcRequiredWindowCtrl(this);
         var_2165 = new GroupCreatedWindowCtrl(this);
         var_615 = new GroupRoomInfoCtrl(this);
         class_21.log("HabboGroupsManager initialized: " + param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendlist = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _habboTracking = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new RelationshipStatusInfoEvent(onRelationshipStatusInfo));
         addMessageEvent(new FlatCreatedEvent(onFlatCreated));
         addMessageEvent(new ExtendedProfileMessageEvent(onExtendedProfile));
         addMessageEvent(new ExtendedProfileChangedMessageEvent(onExtendedProfileChanged));
         addMessageEvent(new HabboUserBadgesMessageEvent(onUserBadgesMessage));
         addMessageEvent(new GuildEditInfoMessageEvent(onGuildEditInfo));
         addMessageEvent(new GuildEditorDataMessageEvent(onGuildEditorData));
         addMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
         addMessageEvent(new HabboGroupJoinFailedMessageEvent(onJoinFailed));
         addMessageEvent(new GuildCreatedMessageEvent(onGuildCreated));
         addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         addMessageEvent(new GuildMembershipRejectedMessageEvent(var_661.onGuildMembershipRejected));
         addMessageEvent(new GuildMemberMgmtFailedMessageEvent(var_661.onGuildMemberMgmtFailed));
         addMessageEvent(new GuildMemberFurniCountInHQMessageEvent(onKickConfirmation));
         addMessageEvent(new HabboGroupDeactivatedMessageEvent(onGroupDeactivated));
         addMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new GuildMembershipUpdatedMessageEvent(var_661.onGuildMembershipUpdated));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomLeave));
         addMessageEvent(new GroupDetailsChangedMessageEvent(onGroupDetailsChanged));
         addMessageEvent(new GuildMembersMessageEvent(var_661.onGuildMembers));
         addMessageEvent(new GuildEditFailedMessageEvent(onGuildEditFailed));
         addMessageEvent(new GuildCreationInfoMessageEvent(onGuildCreationInfo));
         addMessageEvent(new GroupMembershipRequestedMessageEvent(var_661.onMembershipRequested));
         context.addLinkEventTracker(this);
         context.addLinkEventTracker(var_529);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
            _messageEvents = null;
         }
         if(var_1012)
         {
            var_1012.dispose();
            var_1012 = null;
         }
         if(var_661)
         {
            var_661.dispose();
            var_661 = null;
         }
         if(var_879)
         {
            var_879.dispose();
            var_879 = null;
         }
         if(var_529)
         {
            var_529.dispose();
            var_529 = null;
         }
         if(var_1562)
         {
            var_1562.dispose();
            var_1562 = null;
         }
         if(var_2165)
         {
            var_2165.dispose();
            var_2165 = null;
         }
         if(var_615)
         {
            var_615.dispose();
            var_615 = null;
         }
         super.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "group/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length != 2)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[1]);
         openGroupInfo(_loc3_);
      }
      
      public function showGroupBadgeInfo(param1:Boolean, param2:int) : void
      {
         openGroupInfo(param2);
         send(new EventLogMessageComposer("HabboGroups","" + param2,"badge clicked"));
      }
      
      public function openGroupInfo(param1:int) : void
      {
         send(new GetHabboGroupDetailsMessageComposer(param1,true));
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String) : class_1741
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:class_1741 = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function getButtonImage(param1:String) : BitmapData
      {
         var _loc3_:String = param1;
         var _loc6_:IAsset = assets.getAssetByName(_loc3_);
         var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc6_);
         var _loc2_:BitmapData = BitmapData(_loc4_.content);
         var _loc5_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc5_.draw(_loc2_);
         return _loc5_;
      }
      
      public function openGroupForum(param1:int) : void
      {
         context.createLinkEvent("groupforum/" + param1);
      }
      
      private function onGroupDeactivated(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(HabboGroupDeactivatedMessageEvent(param1).groupId);
         var_1012.onGroupDeactivated(_loc2_);
         var_615.onGroupDeactivated(_loc2_);
      }
      
      private function onGroupDetails(param1:IMessageEvent) : void
      {
         var _loc2_:class_1846 = HabboGroupDetailsMessageEvent(param1).data;
         var_1012.onGroupDetails(_loc2_);
         var_529.onGroupDetails(_loc2_);
         var_615.onGroupDetails(_loc2_);
      }
      
      private function onExtendedProfile(param1:IMessageEvent) : void
      {
         var _loc2_:class_2228 = ExtendedProfileMessageEvent(param1).data;
         if(_loc2_.openProfileWindow)
         {
            var_529.badgeUpdateExpected = true;
            var_529.relationshipUpdateExpected = true;
            var_529.onProfile(_loc2_);
         }
      }
      
      private function onExtendedProfileChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(ExtendedProfileChangedMessageEvent(param1).userId);
         var_529.onProfileChanged(_loc2_);
      }
      
      private function onGroupDetailsChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(GroupDetailsChangedMessageEvent(param1).groupId);
         if(var_1012.isDisplayingGroup(_loc2_) || var_615.isDisplayingGroup(_loc2_))
         {
            send(new GetHabboGroupDetailsMessageComposer(_loc2_,false));
         }
      }
      
      private function onJoinFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(HabboGroupJoinFailedMessageEvent(param1).reason);
         if(_loc2_ == 4)
         {
            var_1562.show(false);
         }
         else
         {
            _loc3_ = "group.joinfail." + _loc2_;
            _loc4_ = _localization.getLocalization(_loc3_,_loc3_);
            _windowManager.alert("${group.joinfail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onGuildCreationInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1843 = GuildCreationInfoMessageEvent(param1).data;
         var_879.onGuildCreationInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onGuildEditInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1819 = GuildEditInfoMessageEvent(param1).data;
         var_879.onGuildEditInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onRoomLeave(param1:IMessageEvent) : void
      {
         var_1012.close();
         var_615.close();
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var_1012.close();
         var_615.close();
         var _loc2_:RoomEntryInfoMessageEventParser = RoomEntryInfoMessageEvent(param1).getParser();
         var_1951 = _loc2_.guestRoomId;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function onGuildEditorData(param1:IMessageEvent) : void
      {
         var_3514 = GuildEditorDataMessageEvent(param1).data;
         events.dispatchEvent(new HabboGroupsEditorData());
      }
      
      private function onGuildEditFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(GuildEditFailedMessageEvent(param1).reason);
         if(_loc2_ == 2)
         {
            var_1562.show(true);
         }
         else
         {
            _loc3_ = "group.edit.fail." + _loc2_;
            _loc4_ = _localization.getLocalization(_loc3_,_loc3_);
            _windowManager.alert("${group.edit.fail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEventParser = UserObjectEvent(param1).getParser();
         var_2699 = _loc2_.id;
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:FlatCreatedEventParser = FlatCreatedEvent(param1).getParser();
         var_879.onFlatCreated(_loc2_.flatId,_loc2_.flatName);
      }
      
      private function onGuildCreated(param1:IMessageEvent) : void
      {
         var _loc2_:GuildCreatedMessageEvent = GuildCreatedMessageEvent(param1);
         var_2165.show(_loc2_.groupId);
         var_879.close();
         var_615.expectedGroupId = _loc2_.groupId;
         if(var_1951 != _loc2_.baseRoomId)
         {
            _navigator.goToPrivateRoom(_loc2_.baseRoomId);
         }
      }
      
      private function onKickConfirmation(param1:IMessageEvent) : void
      {
         var _loc4_:int = int(GuildMemberFurniCountInHQMessageEvent(param1).userId());
         var _loc6_:int = int(GuildMemberFurniCountInHQMessageEvent(param1).furniCount());
         var _loc2_:class_1864 = var_661.data;
         var _loc3_:String = var_709.targetBlocked ? "group.block" : "group.kick";
         if(_loc6_ > 0)
         {
            if(_loc4_ == var_2699)
            {
               localization.registerParameter("group.leaveconfirm.desc","amount",_loc6_.toString());
               _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm.desc}",0,onKickConfirmationClose);
            }
            else
            {
               var _loc5_:class_1893 = _loc2_.getUser(_loc4_);
               localization.registerParameter(_loc3_ + "confirm.desc","amount",_loc6_.toString());
               localization.registerParameter(_loc3_ + "confirm.desc","user",null.userName);
               _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm.desc}",0,onKickConfirmationClose);
            }
         }
         else if(_loc4_ == var_2699)
         {
            _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm_nofurni.desc}",0,onKickConfirmationClose);
         }
         else if(_loc2_)
         {
            _loc5_ = _loc2_.getUser(_loc4_);
            localization.registerParameter(_loc3_ + "confirm_nofurni.desc","user",null.userName);
            _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm_nofurni.desc}",0,onKickConfirmationClose);
         }
      }
      
      private function onKickConfirmationClose(param1:class_2001, param2:class_1758) : void
      {
         if(param1 == null || Boolean(param1.disposed) || var_709 == null)
         {
            var_709 = null;
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            send(new KickMemberMessageComposer(var_709.kickGuildId,var_709.kickTargetId,var_709.targetBlocked));
         }
         var_709 = null;
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoEventParser = ScrSendUserInfoEvent(param1).getParser();
         var_3870 = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
         var_879.onSubscriptionChange();
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc2_:GetGuestRoomResultEventParser = GetGuestRoomResultEvent(param1).getParser();
         if(_loc2_.enterRoom)
         {
            var_615.onRoomInfo(_loc2_.data);
         }
      }
      
      private function onRelationshipStatusInfo(param1:IMessageEvent) : void
      {
         var _loc2_:RelationshipStatusInfoEvent = RelationshipStatusInfoEvent(param1);
         var_529.onRelationshipStatusInfo(_loc2_.userId,_loc2_.relationshipStatusMap);
      }
      
      private function onUserBadgesMessage(param1:HabboUserBadgesMessageEvent) : void
      {
         var_529.onUserBadges(param1.userId,param1.badges);
      }
      
      private function requestGuildEditorData() : void
      {
         if(var_3514 == null)
         {
            send(new GetGuildEditorDataMessageComposer());
         }
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get guildManagementWindowCtrl() : GuildManagementWindowCtrl
      {
         return var_879;
      }
      
      public function get groupRoomInfoCtrl() : GroupRoomInfoCtrl
      {
         return var_615;
      }
      
      public function get groupRoomInfoEnabled() : Boolean
      {
         return getBoolean("groupRoomInfo.enabled");
      }
      
      public function get groupDeletionEnabled() : Boolean
      {
         return getBoolean("group.deletion.enabled");
      }
      
      public function get groupRoomInfoBadgeEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.badge.enabled");
      }
      
      public function get toolbarAttachEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.attach.enabled");
      }
      
      public function get isActivityDisplayEnabled() : Boolean
      {
         return getBoolean("activity.point.display.enabled");
      }
      
      public function get guildEditorData() : class_1957
      {
         return var_3514;
      }
      
      public function get avatarId() : int
      {
         return var_2699;
      }
      
      public function get navigator() : class_41
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get friendlist() : class_258
      {
         return _friendlist;
      }
      
      public function get guildMembersWindowCtrl() : GuildMembersWindowCtrl
      {
         return var_661;
      }
      
      public function get habboTracking() : class_53
      {
         return _habboTracking;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_habboTracking != null)
         {
            _habboTracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         var_529.updateVisibleExtendedProfile(param1);
      }
      
      public function showExtendedProfile(param1:int) : void
      {
         send(new GetExtendedProfileMessageComposer(param1));
      }
      
      public function openCatalog(param1:String) : void
      {
         _catalog.openCatalogPage(param1);
      }
      
      public function openVipPurchase(param1:String) : void
      {
         _catalog.openClubCenter();
      }
      
      public function get hasVip() : Boolean
      {
         return var_3870;
      }
      
      public function handleUserKick(param1:int, param2:int) : void
      {
         var_709 = new GuildKickData(param1,param2);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function handleUserBlock(param1:int, param2:int) : void
      {
         var_709 = new GuildKickData(param1,param2,true);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function get newNavigator() : IHabboNewNavigator
      {
         return _newNavigator;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
   }
}

