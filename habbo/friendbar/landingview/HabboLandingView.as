package com.sulake.habbo.friendbar.landingview
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.friendbar.onBoardingHc.OnBoardingHcFlow;
   import com.sulake.habbo.friendbar.view.AbstractView;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboAvatarEditor;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboQuestEngine;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import package_1.class_2848;
   import package_190.class_3478;
   import package_42.class_2826;
   import package_43.class_3575;
   import package_72.class_2589;
   
   public class HabboLandingView extends AbstractView implements IHabboLandingView
   {
      
      private var _landingViewLayout:WidgetContainerLayout;
      
      private var _communicationManager:class_57;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _navigator:class_41;
      
      private var _questEngine:class_498;
      
      private var _toolbar:IHabboToolbar;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarEditor:class_141;
      
      private var _gameManager:class_45;
      
      private var _avatarRenderManager:class_48;
      
      private var _errorLayout:class_1741;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_496:OnBoardingHcFlow;
      
      private var var_265:Boolean = false;
      
      private var var_4996:Boolean = false;
      
      public function HabboLandingView(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      public static function positionAfterAndStretch(param1:class_1812, param2:String, param3:String) : void
      {
         var _loc5_:class_1741 = param1.findChildByName(param2);
         var _loc6_:class_1741 = param1.findChildByName(param3);
         var _loc4_:int = _loc6_.x;
         _loc6_.x = _loc5_.x + _loc5_.width + 5;
         _loc6_.width += _loc4_ - _loc6_.x;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get questEngine() : class_498
      {
         return _questEngine;
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_498):void
         {
            _questEngine = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_45):void
         {
            _gameManager = param1;
         },false),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_141):void
         {
            _avatarEditor = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         },true,[{
            "type":"AVATAR_RENDER_READY",
            "callback":onAvatarRendererReady
         }]),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         })]);
      }
      
      private function onAvatarRendererReady(param1:Event = null) : void
      {
         if(isOnboardingRequired(_communicationManager.suggestedLoginActions))
         {
            var_496 = new OnBoardingHcFlow(_avatarRenderManager,_localizationManager,_communicationManager);
            var_496.addEventListener("NewUserFlowFinished",onNewUserReceptionFinished);
            var_496.setHcVisibility(false);
            context.displayObjectContainer.addChild(var_496);
            var_496.init(_communicationManager.suggestedLoginActions);
         }
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_265 = false;
            if(_landingViewLayout)
            {
               _landingViewLayout.dispose();
               _landingViewLayout = null;
            }
            if(var_496)
            {
               var_496.removeEventListener("NewUserFlowFinished",onNewUserReceptionFinished);
               var_496.dispose();
               var_496 = null;
            }
            if(_toolbar != null && _toolbar.events != null)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
            }
            if(_errorLayout)
            {
               _errorLayout.dispose();
               _errorLayout = null;
            }
            super.dispose();
         }
      }
      
      public function initialize() : void
      {
         var_265 = true;
         var _loc2_:class_2052 = _windowManager.getDesktop(0);
         var _loc1_:class_1741 = _loc2_.getChildByName("hotel_view_welcome_window");
         if(_loc1_ != null)
         {
            _loc2_.removeChild(_loc1_);
            _loc1_.dispose();
         }
         if(!(newIdentity && getBoolean("landing.view.new_identity_override_enabled")))
         {
            _landingViewLayout = new WidgetContainerLayout(this);
            activate();
            return;
         }
         var _loc3_:Array = getProperty("landing.view.new_identity_widgets").split(",");
         var _loc5_:int = 1;
         while(true)
         {
            var _loc4_:String = "landing.view.dynamic.slot." + 0 + ".";
            setProperty(null + "widget","widgetcontainer");
            setProperty(null + "conf","2001-01-01 00:00," + null[0 - 2]);
            _loc5_++;
         }
      }
      
      private function isOnboardingRequired(param1:Array) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(var_4996)
         {
            return false;
         }
         return param1.indexOf(0) >= 0 || param1.indexOf(1) >= 0;
      }
      
      public function activate() : void
      {
         if(isOnboardingRequired(_communicationManager.suggestedLoginActions))
         {
            if(_toolbar)
            {
               _toolbar.setToolbarState("HTE_STATE_HIDDEN");
            }
            return;
         }
         if(!var_265)
         {
            tryInitialize();
         }
         if(_toolbar)
         {
            _toolbar.setToolbarState("HTE_STATE_HOTEL_VIEW");
         }
         if(_landingViewLayout != null)
         {
            _landingViewLayout.activate();
         }
         else
         {
            class_21.log("ERROR - Landing view layout is not initialized and cannot be activated - See caught errors in tryInitialize()");
         }
      }
      
      public function disable() : void
      {
         if(_landingViewLayout != null)
         {
            _landingViewLayout.disable();
            toolbarExtensionExtraMargin = false;
         }
      }
      
      public function get isLandingViewVisible() : Boolean
      {
         return _landingViewLayout != null && _landingViewLayout.window != null && Boolean(_landingViewLayout.window.visible);
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         switch(param1.iconId)
         {
            case "HTIE_ICON_RECEPTION":
               if(_roomSessionManager.getSession(-1))
               {
                  send(new class_2589());
                  _roomSessionManager.disposeSession(-1);
               }
               break;
            case "HTIE_ICON_GAMES":
               if(getBoolean("game.center.enabled"))
               {
                  disable();
               }
         }
      }
      
      override protected function initComponent() : void
      {
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         _catalog.events.addEventListener("CATALOG_INVISIBLE_PAGE_VISITED",onExpiredLinkClick);
         _communicationManager.addHabboConnectionMessageEvent(new class_2826(onNavigatorSettings));
      }
      
      private function onExpiredLinkClick(param1:CatalogEvent) : void
      {
         if(var_265 && _landingViewLayout != null && _landingViewLayout.window != null && Boolean(_landingViewLayout.window.visible))
         {
            activate();
         }
      }
      
      private function onNavigatorSettings(param1:class_2826) : void
      {
         if(param1.getParser().roomIdToEnter <= 0)
         {
            tryInitialize();
         }
      }
      
      private function onNewUserReceptionFinished(param1:Event) : void
      {
         var_4996 = true;
         if(var_496)
         {
            var_496.dispose();
            var_496 = null;
         }
         _communicationManager.suggestedLoginActions = [];
         activate();
      }
      
      private function tryInitialize() : void
      {
         _errorLayout = getXmlWindow("initialization_error");
         _errorLayout.visible = false;
         try
         {
            initialize();
            class_1812(_errorLayout.parent).removeChild(_errorLayout);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboLandingView","Landing view layout initialization failed!");
            _landingViewLayout.dispose();
            _landingViewLayout = null;
            windowManager.getDesktop(0).addChild(_errorLayout);
            _errorLayout.center();
            _errorLayout.visible = true;
            context.root.error(e.message + " Landing view initialization failed because of a Flash Error. Landing view removed and disposed!",false,e.errorID,e);
         }
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
            if(_loc5_ == null || _loc3_ == null)
            {
               return null;
            }
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboLandingView","Failed to build window " + param1 + "_xml!");
            throw e;
         }
         return _loc4_;
      }
      
      public function goToRoom(param1:String = null) : void
      {
         if(param1 == null)
         {
            param1 = getProperty("landing.view.roomcategory");
         }
         if(param1 != null)
         {
            send(new class_2848(param1));
         }
      }
      
      public function getProductData(param1:String, param2:class_59) : class_1949
      {
         if(_sessionDataManager.loadProductData(param2))
         {
            return _sessionDataManager.getProductData(param1);
         }
         return null;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function requestBadge(param1:String) : void
      {
         send(new class_3575(param1));
      }
      
      public function communityGoalVote(param1:int) : void
      {
         send(new class_3478(param1));
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function set toolbarExtensionExtraMargin(param1:Boolean) : void
      {
         if(_toolbar && _toolbar.extensionView)
         {
            _toolbar.extensionView.extraMargin = param1 ? 10 : 0;
         }
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get dynamicLayoutLeftPaneWidth() : int
      {
         return getInteger("landing.view.dynamic.leftPaneWidth",500);
      }
      
      public function get dynamicLayoutRightPaneWidth() : int
      {
         return getInteger("landing.view.dynamic.rightPaneWidth",250);
      }
      
      public function get avatarEditor() : class_141
      {
         return _avatarEditor;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
   }
}

