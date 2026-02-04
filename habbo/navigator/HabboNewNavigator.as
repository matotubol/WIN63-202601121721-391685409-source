package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.cache.NavigatorCache;
   import com.sulake.habbo.navigator.context.ContextContainer;
   import com.sulake.habbo.navigator.context.SearchContext;
   import com.sulake.habbo.navigator.context.SearchContextHistoryManager;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.lift.LiftDataContainer;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.navigator.view.NavigatorView;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.utils.Base64;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.geom.Point;
   import package_1.class_1914;
   import package_1.class_2003;
   import package_12.class_1946;
   import package_15.class_1773;
   import package_15.class_1910;
   import package_15.class_1974;
   import package_15.class_2192;
   import package_19.class_1783;
   import package_19.class_1810;
   import package_19.class_2061;
   import package_19.class_2171;
   import package_19.class_2210;
   import package_19.class_2229;
   import package_19.class_2230;
   import package_25.class_1798;
   import package_25.class_1895;
   import package_25.class_1995;
   import package_25.class_2073;
   import package_3.class_1846;
   import package_42.class_1945;
   import package_9.class_1796;
   import package_9.class_1879;
   
   public class HabboNewNavigator extends class_17 implements IHabboNewNavigator, ILinkEventTracker
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
      
      private var var_1692:class_2023;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_54:HabboNavigator;
      
      private var var_928:LegacyNavigator;
      
      private var var_704:Boolean = false;
      
      private var var_212:NavigatorView;
      
      private var var_1733:ContextContainer;
      
      private var var_3509:LiftDataContainer;
      
      private var var_2373:SearchContextHistoryManager;
      
      private var _currentResults:class_1995;
      
      private var _groupDetails:class_55 = new class_55();
      
      private var var_2633:class_55 = new class_55();
      
      private var var_2803:Vector.<String> = new Vector.<String>(0);
      
      private var _navigatorCache:NavigatorCache;
      
      private var var_2913:String = "official_view";
      
      private var var_3028:String = "";
      
      private var var_4240:String = "";
      
      private var var_3065:Boolean = false;
      
      private var _noPushToHistoryDueToNavigation:Boolean = false;
      
      public function HabboNewNavigator(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_928 = new LegacyNavigator(this,var_54);
      }
      
      public static function getEventLogExtraStringFromSearch(param1:String, param2:String) : String
      {
         return param1 + (param2 == "" ? "" : ":" + param2);
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
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
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            var_54 = HabboNavigator(param1);
            if(var_928)
            {
               var_928.oldNavigator = var_54;
            }
         },true)]);
      }
      
      override protected function initComponent() : void
      {
         var_1692 = new class_2023(this);
         context.addLinkEventTracker(this);
         var_212 = new NavigatorView(this);
         var_1733 = new ContextContainer(this);
         var_2373 = new SearchContextHistoryManager(this);
         var_3509 = new LiftDataContainer(this);
         _navigatorCache = new NavigatorCache();
         _communication.connection.send(new class_2210());
         var_704 = true;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            var _loc2_:* = param1.iconId;
            if("HTIE_ICON_NAVIGATOR" === _loc2_)
            {
               toggle();
            }
         }
      }
      
      public function initialize(param1:class_1773) : void
      {
         var_1733.initialize(param1);
      }
      
      public function onSearchResult(param1:class_1995) : void
      {
         var_3065 = false;
         _currentResults = param1;
         extractRoomNamesFromResults(param1.resultSet);
         if(!_noPushToHistoryDueToNavigation)
         {
            var_2373.addSearchContextAtCurrentOffset(new SearchContext(param1.searchCodeOriginal,param1.filteringData));
         }
         _navigatorCache.put(param1.searchCodeOriginal + "/" + param1.filteringData,param1);
         _noPushToHistoryDueToNavigation = false;
         if(var_212.visible)
         {
            var_212.onSearchResults(param1,var_4240);
         }
      }
      
      private function extractRoomNamesFromResults(param1:class_1798) : void
      {
         var_2633 = new class_55();
         for each(var _loc2_ in param1.blocks)
         {
            for each(var _loc3_ in _loc2_.guestRooms)
            {
               var_2633.add(_loc3_.flatId,_loc3_.roomName);
            }
         }
      }
      
      public function get newResultsRendered() : Boolean
      {
         return var_3065;
      }
      
      public function set newResultsRendered(param1:Boolean) : void
      {
         var_3065 = param1;
      }
      
      public function onLiftedRooms(param1:class_2192) : void
      {
         var_3509.setLiftedRooms(param1.liftedRooms);
         var_212.refreshLiftedRooms();
      }
      
      public function onPreferences(param1:class_1974) : void
      {
         var_212.setInitialWindowDimensions(param1.windowX,param1.windowY,param1.windowHeight,param1.leftPaneHidden,param1.resultsMode);
      }
      
      public function onSavedSearches(param1:class_1910) : void
      {
         var_1733.savedSearches = param1.savedSearches.concat(new Vector.<class_2073>(0));
         var_212.onSavedSearches(var_1733.savedSearches);
      }
      
      public function onGroupDetails(param1:class_1846) : void
      {
         if(_groupDetails.hasKey(param1.groupId))
         {
            _groupDetails.remove(param1.groupId);
         }
         _groupDetails.add(param1.groupId,param1);
         var_212.onGroupDetailsArrived(param1.groupId);
      }
      
      public function onCollapsedCategories(param1:Vector.<String>) : void
      {
         var_2803 = param1.concat();
      }
      
      public function get collapsedCategories() : Vector.<String>
      {
         return var_2803;
      }
      
      public function getCachedGroupDetails(param1:int) : class_1846
      {
         return _groupDetails.getValue(param1);
      }
      
      public function goBack() : void
      {
         if(var_2373.hasPrevious)
         {
            _noPushToHistoryDueToNavigation = true;
            performSearchByContext(var_2373.getPreviousSearchContextAndGoBack());
         }
         trackEventLog("browse.back","Results");
      }
      
      public function performLastSearch() : void
      {
         if(var_2913 != null && var_3028 != null)
         {
            _navigatorCache.removeEntry(var_2913 + "/" + var_3028);
            performSearch(var_2913,var_3028);
         }
      }
      
      public function performSearch(param1:String, param2:String = "", param3:String = "") : void
      {
         var_212.isBusy = true;
         var_4240 = param3;
         var _loc4_:class_1995 = _navigatorCache.getEntry(param1 + "/" + param2);
         if(_loc4_ != null)
         {
            onSearchResult(_loc4_);
         }
         else
         {
            var_2913 = param1;
            var_3028 = param2;
            _communication.connection.send(new class_2171(param1,param2));
            trackEventLog("search","Search",getEventLogExtraStringFromSearch(param1,param2));
         }
         open();
      }
      
      public function performSearchByContext(param1:SearchContext) : void
      {
         performSearch(param1.searchCode,param1.filtering);
      }
      
      public function addSavedSearch(param1:String, param2:String) : void
      {
         if(_currentResults != null)
         {
            _communication.connection.send(new class_1783(param1,param2));
         }
         trackEventLog("savedsearch.add","SavedSearch",getEventLogExtraStringFromSearch(param1,param2));
         var_212.setLeftPaneVisibility(true);
      }
      
      public function deleteSavedSearch(param1:int) : void
      {
         _communication.connection.send(new class_1810(param1));
         trackEventLog("savedsearch.delete","SavedSearch");
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            context.removeLinkEventTracker(this);
            if(var_704)
            {
               var_1692.removeLegacyMessageListeners();
               close();
            }
            return;
         }
         if(!var_704)
         {
            initComponent();
         }
         else if(_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            var_1692.addMessageListeners();
         }
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
                        var_928.goToPrivateRoom(_loc3_);
                        break;
                     }
                     communication.connection.send(new class_1914(_loc2_[2]));
                     break;
                  }
                  var_928.goToHomeRoom();
               }
               break;
            case "search":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tag":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tab":
               if(_loc2_.length > 2)
               {
                  performSearch(_loc2_[2]);
               }
               break;
            case "report":
               if(_loc2_.length > 3)
               {
                  var_928.reportRoomFromWeb(_loc2_[2],Base64.decode(_loc2_[3]));
               }
               break;
            default:
               class_21.log("Navigator unknown link-type received: " + _loc2_[1]);
         }
      }
      
      public function showOwnRooms() : void
      {
      }
      
      public function showToolbarHover(param1:Point) : void
      {
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
      }
      
      public function get isReady() : Boolean
      {
         return var_1733 != null && var_1733.isReady();
      }
      
      public function get contextContainer() : ContextContainer
      {
         return var_1733;
      }
      
      public function get searchContextHistoryManager() : SearchContextHistoryManager
      {
         return var_2373;
      }
      
      public function get liftDataContainer() : LiftDataContainer
      {
         return var_3509;
      }
      
      public function get currentResults() : class_1995
      {
         return _currentResults;
      }
      
      public function goToRoom(param1:int, param2:String = "mainview") : void
      {
         communication.connection.send(new class_2003(param1,false,true));
         var_212.visible = false;
         var _loc3_:String = var_2633.getValue(param1);
         trackEventLog("go",param2,!_loc3_ ? "" : _loc3_,param1);
      }
      
      public function getExtendedProfile(param1:int) : void
      {
         communication.connection.send(new class_1879(param1));
      }
      
      public function get imageLibraryBaseUrl() : String
      {
         return context.configuration.getProperty("image.library.url");
      }
      
      public function performTagSearch(param1:String) : void
      {
         performSearch("hotel_view","tag:" + param1);
      }
      
      public function createRoom() : void
      {
         var_928.roomCreateViewCtrl.show();
      }
      
      public function open() : void
      {
         if(var_212 == null)
         {
            return;
         }
         if(!var_212.visible)
         {
            var_212.visible = true;
         }
      }
      
      public function close() : void
      {
         if(var_212.visible)
         {
            var_212.visible = false;
         }
      }
      
      public function toggle() : void
      {
         if(var_212 == null)
         {
            return;
         }
         var_212.visible = !var_212.visible;
         if(var_212.visible)
         {
            performLastSearch();
         }
      }
      
      public function get mainWindow() : class_2250
      {
         return var_212.mainWindow;
      }
      
      public function refresh() : void
      {
         if(_currentResults)
         {
            var_212.onSearchResults(_currentResults);
         }
      }
      
      public function get legacyNavigator() : class_41
      {
         return var_928;
      }
      
      public function get data() : NavigatorData
      {
         return var_928.data;
      }
      
      public function sendWindowPreferences(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int) : void
      {
         _communication.connection.send(new class_1946(param1,param2,param3,param4,param5,param6));
      }
      
      public function getGuildInfo(param1:int, param2:Boolean = true) : void
      {
         _communication.connection.send(new class_1796(param1,param2));
      }
      
      public function sendAddCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new class_2061(param1));
      }
      
      public function sendRemoveCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new class_2229(param1));
      }
      
      public function goToHomeRoom() : void
      {
         goToRoom(var_928.data.homeRoomId,"external");
      }
      
      public function trackEventLog(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         if(_tracking)
         {
            _tracking.trackEventLog("NewNavigator",param2,param1,param3,param4);
         }
      }
      
      public function get view() : NavigatorView
      {
         return var_212;
      }
      
      public function toggleSearchCodeViewMode(param1:String, param2:int) : void
      {
         _communication.connection.send(new class_2230(param1,param2));
         trackEventLog("browse.toggleviewmode","ViewMode","",param2);
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function performTextSearch(param1:String) : void
      {
      }
      
      public function performGuildBaseSearch() : void
      {
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
      }
   }
}

