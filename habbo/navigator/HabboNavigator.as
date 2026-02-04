package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.inroom.*;
   import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
   import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.toolbar.ToolbarHoverCtrl;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import package_1.class_1735;
   import package_1.class_1914;
   import package_1.class_1989;
   import package_1.class_2003;
   import package_42.class_1904;
   import package_42.class_1945;
   
   public class HabboNavigator extends class_17 implements class_41, class_42, ILinkEventTracker
   {
      
      private var _communication:class_57;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _sessionData:ISessionDataManager;
      
      private var _tracking:class_53;
      
      private var _catalog:IHabboCatalog;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarManager:class_48;
      
      private var var_124:MainViewCtrl;
      
      private var var_783:RoomInfoViewCtrl;
      
      private var var_1104:RoomCreateViewCtrl;
      
      private var var_24:NavigatorData;
      
      private var var_817:Tabs;
      
      private var var_909:class_40;
      
      private var var_1692:class_1762;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_2061:RoomSettingsCtrl;
      
      private var _passwordInput:GuestRoomPasswordInput;
      
      private var var_552:GuestRoomDoorbell;
      
      private var _officialRoomEntryManager:OfficialRoomEntryManager;
      
      private var var_2058:RoomEventViewCtrl;
      
      private var var_3581:RoomEventInfoCtrl;
      
      private var var_1823:RoomFilterCtrl;
      
      private var var_882:ToolbarHoverCtrl;
      
      private var var_2947:EnforceCategoryCtrl;
      
      private var var_5153:Boolean = true;
      
      private var _webRoomReportedName:String = null;
      
      public function HabboNavigator(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_909 = new AssetLibraryCollection("NavigatorComponent");
         var_24 = new NavigatorData(this);
         var_124 = new MainViewCtrl(this);
         var_783 = new RoomInfoViewCtrl(this);
         var_1104 = new RoomCreateViewCtrl(this);
         _passwordInput = new GuestRoomPasswordInput(this);
         var_552 = new GuestRoomDoorbell(this);
         var_817 = new Tabs(this);
         _officialRoomEntryManager = new OfficialRoomEntryManager(this);
         var_2058 = new RoomEventViewCtrl(this);
         var_3581 = new RoomEventInfoCtrl(this);
         var_1823 = new RoomFilterCtrl(this);
         var_2947 = new EnforceCategoryCtrl(this);
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get data() : NavigatorData
      {
         return var_24;
      }
      
      public function get mainViewCtrl() : ITransitionalMainViewCtrl
      {
         return var_124;
      }
      
      public function get tabs() : Tabs
      {
         return var_817;
      }
      
      public function get roomInfoViewCtrl() : RoomInfoViewCtrl
      {
         return var_783;
      }
      
      public function get roomCreateViewCtrl() : RoomCreateViewCtrl
      {
         return var_1104;
      }
      
      public function get assetLibrary() : class_40
      {
         return var_909;
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get roomSettingsCtrl() : RoomSettingsCtrl
      {
         return var_2061;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get passwordInput() : GuestRoomPasswordInput
      {
         return _passwordInput;
      }
      
      public function get doorbell() : GuestRoomDoorbell
      {
         return var_552;
      }
      
      public function get roomEventViewCtrl() : RoomEventViewCtrl
      {
         return var_2058;
      }
      
      public function get officialRoomEntryManager() : OfficialRoomEntryManager
      {
         return _officialRoomEntryManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get roomEventInfoCtrl() : RoomEventInfoCtrl
      {
         return var_3581;
      }
      
      public function get roomFilterCtrl() : RoomFilterCtrl
      {
         return var_1823;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get enforceCategoryCtrl() : EnforceCategoryCtrl
      {
         return var_2947;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         var_1692 = new class_1762(this);
         _roomSessionManager.events.addEventListener("RSE_CREATED",onRoomSessionCreatedEvent);
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            context.addLinkEventTracker(this);
         }
         var _loc1_:String = getProperty("navigator.default_tab");
         if(getInteger("new.identity",0) > 0)
         {
            _loc1_ = getProperty("new.identity.navigator.default_tab");
         }
         tabs.setSelectedTab(Tabs.tabIdFromName(_loc1_,2));
         var_2061 = new RoomSettingsCtrl(this);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("openroom",enterRoomWebRequest);
         }
      }
      
      public function enterRoomWebRequest(param1:String, param2:Boolean = false, param3:String = null) : void
      {
         var_5153 = param2;
         _webRoomReportedName = param3;
         send(new class_1735(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_124)
         {
            var_124.dispose();
            var_124 = null;
         }
         if(_roomSessionManager != null)
         {
            _roomSessionManager.events.removeEventListener("RSE_CREATED",onRoomSessionCreatedEvent);
         }
         context.removeLinkEventTracker(this);
         if(_toolbar != null && _toolbar.events != null)
         {
            _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
         }
         if(var_783)
         {
            var_783.dispose();
            var_783 = null;
         }
         if(var_1823)
         {
            var_1823.dispose();
            var_1823 = null;
         }
         if(var_1104)
         {
            var_1104.dispose();
            var_1104 = null;
         }
         if(_officialRoomEntryManager)
         {
            _officialRoomEntryManager.dispose();
            _officialRoomEntryManager = null;
         }
         if(var_2058)
         {
            var_2058.dispose();
            var_2058 = null;
         }
         if(var_2061)
         {
            var_2061.dispose();
            var_2061 = null;
         }
         if(var_882)
         {
            var_882.dispose();
            var_882 = null;
         }
         super.dispose();
      }
      
      public function startRoomCreation() : void
      {
         var_1104.show();
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         send(new class_2003(param1,false,true));
      }
      
      public function removeRoomRights(param1:int) : void
      {
         send(new class_1989(param1));
      }
      
      public function hasRoomRightsButIsNotOwner(param1:int) : Boolean
      {
         if(_roomSessionManager)
         {
            var _loc2_:IRoomSession = _roomSessionManager.getSession(param1);
            return null.roomControllerLevel == 1 && !null.isRoomOwner;
         }
         return false;
      }
      
      public function goToRoomNetwork(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(_roomSessionManager)
         {
            var_783.close();
            _loc3_ = 0;
            if(param2 && var_24.homeRoomId > 0)
            {
               _loc3_ = var_24.homeRoomId;
            }
            _roomSessionManager.gotoRoomNetwork(param1,_loc3_);
         }
      }
      
      public function goToRoom(param1:int, param2:Boolean, param3:String = "", param4:int = -1, param5:Boolean = false) : void
      {
         if(_roomSessionManager)
         {
            class_21.log("[HabboNavigator] Go to room: " + param1);
            if(param2)
            {
               var_124.close();
            }
            _roomSessionManager.gotoRoom(param1,param3,"",param5);
            if(tabs.getSelected())
            {
               var _loc6_:int = param4 > -1 ? param4 + 1 : 0;
               switch(tabs.getSelected().id - 1)
               {
                  case 0:
                     trackNavigationDataPoint("Events","go.events",String(param1),0);
                     break;
                  case 1:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.rooms",String(param1),0);
                     break;
                  case 2:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.me",String(param1),0);
                     break;
                  case 3:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.official",String(param1),0);
                     break;
                  case 4:
                     trackNavigationDataPoint("Search","go.search",String(param1),0);
               }
            }
         }
         else
         {
            class_21.log("[HabboNavigator] Room Session Manager is not initialized. Can not enter: " + param1);
         }
      }
      
      public function goToHomeRoom() : Boolean
      {
         if(this.var_24.homeRoomId < 1)
         {
            class_21.log("No home room set while attempting to go to home room");
            return false;
         }
         this.goToRoom(this.var_24.homeRoomId,true);
         return true;
      }
      
      public function send(param1:IMessageComposer, param2:Boolean = false) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : class_1741
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:class_1741 = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getText(param1:String) : String
      {
         var _loc2_:String = _localization.getLocalization(param1);
         if(_loc2_ == null || _loc2_ == "")
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function registerParameter(param1:String, param2:String, param3:String) : String
      {
         return _localization.registerParameter(param1,param2,param3);
      }
      
      public function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : class_2251
      {
         var _loc8_:BitmapData = getButtonImage(param2);
         var _loc7_:class_2251 = class_2251(_windowManager.createWindow(param1,"",21,0,1 | 0x10,new Rectangle(param4,param5,_loc8_.width,_loc8_.height),param3,param6));
         _loc7_.bitmap = _loc8_;
         _loc7_.disposesBitmap = false;
         return _loc7_;
      }
      
      public function refreshButton(param1:class_1812, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         if(!param6)
         {
            param6 = param2;
         }
         var _loc7_:class_2251 = param1.findChildByName(param2) as class_2251;
         if(!_loc7_)
         {
            class_21.log("Could not locate button in navigator: " + param2);
         }
         if(!param3)
         {
            _loc7_.visible = false;
         }
         else
         {
            prepareButton(_loc7_,param6,param4,param5);
            _loc7_.visible = true;
         }
      }
      
      private function prepareButton(param1:class_2251, param2:String, param3:Function, param4:int) : void
      {
         param1.id = param4;
         param1.procedure = param3;
         if(param1.bitmap != null)
         {
            return;
         }
         param1.bitmap = getButtonImage(param2);
         param1.disposesBitmap = false;
         param1.width = param1.bitmap.width;
         param1.height = param1.bitmap.height;
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         var _loc4_:String = param1 + param2;
         var _loc7_:IAsset = assets.getAssetByName(_loc4_);
         var _loc5_:BitmapDataAsset = BitmapDataAsset(_loc7_);
         return BitmapData(_loc5_.content);
      }
      
      private function onRoomSessionCreatedEvent(param1:RoomSessionEvent) : void
      {
         if(_roomSessionManager && var_783)
         {
            var_783.close();
         }
      }
      
      public function openCatalogClubPage(param1:String) : void
      {
         if(_catalog == null)
         {
            return;
         }
         _catalog.openClubCenter();
      }
      
      public function openCatalogRoomAdsPage() : void
      {
         if(_catalog == null)
         {
            return;
         }
         _catalog.openCatalogPage("room_ad");
      }
      
      public function openCatalogRoomAdsExtendPage(param1:String, param2:String, param3:Date, param4:int) : void
      {
         if(_catalog == null)
         {
            return;
         }
         var _loc5_:String = var_24.enteredGuestRoom.roomName;
         _catalog.openRoomAdCatalogPageInExtendedMode("room_ad",param1,param2,_loc5_,param3,param4);
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            switch(param1.iconId)
            {
               case "HTIE_ICON_ROOMINFO":
                  toggleRoomInfoVisibility();
                  break;
               case "HTIE_ICON_NAVIGATOR_ME_TAB":
                  showOwnRooms();
                  break;
               case "HTIE_ICON_GAMES":
                  if(getBoolean("game.center.enabled"))
                  {
                     closeNavigator();
                  }
                  break;
               case "HTIE_ICON_HOME":
                  goToHomeRoom();
            }
         }
      }
      
      public function toggleRoomInfoVisibility() : void
      {
         if(var_1104)
         {
            var_783.toggle();
         }
      }
      
      public function performTagSearch(param1:String) : void
      {
         if(var_124 == null)
         {
            return;
         }
         if(param1.indexOf(" ") != -1)
         {
            param1 = "\"" + param1 + "\"";
         }
         var_124.startSearch(5,9,param1);
         trackNavigationDataPoint("Search","search.tag",param1);
         var_124.mainWindow.activate();
      }
      
      public function performTextSearch(param1:String) : void
      {
         if(var_124 == null)
         {
            return;
         }
         var_124.startSearch(5,8,param1);
         trackNavigationDataPoint("Search","search",param1);
         var_124.mainWindow.activate();
         var_124.searchInput.searchStr.setText(param1);
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
         if(var_124 == null || var_24 != null && var_24.isLoading())
         {
            return;
         }
         var_24.competitionRoomsData = new class_1904(null,param1,param2);
         var_124.startSearch(5,15,"");
         var_124.mainWindow.activate();
         var_124.searchInput.searchStr.setText("");
      }
      
      public function performGuildBaseSearch() : void
      {
         if(var_124 == null)
         {
            return;
         }
         var_124.startSearch(5,14,"");
         var_124.mainWindow.activate();
         var_124.searchInput.searchStr.setText("");
      }
      
      public function showOwnRooms() : void
      {
         if(var_124 == null)
         {
            return;
         }
         var_124.startSearch(3,5);
         var_817.getTab(3).tabPageDecorator.tabSelected();
      }
      
      public function showFavouriteRooms() : void
      {
         showMeTab(6);
      }
      
      public function showHistoryRooms() : void
      {
         showMeTab(7);
      }
      
      public function showFrequentRooms() : void
      {
         showMeTab(23);
      }
      
      private function showMeTab(param1:int) : void
      {
         if(var_124 == null)
         {
            return;
         }
         var_124.startSearch(3,param1);
         var_817.getTab(3).tabPageDecorator.setSubSelection(param1);
      }
      
      public function trackNavigationDataPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         if(_tracking)
         {
            _tracking.trackEventLog("Navigation",param1,param2,param3,param4);
         }
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function openNavigator(param1:Point = null) : void
      {
      }
      
      public function closeNavigator() : void
      {
         var_124.close();
      }
      
      public function goToMainView() : void
      {
         var_1104.hide();
         var_783.close();
      }
      
      public function get homeRoomId() : int
      {
         return var_24 ? var_24.homeRoomId : -1;
      }
      
      public function get webRoomReport() : Boolean
      {
         return var_5153;
      }
      
      public function get webRoomReportedName() : String
      {
         return _webRoomReportedName;
      }
      
      public function get enteredGuestRoomData() : class_1945
      {
         if(var_24)
         {
            return var_24.enteredGuestRoom;
         }
         return null;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get linkPattern() : String
      {
         return "navigator/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "goto":
               if(_loc2_.length > 2)
               {
                  var _loc4_:* = _loc2_[2];
                  if("home" !== _loc4_)
                  {
                     _loc3_ = int(_loc2_[2]);
                     if(_loc3_ > 0)
                     {
                        goToPrivateRoom(_loc3_);
                        break;
                     }
                     send(new class_1914(_loc2_[2]));
                     break;
                  }
                  goToHomeRoom();
               }
               break;
            case "search":
               if(_loc2_.length > 2)
               {
                  performTextSearch(_loc2_[2]);
               }
               break;
            case "tag":
               if(_loc2_.length > 2)
               {
                  performTagSearch(_loc2_[2]);
               }
               break;
            case "tab":
               if(_loc2_.length > 2)
               {
                  tabs.setSelectedTab(Tabs.tabIdFromName(_loc2_[2],2));
                  openNavigator(null);
               }
               break;
            case "report":
               if(_loc2_.length > 3)
               {
                  enterRoomWebRequest(_loc2_[2],true,_loc2_[3]);
               }
               break;
            default:
               class_21.log("Navigator unknown link-type received: " + _loc2_[1]);
         }
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            if(var_124 && var_124.isPhaseOneNavigator != isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
            {
               var_124.close();
            }
            context.addLinkEventTracker(this);
         }
         else
         {
            context.removeLinkEventTracker(this);
         }
      }
      
      public function showToolbarHover(param1:Point) : void
      {
         if(!var_882)
         {
            var_882 = new ToolbarHoverCtrl(this);
         }
         var_882.show(param1);
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
         if(!var_882)
         {
            return;
         }
         if(param1)
         {
            var_882.hideDelayed();
         }
         else
         {
            var_882.hide();
         }
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         if(_sessionData)
         {
            return _sessionData.isPerkAllowed(param1);
         }
         return false;
      }
      
      public function canRateRoom() : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.canRate;
      }
      
      public function isRoomFavorite(param1:int) : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.isRoomFavourite(param1);
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.isRoomHome(param1);
      }
      
      public function get visibleEventCategories() : Array
      {
         if(!data)
         {
            return [];
         }
         return data.visibleEventCategories;
      }
   }
}

