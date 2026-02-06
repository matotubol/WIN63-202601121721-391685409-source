package com.sulake.habbo.friendlist
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
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;
   import com.sulake.habbo.friendlist.domain.*;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.friendlist.*;
   import com.sulake.habbo.communication.messages.incoming.friendlist.*;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.*;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectEventParser;
   
   public class HabboFriendList extends class_17 implements class_258, class_259, ILinkEventTracker
   {
      
      public static const AVATAR_FACE_NAME:String = "face";
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _messenger:class_46;
      
      private var _localization:class_27;
      
      private var _avatarManager:class_48;
      
      private var _sessionData:ISessionDataManager;
      
      private var _tracking:class_53;
      
      private var var_5095:class_1748;
      
      private var var_817:FriendListTabs;
      
      private var var_18:FriendListView;
      
      private var _openedToWebPopup:OpenedToWebPopup;
      
      private var var_2699:int;
      
      internal var var_143:FriendCategories;
      
      private var var_193:FriendRequests;
      
      private var _avatarSearchResults:AvatarSearchResults;
      
      private var _notifications:class_536;
      
      private var var_1173:Timer;
      
      private var var_4409:int;
      
      private var var_4437:Boolean = false;
      
      private var _lastRoomInvitationTime:int = -60000;
      
      public function HabboFriendList(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_143 = new FriendCategories(new FriendCategoriesDeps(this));
         _avatarSearchResults = new AvatarSearchResults(new AvatarSearchDeps(this));
         var_5095 = new class_1748();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:class_46):void
         {
            _messenger = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         _communication.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInit));
         _communication.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
         context.addLinkEventTracker(this);
         send(new MessengerInitMessageComposer());
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         context.removeLinkEventTracker(this);
         if(var_1173)
         {
            var_1173.stop();
            var_1173.removeEventListener("timer",sendFriendListUpdate);
            var_1173 = null;
         }
         super.dispose();
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking != null)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function openHabboWebPage(param1:String, param2:Dictionary, param3:int, param4:int) : void
      {
         var _loc6_:String = getProperty(param1,param2);
         try
         {
            HabboWebTools.navigateToURL(_loc6_,"habboMain");
         }
         catch(e:Error)
         {
            class_21.log("GOT ERROR: " + e);
         }
         if(_openedToWebPopup == null)
         {
            _openedToWebPopup = new OpenedToWebPopup(this);
         }
         _openedToWebPopup.show(param3,param4);
      }
      
      public function getText(param1:String) : String
      {
         return _localization.getLocalization(param1);
      }
      
      public function registerParameter(param1:String, param2:String, param3:String) : void
      {
         _localization.registerParameter(param1,param2,param3);
      }
      
      public function showLimitReachedAlert() : void
      {
         registerParameter("friendlist.listfull.text","mylimit","" + friendRequests.limit);
         registerParameter("friendlist.listfull.text","clublimit","" + friendRequests.clubLimit);
         simpleAlert("${friendlist.listfull.title}","${friendlist.listfull.text}");
      }
      
      public function showFriendRequestSentAlert(param1:String) : void
      {
         registerParameter("friendlist.friendrequestsent.text","user_name",param1);
         simpleAlert("${friendlist.friendrequestsent.title}","${friendlist.friendrequestsent.text}");
      }
      
      public function getFriend(param1:int) : class_1927
      {
         if(var_18 == null)
         {
            class_21.log("Cannot process getFriend. Friendlist not initialized.");
            return null;
         }
         return var_143.findFriend(param1);
      }
      
      public function canBeAskedForAFriend(param1:int) : Boolean
      {
         if(var_18 == null)
         {
            class_21.log("Cannot process canBeAskedForAFriend. Friendlist not initialized.");
            return false;
         }
         return this.getFriend(param1) == null && !searchResults.isFriendRequestSent(param1) && categories.getFriendCount(false) < friendRequests.limit;
      }
      
      public function askForAFriend(param1:int, param2:String) : Boolean
      {
         if(var_18 == null)
         {
            class_21.log("Cannot ask for friend. Friendlist not initialized.");
            return false;
         }
         if(searchResults.isFriendRequestSent(param1))
         {
            return true;
         }
         if(!canBeAskedForAFriend(param1))
         {
            return false;
         }
         send(new RequestFriendMessageComposer(param2));
         searchResults.setFriendRequestSent(param1);
         send(new FriendRequestQuestCompleteMessageComposer());
         return true;
      }
      
      public function openFriendList() : void
      {
         openFriendListWithTab(1);
      }
      
      public function openFriendRequests() : void
      {
         openFriendListWithTab(2);
      }
      
      public function openFriendSearch() : void
      {
         openFriendListWithTab(3);
         SearchView(var_817.findTab(3).tabView).focus();
      }
      
      public function close() : void
      {
         if(var_18)
         {
            var_18.close();
         }
      }
      
      public function alignBottomLeftTo(param1:Point) : void
      {
         if(var_18)
         {
            var_18.alignBottomLeftTo(param1);
         }
      }
      
      public function isOpen() : Boolean
      {
         if(var_18)
         {
            return var_18.isOpen();
         }
         return false;
      }
      
      public function currentTabId() : int
      {
         if(var_18 == null || !var_18.isOpen())
         {
            return 0;
         }
         return var_4409;
      }
      
      private function openFriendListWithTab(param1:int) : void
      {
         if(var_18 == null)
         {
            class_21.log("Cannot open friendlist. Friendlist not initialized.");
            return;
         }
         var_18.openFriendList();
         var _loc2_:FriendListTab = tabs.findTab(param1);
         if(_loc2_ != tabs.findSelectedTab())
         {
            tabs.toggleSelected(_loc2_);
            view.refresh("openFriendList");
         }
         var_18.mainWindow.activate();
         var_4409 = param1;
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean) : int
      {
         if(var_18 == null)
         {
            class_21.log("Cannot get friend count. Friendlist not initialized.");
            return 0;
         }
         return this.var_143.getFriendCount(param1,param2);
      }
      
      public function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : class_2251
      {
         var _loc8_:BitmapData = getButtonImage(param2);
         var _loc7_:class_2251 = _windowManager.createWindow(param1,"",21,0,1 | 0x10,new Rectangle(param4,param5,_loc8_.width,_loc8_.height),param3,param6) as class_2251;
         _loc7_.bitmap = _loc8_;
         return _loc7_;
      }
      
      public function getXmlWindow(param1:String) : class_1741
      {
         var _loc3_:IAsset = assets.getAssetByName(param1 + "_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc3_);
         return _windowManager.buildFromXML(XML(_loc2_.content));
      }
      
      public function isMessagesPersisted() : Boolean
      {
         return getBoolean("friend_list.persistent_message_status.enabled");
      }
      
      public function getSmallGroupBadgeBitmap(param1:String) : BitmapData
      {
         if(_sessionData)
         {
            return _sessionData.getGroupBadgeSmallImage(param1);
         }
         return null;
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc3_:Boolean = getBoolean("zoom.enabled");
         var _loc4_:class_1827 = _avatarManager.createAvatarImage(param1,_loc3_ ? "h" : "sh",null,this);
         if(!_loc4_)
         {
            return null;
         }
         var _loc2_:BitmapData = HabboFaceFocuser.focusUserFace(_loc4_,"head",2,_loc3_ ? 0.5 : 1,20,20);
         _loc4_.dispose();
         return _loc2_;
      }
      
      public function isEmbeddedMinimailEnabled() : Boolean
      {
         var _loc1_:String = getProperty("client.minimail.embed.enabled");
         return _loc1_ == "true";
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEventParser = (param1 as UserObjectEvent).getParser();
         var_2699 = _loc2_.id;
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         var _loc2_:FriendListFragmentMessageEventParser = (param1 as FriendListFragmentMessageEvent).getParser();
         for each(var _loc3_ in _loc2_.friendFragment)
         {
            var_143.addFriend(new Friend(_loc3_));
         }
         if(_loc2_.fragmentNo == _loc2_.totalFragments - 1)
         {
            var_143.sort();
            var_4437 = true;
            var_143.findCategory(-1).setOpen(var_143.getFriendCount(true,false) == 0);
         }
      }
      
      private function onMessengerInit(param1:IMessageEvent) : void
      {
         var_18 = new FriendListView(this);
         var _loc2_:MessengerInitEventParser = (param1 as MessengerInitEvent).getParser();
         var_193 = new FriendRequests(new FriendRequestsDeps(this),_loc2_.userFriendLimit,_loc2_.extendedFriendLimit);
         var_143.addCategory(new FriendCategory(0,getText("friendlist.friends")));
         var_143.addCategory(new FriendCategory(-1,getText("friendlist.friends.offlinecaption")));
         var_817 = new FriendListTabs(new FriendListTabsDeps(this));
         if(!var_1173)
         {
            var_1173 = new Timer(1000000);
            var_1173.addEventListener("timer",sendFriendListUpdate);
            var_1173.start();
         }
         getFriendRequests();
         registerListeners();
         class_21.log("FRIENDLIST INITIALIZED SUCCESSFULLY");
      }
      
      public function trackFriendListEvent(param1:String) : void
      {
         events.dispatchEvent(new Event(param1));
      }
      
      private function getSortedFriends(param1:Array) : Array
      {
         var _loc3_:Array = [];
         var _loc6_:Dictionary = new Dictionary();
         for each(var _loc5_ in param1)
         {
            _loc3_.push(_loc5_.name.toLowerCase());
            _loc6_[_loc5_.name.toLowerCase()] = _loc5_;
         }
         _loc3_.sort();
         var _loc2_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc2_.push(_loc6_[_loc4_]);
         }
         return _loc2_;
      }
      
      private function registerListeners() : void
      {
         _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _communication.addHabboConnectionMessageEvent(new AcceptFriendResultEvent(onAcceptFriendResult));
         _communication.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequests));
         _communication.addHabboConnectionMessageEvent(new HabboSearchResultEvent(onHabboSearchResult));
         _communication.addHabboConnectionMessageEvent(new MessengerErrorEvent(onMessengerError));
         _communication.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
         _communication.addHabboConnectionMessageEvent(new FollowFriendFailedEvent(onFollowFriendFailed));
         _communication.addHabboConnectionMessageEvent(new RoomInviteErrorEvent(onRoomInviteError));
         _communication.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
      }
      
      private function getFriendRequests() : void
      {
         class_21.log("Sending friend requests request");
         send(new GetFriendRequestsMessageComposer());
      }
      
      protected function sendFriendListUpdate(param1:Event) : void
      {
         class_21.log("Sending update request");
         send(new FriendListUpdateMessageComposer());
      }
      
      private function onFriendRequests(param1:IMessageEvent) : void
      {
         var _loc2_:FriendRequestsEventParser = (param1 as FriendRequestsEvent).getParser();
         var_193.clearAndUpdateView(false);
         for each(var _loc3_ in _loc2_.reqs)
         {
            var_193.addRequest(new FriendRequest(_loc3_));
         }
         if(_loc2_.reqs.length > 0)
         {
            var_817.findTab(2).setNewMessageArrived(true);
         }
         var_18.refresh("friendRequests");
      }
      
      private function onNewFriendRequest(param1:IMessageEvent) : void
      {
         class_21.log("Received new friend request");
         var _loc2_:NewFriendRequestEventParser = (param1 as NewFriendRequestEvent).getParser();
         var _loc4_:FriendRequest = new FriendRequest(_loc2_.req);
         var_193.addRequestAndUpdateView(_loc4_);
         var _loc3_:FriendListTab = var_817.findTab(2);
         _loc3_.setNewMessageArrived(true);
         var_18.refresh("newFriendRequest");
      }
      
      private function onAcceptFriendResult(param1:IMessageEvent) : void
      {
         var _loc2_:AcceptFriendResultEventParser = (param1 as AcceptFriendResultEvent).getParser();
         for each(var _loc3_ in _loc2_.failures)
         {
            friendRequests.acceptFailed(_loc3_.senderId);
            showAlertView(_loc3_.errorCode);
         }
      }
      
      private function onHabboSearchResult(param1:IMessageEvent) : void
      {
         var _loc2_:HabboSearchResultEventParser = (param1 as HabboSearchResultEvent).getParser();
         _avatarSearchResults.searchReceived(_loc2_.friends,_loc2_.others);
         var_18.refresh("search");
      }
      
      private function onMessengerError(param1:IMessageEvent) : void
      {
         var _loc2_:MessengerErrorEventParser = (param1 as MessengerErrorEvent).getParser();
         showAlertView(_loc2_.errorCode,_loc2_.clientMessageId);
      }
      
      private function showAlertView(param1:int, param2:int = 0) : void
      {
         var _loc3_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = "${friendlist.error.friendlistownlimit}";
               break;
            case 1:
               _loc3_ = "${friendlist.error.friendlistlimitofrequester}";
               break;
            case 2:
               _loc3_ = "${friendlist.error.friend_requests_disabled}";
               break;
            case 3:
               _loc3_ = "${friendlist.error.requestnotfound}";
               break;
            case 6:
               _loc3_ = "${friendlist.error.blocked_by_them}";
               break;
            case 7:
               _loc3_ = "${friendlist.error.blocked_by_you}";
               break;
            default:
               _loc3_ = "Received messenger error: msg: " + param2 + ", errorCode: " + param1;
         }
         simpleAlert("${friendlist.alert.title}",_loc3_);
      }
      
      private function onRoomInviteError(param1:IMessageEvent) : void
      {
         var _loc2_:RoomInviteErrorEventParser = (param1 as RoomInviteErrorEvent).getParser();
         var _loc3_:String = "Received room invite error: errorCode: " + _loc2_.errorCode + ", recipients: " + Util.arrayToString(_loc2_.failedRecipients);
         simpleAlert("${friendlist.alert.title}",_loc3_);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var_143.onFriendListUpdate(param1);
         var_18.refresh("friendListUpdate");
      }
      
      private function onFollowFriendFailed(param1:IMessageEvent) : void
      {
         var _loc2_:FollowFriendFailedEventParser = (param1 as FollowFriendFailedEvent).getParser();
         var _loc3_:String = getFollowFriendErrorText(_loc2_.errorCode);
         class_21.log("Received follow friend failed: " + _loc2_.errorCode + ", " + _loc3_);
         simpleAlert("${friendlist.alert.title}",_loc3_);
      }
      
      public function simpleAlert(param1:String, param2:String) : void
      {
         windowManager.simpleAlert(param1,null,param2);
      }
      
      private function getFollowFriendErrorText(param1:int) : String
      {
         if(param1 == 0)
         {
            return "${friendlist.followerror.notfriend}";
         }
         if(param1 == 1)
         {
            return "${friendlist.followerror.offline}";
         }
         if(param1 == 2)
         {
            return "${friendlist.followerror.hotelview}";
         }
         if(param1 == 3)
         {
            return "${friendlist.followerror.prevented}";
         }
         return "Unknown follow friend error " + param1;
      }
      
      public function refreshText(param1:class_1812, param2:String, param3:Boolean, param4:String) : void
      {
         var _loc5_:class_1741 = param1.getChildByName(param2);
         if(!param3)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.visible = true;
            _loc5_.caption = param4;
         }
      }
      
      public function refreshButton(param1:class_1812, param2:String, param3:Boolean, param4:Function, param5:int) : void
      {
         var _loc6_:class_1741 = param1.findChildByName(param2) as class_1741;
         if(!param3)
         {
            _loc6_.visible = false;
         }
         else
         {
            prepareButton(_loc6_,param2,param4,param5);
            _loc6_.visible = true;
         }
      }
      
      public function refreshRelationshipRegion(param1:class_1812, param2:String, param3:int, param4:Function, param5:int) : void
      {
         var _loc6_:IRegionWindow = IRegionWindow(param1.findChildByName(param2));
         var _loc7_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc6_.findChildByTag("bitmap"));
         var _loc8_:String = "relationship_status_none";
         switch(param3 - 1)
         {
            case 0:
               _loc8_ = "relationship_status_heart";
               break;
            case 1:
               _loc8_ = "relationship_status_smile";
               break;
            case 2:
               _loc8_ = "relationship_status_bobba";
         }
         _loc7_.assetUri = _loc8_;
         _loc7_.visible = true;
         _loc6_.id = param5;
         _loc6_.procedure = param4;
         _loc6_.visible = param5 > 0 && getBoolean("relationship.status.enabled");
      }
      
      public function refreshIcon(param1:class_1812, param2:String, param3:Boolean, param4:Function, param5:int) : void
      {
         var _loc6_:class_1741 = param1.findChildByName(param2);
         if(!param3)
         {
            _loc6_.visible = false;
         }
         else
         {
            _loc6_.id = param5;
            _loc6_.procedure = param4;
            _loc6_.visible = true;
         }
      }
      
      private function prepareButton(param1:class_1741, param2:String, param3:Function, param4:int) : void
      {
         var _loc5_:class_2251 = null;
         param1.id = param4;
         if(param1 is class_2251)
         {
            _loc5_ = param1 as class_2251;
         }
         else
         {
            _loc5_ = class_1812(param1).findChildByTag("bitmap") as class_2251;
         }
         if(_loc5_.bitmap != null)
         {
            return;
         }
         _loc5_.bitmap = getButtonImage(param2);
         _loc5_.width = _loc5_.bitmap.width;
         _loc5_.height = _loc5_.bitmap.height;
         param1.procedure = param3;
      }
      
      public function getButtonImage(param1:String) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc5_:IAsset = assets.getAssetByName(param1 + "_png");
         var _loc3_:BitmapDataAsset = _loc5_ as BitmapDataAsset;
         class_21.log("GETTING ASSET: " + param1);
         var _loc2_:BitmapData = _loc3_.content as BitmapData;
         class_21.log("GOT ASSET: " + _loc5_ + ", " + _loc2_);
         _loc4_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc4_.draw(_loc2_);
         return _loc4_;
      }
      
      public function get lastRoomInvitationTime() : *
      {
         return _lastRoomInvitationTime;
      }
      
      public function resetLastRoomInvitationTime() : void
      {
         _lastRoomInvitationTime = getTimer();
      }
      
      public function get hasfriendsListInitialized() : Boolean
      {
         return var_4437;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get categories() : FriendCategories
      {
         return var_143;
      }
      
      public function get friendRequests() : FriendRequests
      {
         return var_193;
      }
      
      public function get searchResults() : AvatarSearchResults
      {
         return _avatarSearchResults;
      }
      
      public function get view() : FriendListView
      {
         return var_18;
      }
      
      public function get tabs() : FriendListTabs
      {
         return var_817;
      }
      
      public function get laf() : class_1748
      {
         return var_5095;
      }
      
      public function get messenger() : class_46
      {
         return _messenger;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get avatarId() : int
      {
         return var_2699;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function get mainWindow() : class_1812
      {
         if(var_18 == null)
         {
            return null;
         }
         return var_18.mainWindow;
      }
      
      public function getFriendNames() : Array
      {
         if(var_143 == null)
         {
            return [];
         }
         return var_143.getFriendNames();
      }
      
      public function acceptFriendRequest(param1:int) : void
      {
         if(!var_817)
         {
            return;
         }
         var _loc3_:FriendListTab = var_817.findTab(2);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:class_1747 = _loc3_.tabView as class_1747;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.acceptRequest(param1);
      }
      
      public function acceptAllFriendRequests() : void
      {
         var _loc2_:FriendListTab = var_817.findTab(2);
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:class_1747 = _loc2_.tabView as class_1747;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.acceptAllRequests();
      }
      
      public function declineFriendRequest(param1:int) : void
      {
         var _loc3_:FriendListTab = var_817.findTab(2);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:class_1747 = _loc3_.tabView as class_1747;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.declineRequest(param1);
      }
      
      public function declineAllFriendRequests() : void
      {
         var _loc2_:FriendListTab = var_817.findTab(2);
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:class_1747 = _loc2_.tabView as class_1747;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.declineAllRequests();
      }
      
      public function setRelationshipStatus(param1:int, param2:int) : void
      {
         send(new SetRelationshipStatusMessageComposer(param1,param2));
      }
      
      public function getRelationshipStatus(param1:int) : int
      {
         var _loc2_:Friend = var_143.findFriend(param1);
         if(_loc2_)
         {
            return _loc2_.relationshipStatus;
         }
         return 0;
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         if(!_sessionData || !var_193)
         {
            return;
         }
         var _loc2_:int = 0;
         if(_sessionData.hasVip)
         {
            _loc2_ = var_193.clubLimit;
         }
         else if(_sessionData.hasClub)
         {
            _loc2_ = var_193.clubLimit;
         }
         if(_loc2_ > var_193.limit)
         {
            var_193.limit = _loc2_;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc6_:class_1812 = null;
         var _loc5_:class_2251 = null;
         var _loc3_:BitmapData = null;
         if(disposed || var_143 == null)
         {
            return;
         }
         var _loc2_:Dictionary = var_143.getAllFriends();
         if(_loc2_ == null)
         {
            return;
         }
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_ != null && !_loc4_.disposed && _loc4_.figure == param1)
            {
               if(_loc4_.isGroupFriend())
               {
                  _loc4_.face = getSmallGroupBadgeBitmap(_loc4_.figure);
               }
               else
               {
                  _loc4_.face = getAvatarFaceBitmap(_loc4_.figure);
               }
               if(_loc4_.face != null)
               {
                  _loc6_ = _loc4_.view;
                  if(_loc6_ != null)
                  {
                     _loc5_ = _loc6_.getChildByName("face") as class_2251;
                     if(_loc5_ != null && !_loc5_.disposed)
                     {
                        _loc3_ = _loc5_.bitmap;
                        if(_loc3_ != null)
                        {
                           _loc3_.fillRect(_loc3_.rect,0);
                           _loc3_.copyPixels(_loc4_.face,_loc4_.face.rect,new Point(0,0),null,null,true);
                        }
                        _loc5_.invalidate();
                     }
                  }
               }
            }
         }
      }
      
      public function get linkPattern() : String
      {
         return "friendlist/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "open":
               openFriendList();
               break;
            case "openchat":
               if(_loc2_.length < 3 || _messenger == null)
               {
                  return;
               }
               var _loc3_:Array = _loc2_[2].split(":");
               if(null.length < 2)
               {
                  return;
               }
               if(int(null[0]) == var_2699)
               {
                  var _loc4_:int = int(null[1]);
               }
               else
               {
                  _loc4_ = int(null[0]);
               }
               break;
            default:
               class_21.log("FriendList unknown link-type received: " + _loc2_[1]);
         }
      }
      
      public function get avatarManager() : class_48
      {
         return _avatarManager;
      }
   }
}

