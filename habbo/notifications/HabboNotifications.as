package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.feed.NotificationController;
   import com.sulake.habbo.notifications.singular.SingularNotificationController;
   import com.sulake.habbo.notifications.utils.PetImageUtility;
   import com.sulake.habbo.notifications.utils.ProductImageUtility;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import package_69.JSONDecoder;
   import package_9.class_1890;
   
   public class HabboNotifications extends class_17 implements class_536
   {
      
      private var _communication:class_57;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _inventory:class_61;
      
      private var _friendList:class_258;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolBar:IHabboToolbar;
      
      private var var_1631:ProductImageUtility;
      
      private var var_1646:PetImageUtility;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _freeFlowChat:class_51;
      
      private var _avatarRenderManager:class_48;
      
      private var var_1826:NotificationController;
      
      private var var_2446:SingularNotificationController;
      
      private var var_2418:class_1762;
      
      private var var_2482:Boolean;
      
      public function HabboNotifications(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_2482 = false;
      }
      
      public function get assetLibrary() : class_40
      {
         return assets;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get toolBar() : IHabboToolbar
      {
         return _toolBar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get singularController() : SingularNotificationController
      {
         return var_2446;
      }
      
      public function get feedController() : NotificationController
      {
         return var_1826;
      }
      
      public function get disabled() : Boolean
      {
         return var_2482;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var_2482 = param1;
      }
      
      public function get productImageUtility() : ProductImageUtility
      {
         if(_roomEngine == null || _inventory == null)
         {
            return null;
         }
         if(var_1631 == null)
         {
            var_1631 = new ProductImageUtility(_roomEngine,_inventory);
         }
         return var_1631;
      }
      
      public function get petImageUtility() : PetImageUtility
      {
         if(_roomEngine == null)
         {
            return null;
         }
         if(var_1646 == null)
         {
            var_1646 = new PetImageUtility(_roomEngine);
         }
         return var_1646;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false,[{
            "type":"CATALOG_BUILDER_MEMBERSHIP_EXPIRED",
            "callback":onBuilderMembershipExpired
         },{
            "type":"CATALOG_BUILDER_MEMBERSHIP_IN_GRACE",
            "callback":onBuilderMembershipInGrace
         },{
            "type":"COLLECTIBLES_CLAIM_FAIL",
            "callback":onCollectiblesClaimFail
         },{
            "type":"COLLECTIBLE_CLAIM_SUCCESS",
            "callback":onCollectiblesClaimSuccess
         },{
            "type":"COLLECTIBLE_CLAIM_WAIT",
            "callback":onCollectiblesClaimWait
         },{
            "type":"COLLECTIBLES_MINT_FAIL",
            "callback":onCollectiblesMintFail
         },{
            "type":"COLLECTIBLES_MINT_SUCCESS",
            "callback":onCollectiblesMintSuccess
         }]),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolBar = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         var_2446 = new SingularNotificationController(this);
         var_2418 = new class_1762(this,_communication);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_2418 != null)
         {
            var_2418.dispose();
            var_2418 = null;
         }
         if(var_1826 != null)
         {
            var_1826.dispose();
            var_1826 = null;
         }
         if(var_1646 != null)
         {
            var_1646.dispose();
            var_1646 = null;
         }
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         super.dispose();
      }
      
      public function activate() : void
      {
         if(var_1826 != null)
         {
            var_1826.setFeedEnabled(true);
         }
         _communication.connection.send(new class_1890());
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         var_2446.addSongPlayingNotification(param1,param2);
      }
      
      public function addItem(param1:String, param2:String, param3:String = null, param4:String = null, param5:Array = null) : void
      {
         if(param3 != null)
         {
            var _loc6_:BitmapData = (assets.getAssetByName(param3).content as BitmapData).clone();
         }
         addItemWithBitmap(param1,param2,null,param4,param5);
      }
      
      public function addItemWithBitmap(param1:String, param2:String, param3:BitmapData = null, param4:String = null, param5:Array = null) : void
      {
         var_2446.addItem(param1,param2,param3,null,null,param4,param5);
      }
      
      public function showNotification(param1:String, param2:class_55 = null) : void
      {
         var _loc7_:Object = null;
         var _loc9_:String = null;
         var _loc6_:String = null;
         var _loc3_:Boolean = false;
         var _loc5_:String = null;
         if(param2 == null)
         {
            param2 = new class_55();
         }
         var _loc4_:String = "notification." + param1;
         if(propertyExists(_loc4_))
         {
            _loc7_ = new JSONDecoder(getProperty(_loc4_),true).getValue();
            for(var _loc8_ in _loc7_)
            {
               param2[_loc8_] = _loc7_[_loc8_];
            }
         }
         if(param2["display"] == "BUBBLE")
         {
            _loc9_ = getNotificationPart(param2,param1,"message",true);
            _loc6_ = getNotificationPart(param2,param1,"linkUrl",false);
            _loc3_ = _loc6_ != null && _loc6_.substr(0,6) == "event:";
            _loc5_ = getNotificationImageUrl(param2,param1);
            var_2446.addItem(_loc9_,"info",null,_loc5_,null,_loc3_ ? _loc6_.substr(6) : _loc6_);
         }
         else
         {
            new NotificationPopup(this,param1,param2);
         }
      }
      
      public function getNotificationPart(param1:class_55, param2:String, param3:String, param4:Boolean) : String
      {
         var _loc5_:String = null;
         if(param1.hasKey(param3))
         {
            return param1.getValue(param3);
         }
         _loc5_ = ["notification",param2,param3].join(".");
         if(localization.hasLocalization(_loc5_) || param4)
         {
            return localization.getLocalizationWithParamMap(_loc5_,_loc5_,param1);
         }
         return null;
      }
      
      public function getNotificationImageUrl(param1:class_55, param2:String) : String
      {
         var _loc3_:String = param1.getValue("image");
         if(_loc3_ == null)
         {
            _loc3_ = "${image.library.url}notifications/" + param2.replace(/\./g,"_") + ".png";
         }
         return _loc3_;
      }
      
      private function onBuilderMembershipInGrace(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_in_grace",null);
      }
      
      private function onBuilderMembershipExpired(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_expired",null);
      }
      
      private function onCollectiblesClaimFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.success"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimWait(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.wait"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.success"),"info","icon_curator_stamp_large_png");
      }
      
      public function createLinkEvent(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
   }
}

