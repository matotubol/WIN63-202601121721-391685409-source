package com.sulake.habbo.session
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.session.events.MysteryBoxKeysUpdateEvent;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.session.events.SessionDataToWidgetEvent;
   import com.sulake.habbo.session.events.UserNameUpdateEvent;
   import com.sulake.habbo.session.furniture.FurnitureDataParser;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.furniture.class_60;
   import com.sulake.habbo.session.product.ProductDataParser;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.*;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import package_12.class_1944;
   import package_21.class_1787;
   import package_21.class_2089;
   import package_21.class_2094;
   import package_21.class_2206;
   import package_22.class_1789;
   import package_23.class_1790;
   import package_24.class_1795;
   import package_24.class_1886;
   import package_27.class_1809;
   import package_3.class_1804;
   import package_3.class_1808;
   import package_3.class_1999;
   import package_3.class_2193;
   import package_33.class_1849;
   import package_33.class_1874;
   import package_33.class_1973;
   import package_35.class_1854;
   import package_37.class_1865;
   import package_39.class_1884;
   import package_4.class_1743;
   import package_4.class_1757;
   import package_4.class_2005;
   import package_44.class_1913;
   import package_52.class_2031;
   import package_54.class_2169;
   import package_58.class_2063;
   import package_59.class_2064;
   import package_63.class_2114;
   import package_66.class_2126;
   import package_75.class_2227;
   import package_78.class_2237;
   import package_8.class_1755;
   import package_8.class_1953;
   import package_8.class_2234;
   import package_9.class_2026;
   import package_9.class_2224;
   import package_9.class_2239;
   
   public class SessionDataManager extends class_17 implements ISessionDataManager
   {
      
      public static const const_38:uint = 1;
      
      private var _communication:class_57;
      
      private var _windowManager:class_38;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _notifications:class_536;
      
      private var var_1192:PerkManager;
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var _realName:String;
      
      private var var_4065:int = 0;
      
      private var var_868:int = 0;
      
      private var var_2340:int = 0;
      
      private var var_4717:int = 0;
      
      private var var_1113:int = 0;
      
      private var var_1858:Boolean = true;
      
      private var var_3461:Vector.<int>;
      
      private var var_1153:Vector.<int>;
      
      private var _systemOpen:Boolean;
      
      private var var_5049:Boolean;
      
      private var var_375:Dictionary;
      
      private var var_657:ProductDataParser;
      
      private var _floorItems:class_55;
      
      private var _wallItems:class_55;
      
      private var var_1036:class_55;
      
      private var var_969:class_55;
      
      private var var_1085:FurnitureDataParser;
      
      private var var_343:FurnitureDataParser;
      
      private var var_739:BadgeImageManager;
      
      private var var_4403:HabboGroupInfoManager;
      
      private var var_2485:IgnoredUsersManager;
      
      private var var_1076:BlockedUsersManager;
      
      private var _localization:class_27;
      
      private var var_2724:Boolean = false;
      
      private var _productDataListeners:Array;
      
      private var _furniDataListeners:Array;
      
      private var var_2971:int;
      
      private var var_3788:int;
      
      private var var_3734:int = 0;
      
      private var var_3371:int = -1;
      
      private var _isAmbassador:Boolean;
      
      private var var_4995:Boolean;
      
      private var var_3233:Boolean;
      
      private var var_685:int;
      
      private var var_2835:Boolean = false;
      
      private var _mysteryBoxColor:String;
      
      private var _mysteryKeyColor:String;
      
      private var var_4982:Boolean = false;
      
      private var var_2544:Boolean = false;
      
      private var _newFurniDataHash:String = null;
      
      public function SessionDataManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         },(flags & 1) == 0),new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         },false)]);
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var_375 = new Dictionary();
         _floorItems = new class_55();
         _wallItems = new class_55();
         var_1036 = new class_55();
         var_969 = new class_55();
         initFurnitureData();
         initProductData();
         initBadgeImageManager();
      }
      
      override protected function initComponent() : void
      {
         if(_communication)
         {
            _communication.addHabboConnectionMessageEvent(new class_1743(onNoobnessLevelEvent));
            _communication.addHabboConnectionMessageEvent(new class_1999(onEmailStatus));
            _communication.addHabboConnectionMessageEvent(new class_2169(onRoomReady) as IMessageEvent);
            _communication.addHabboConnectionMessageEvent(new class_1795(onFigureUpdate));
            _communication.addHabboConnectionMessageEvent(new class_1849(onNftChatStyles));
            _communication.addHabboConnectionMessageEvent(new class_1973(onPurchasableChatStyleChanged));
            _communication.addHabboConnectionMessageEvent(new class_1884(onUserChange));
            _communication.addHabboConnectionMessageEvent(new class_2005(onUserObject));
            _communication.addHabboConnectionMessageEvent(new class_1874(onPurchasableChatStyles));
            _communication.addHabboConnectionMessageEvent(new class_1886(onChangeUserNameResult));
            _communication.addHabboConnectionMessageEvent(new class_1757(onUserRights));
            _communication.addHabboConnectionMessageEvent(new class_1809(onAccountPreferences));
            _communication.addHabboConnectionMessageEvent(new class_1804(onUserNameChange));
            _communication.addHabboConnectionMessageEvent(new class_2193(onInClientLink));
            _communication.addHabboConnectionMessageEvent(new class_2031(onMysteryBoxKeys));
            _communication.addHabboConnectionMessageEvent(new class_1790(onAvailabilityStatus));
            _communication.addHabboConnectionMessageEvent(new class_1808(onAccountSafetyLockStatusChanged));
            _communication.addHabboConnectionMessageEvent(new class_1865(onPetRespectFailed));
         }
         var_4403 = new HabboGroupInfoManager(this);
         var_2485 = new IgnoredUsersManager(this);
         var_1076 = new BlockedUsersManager(this);
         var_1192 = new PerkManager(this);
         _productDataListeners = [];
         _furniDataListeners = [];
         if(_communication)
         {
            initSessionData();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_floorItems)
         {
            _floorItems.dispose();
            _floorItems = null;
         }
         if(var_1036)
         {
            var_1036.dispose();
            var_1036 = null;
         }
         if(var_969)
         {
            var_969.dispose();
            var_969 = null;
         }
         if(var_1076)
         {
            var_1076.dispose();
            var_1076 = null;
         }
         if(var_1192)
         {
            var_1192.dispose();
            var_1192 = null;
         }
         _furniDataListeners = null;
         if(var_1085)
         {
            var_1085.dispose();
            var_1085 = null;
         }
         if(var_343)
         {
            var_343.removeEventListener("FDP_furniture_data_ready",onFurnitureReady);
            var_343.dispose();
            var_343 = null;
         }
         if(var_657)
         {
            var_657.removeEventListener("PDP_product_data_ready",onProductsReady);
            var_657.dispose();
            var_657 = null;
         }
         super.dispose();
      }
      
      private function initSessionData() : void
      {
         var_2485.initIgnoreList();
         var_1076.initBlockList();
         send(new class_2224());
         send(new class_2237());
         getIncomeRewardStatus();
      }
      
      private function initBadgeImageManager() : void
      {
         if(var_739 != null)
         {
            return;
         }
         var_739 = new BadgeImageManager(assets,events,this);
      }
      
      private function initFurnitureData(param1:Boolean = true) : void
      {
         if(var_343)
         {
            var_343.dispose();
            var_343 = null;
         }
         var_343 = new FurnitureDataParser(_floorItems,_wallItems,var_1036,var_969,_localization,param1);
         var_343.addEventListener("FDP_furniture_data_ready",onFurnitureReady);
         if(propertyExists("furnidata.load.url"))
         {
            var _loc3_:String = getProperty("furnidata.load.url");
            if(_newFurniDataHash != null)
            {
               var _loc4_:int = int(null.lastIndexOf("/"));
               var _loc2_:String = null.substring(0,0);
               var_343.loadData(null + "/" + _newFurniDataHash);
            }
            else
            {
               var_343.loadData(null);
            }
         }
      }
      
      private function initProductData() : void
      {
         if(var_657)
         {
            var_657.dispose();
            var_657 = null;
         }
         var _loc1_:String = getProperty("productdata.load.url");
         var_657 = new ProductDataParser(_loc1_,var_375);
         var_657.addEventListener("PDP_product_data_ready",onProductsReady);
      }
      
      private function onFurnitureReady(param1:Event = null) : void
      {
         var_343.removeEventListener("FDP_furniture_data_ready",onFurnitureReady);
         if(var_1085)
         {
            var_1085.dispose();
            var_1085 = null;
         }
         var_1085 = var_343;
         var_343 = null;
         var_4982 = true;
         if(!var_2544)
         {
            var_2544 = true;
            for each(var _loc2_ in _furniDataListeners)
            {
               _loc2_.furniDataReady();
            }
         }
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:class_1757 = class_1757(param1);
         var_2971 = _loc2_.clubLevel != 0 ? 2 : 0;
         var_3788 = _loc2_.securityLevel;
         var_3734 = Math.max(var_3734,_loc2_.securityLevel);
         _isAmbassador = _loc2_.isAmbassador;
      }
      
      private function onNoobnessLevelEvent(param1:class_1743) : void
      {
         var_3371 = param1.noobnessLevel;
         if(var_3371 != 0)
         {
            context.configuration.setProperty("new.identity","1");
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_2005 = param1 as class_2005;
         var _loc3_:class_1913 = _loc2_.getParser();
         var_197 = _loc3_.id;
         _name = _loc3_.name;
         var_4065 = _loc3_.respectTotal;
         var_868 = _loc3_.respectLeft;
         var_2340 = _loc3_.respectReplenishesLeft;
         var_4717 = _loc3_.maxRespectPerDay;
         var_1113 = _loc3_.petRespectLeft;
         var_975 = _loc3_.figure;
         var_111 = _loc3_.sex;
         _realName = _loc3_.realName;
         var_1858 = _loc3_.nameChangeAllowed;
         var_2835 = _loc3_.accountSafetyLocked;
         try
         {
            if(context.displayObjectContainer && propertyExists("environment.id"))
            {
               var _loc4_:String = getProperty("environment.id");
               _loc4_ = _loc4_.replace("pt","br");
               _loc4_ = _loc4_.replace("en","com");
               context.displayObjectContainer.stage.nativeWindow.title = "Habbo " + null.toUpperCase() + " | " + _name;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_1884 = param1 as class_1884;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            var_975 = _loc2_.figure;
            var_111 = _loc2_.sex;
         }
      }
      
      private function onFigureUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:class_1795 = param1 as class_1795;
         if(_loc2_ == null)
         {
            return;
         }
         var_975 = _loc2_.figure;
         var_111 = _loc2_.gender;
         HabboWebTools.updateFigure(var_975);
      }
      
      private function onNftChatStyles(param1:IMessageEvent) : void
      {
         var _loc2_:class_1849 = param1 as class_1849;
         if(_loc2_ == null)
         {
            return;
         }
         var_3461 = _loc2_.getParser().chatStyleIds;
      }
      
      private function onPurchasableChatStyles(param1:IMessageEvent) : void
      {
         var _loc2_:class_1874 = param1 as class_1874;
         if(_loc2_ == null)
         {
            return;
         }
         var_1153 = _loc2_.getParser().chatStyleIds;
      }
      
      private function onPurchasableChatStyleChanged(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:class_1973 = param1 as class_1973;
         if(_loc2_ == null)
         {
            return;
         }
         if(var_1153 == null)
         {
            var_1153 = new Vector.<int>();
         }
         var _loc3_:int = _loc2_.getParser().styleId;
         if(_loc2_.getParser().added)
         {
            var_1153.push(_loc3_);
         }
         else
         {
            _loc4_ = int(var_1153.indexOf(_loc3_));
            if(_loc4_ != -1)
            {
               var_1153.removeAt(_loc4_);
            }
         }
         events.dispatchEvent(new SessionDataToWidgetEvent("SDTWE_PURCHASABLE_STYLES_UPDATED"));
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_1804 = param1 as class_1804;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:class_1953 = _loc2_.getParser();
         if(_loc3_.webId == var_197)
         {
            _name = _loc3_.newName;
            var_1858 = false;
            events.dispatchEvent(new UserNameUpdateEvent(_name));
         }
      }
      
      private function onChangeUserNameResult(param1:class_1886) : void
      {
         var _loc3_:String = null;
         var _loc2_:class_1789 = param1.getParser();
         if(_loc2_.resultCode == class_1886.var_1851)
         {
            try
            {
               if(context.displayObjectContainer && propertyExists("environment.id"))
               {
                  _loc3_ = getProperty("environment.id");
                  _loc3_ = _loc3_.replace("pt","br");
                  _loc3_ = _loc3_.replace("en","com");
                  context.displayObjectContainer.stage.nativeWindow.title = "Habbo " + _loc3_.toUpperCase() + " | " + _loc2_.name;
               }
            }
            catch(e:Error)
            {
            }
            var_1858 = false;
            events.dispatchEvent(new UserNameUpdateEvent(_loc2_.name));
         }
      }
      
      private function onMysteryBoxKeys(param1:class_2031) : void
      {
         var _loc2_:class_2114 = param1.getParser();
         _mysteryBoxColor = _loc2_.boxColor;
         _mysteryKeyColor = _loc2_.keyColor;
         events.dispatchEvent(new MysteryBoxKeysUpdateEvent(_mysteryBoxColor,_mysteryKeyColor));
      }
      
      private function onInClientLink(param1:class_2193) : void
      {
         context.createLinkEvent(param1.link);
      }
      
      private function onAccountPreferences(param1:class_1809) : void
      {
         var _loc2_:class_2063 = param1.getParser() as class_2063;
         var_3233 = _loc2_.roomCameraFollowDisabled;
         var_685 = _loc2_.uiFlags;
         events.dispatchEvent(new SessionDataPreferencesEvent(var_685));
      }
      
      private function onEmailStatus(param1:class_1999) : void
      {
         var _loc2_:class_1755 = param1.getParser() as class_1755;
         var_4995 = _loc2_.isVerified;
      }
      
      private function onAvailabilityStatus(param1:IMessageEvent) : void
      {
         var _loc2_:class_2227 = (param1 as class_1790).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         _systemOpen = _loc2_.isOpen;
         var_5049 = _loc2_.onShutDown;
         if(var_4982 && !var_2544)
         {
            var_2544 = true;
            for each(var _loc3_ in _furniDataListeners)
            {
               _loc3_.furniDataReady();
            }
         }
      }
      
      private function onPetRespectFailed(param1:class_1865) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1113 = var_1113 + 1;
      }
      
      private function onAccountSafetyLockStatusChanged(param1:class_1808) : void
      {
         var _loc2_:class_2234 = param1.getParser();
         var_2835 = _loc2_.status == 0;
      }
      
      public function get systemOpen() : Boolean
      {
         return _systemOpen;
      }
      
      public function get systemShutDown() : Boolean
      {
         return var_5049;
      }
      
      public function hasSecurity(param1:int) : Boolean
      {
         return var_3788 >= param1;
      }
      
      public function get topSecurityLevel() : int
      {
         return var_3734;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get hasVip() : Boolean
      {
         return HabboClubLevelEnum.HasVip(var_2971);
      }
      
      public function get hasClub() : Boolean
      {
         return HabboClubLevelEnum.HasClub(var_2971);
      }
      
      public function get isNoob() : Boolean
      {
         return var_3371 != 0;
      }
      
      public function get isRealNoob() : Boolean
      {
         return var_3371 == 2;
      }
      
      public function get userId() : int
      {
         return var_197;
      }
      
      public function get userName() : String
      {
         return _name;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_3788 >= 5;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function get isEmailVerified() : Boolean
      {
         return var_4995;
      }
      
      public function setRoomCameraFollowDisabled(param1:Boolean) : void
      {
         var_3233 = param1;
      }
      
      public function get isRoomCameraFollowDisabled() : Boolean
      {
         return var_3233;
      }
      
      public function setFriendBarState(param1:Boolean) : void
      {
         setUIFlag(1,param1);
      }
      
      public function setRoomToolsState(param1:Boolean) : void
      {
         setUIFlag(2,param1);
      }
      
      public function get uiFlags() : int
      {
         return var_685;
      }
      
      private function setUIFlag(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            if(var_685 & param1)
            {
               return;
            }
            var_685 |= param1;
         }
         else
         {
            if(!(var_685 & param1))
            {
               return;
            }
            var_685 &= ~param1;
         }
         _communication.connection.send(new class_1944(var_685));
      }
      
      public function getBadgeImage(param1:String) : BitmapData
      {
         return var_739.getBadgeImage(param1);
      }
      
      public function getBadgeSmallImage(param1:String) : BitmapData
      {
         return var_739.getSmallBadgeImage(param1);
      }
      
      public function getBadgeImageAssetName(param1:String) : String
      {
         return var_739.getBadgeImageAssetName(param1);
      }
      
      public function getBadgeImageSmallAssetName(param1:String) : String
      {
         return var_739.getSmallScaleBadgeAssetName(param1);
      }
      
      public function requestBadgeImage(param1:String) : BitmapData
      {
         return var_739.getBadgeImage(param1,"normal_badge",false);
      }
      
      public function getBadgeImageWithInfo(param1:String) : BadgeInfo
      {
         return var_739.getBadgeImageWithInfo(param1);
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      public function getGroupBadgeId(param1:int) : String
      {
         return var_4403.getBadgeId(param1);
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getGroupBadgeImage(param1:String) : BitmapData
      {
         return var_739.getBadgeImage(param1,"group_badge");
      }
      
      public function getGroupBadgeSmallImage(param1:String) : BitmapData
      {
         return var_739.getSmallBadgeImage(param1,"group_badge");
      }
      
      public function getGroupBadgeAssetName(param1:String) : String
      {
         return var_739.getBadgeImageAssetName(param1,"group_badge");
      }
      
      public function getGroupBadgeSmallAssetName(param1:String) : String
      {
         return var_739.getSmallScaleBadgeAssetName(param1,"group_badge");
      }
      
      public function isAccountSafetyLocked() : Boolean
      {
         return var_2835;
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function isIgnored(param1:int) : Boolean
      {
         return var_2485.isIgnored(param1);
      }
      
      public function ignoreUser(param1:int) : void
      {
         var_2485.ignoreUser(param1);
      }
      
      public function unignoreUser(param1:int) : void
      {
         var_2485.unignoreUser(param1);
      }
      
      public function isBlocked(param1:int) : Boolean
      {
         return var_1076.isBlocked(param1);
      }
      
      public function blockUser(param1:int) : void
      {
         var_1076.blockUser(param1);
      }
      
      public function unblockUser(param1:int) : void
      {
         var_1076.unblockUser(param1);
      }
      
      public function get respectLeft() : int
      {
         return var_868;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return var_2340;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1113;
      }
      
      public function giveRespect(param1:int) : void
      {
         if(param1 >= 0 && var_868 > 0)
         {
            send(new class_2026(param1));
            var_868 -= 1;
         }
      }
      
      public function replenishRespect() : void
      {
         send(new class_2239());
         var_2340 -= 1;
         var_868 = var_4717;
      }
      
      public function giveRespectFailed() : void
      {
         var_868 += 1;
      }
      
      public function getCreditVaultStatus() : void
      {
         send(new class_1787());
      }
      
      public function getIncomeRewardStatus() : void
      {
         send(new class_2094());
      }
      
      public function withdrawCreditVault() : void
      {
         send(new class_2089());
      }
      
      public function claimReward(param1:int) : void
      {
         send(new class_2206(param1));
      }
      
      public function givePetRespect(param1:int) : void
      {
         if(param1 >= 0 && var_1113 > 0)
         {
            send(new class_2126(param1));
            var_1113 -= 1;
         }
      }
      
      public function getProductData(param1:String) : class_1949
      {
         if(!var_2724)
         {
            loadProductData();
         }
         return var_375[param1];
      }
      
      public function getFloorItemData(param1:int) : class_1800
      {
         if(_floorItems == null)
         {
            return null;
         }
         return _floorItems.getValue(param1.toString());
      }
      
      public function getFloorItemsDataByCategory(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(_floorItems != null)
         {
            for each(var _loc3_ in _floorItems)
            {
               if(_loc3_.category == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getWallItemData(param1:int) : class_1800
      {
         if(_wallItems == null)
         {
            return null;
         }
         return _wallItems.getValue(param1.toString());
      }
      
      public function getFloorItemDataByName(param1:String, param2:int = 0) : class_1800
      {
         var _loc3_:int = 0;
         if(var_1036 == null)
         {
            return null;
         }
         var _loc4_:Array = var_1036.getValue(param1);
         if(_loc4_ != null && param2 <= _loc4_.length - 1)
         {
            _loc3_ = int(_loc4_[param2]);
            return getFloorItemData(_loc3_);
         }
         return null;
      }
      
      public function getWallItemDataByName(param1:String, param2:int = 0) : class_1800
      {
         var _loc3_:int = 0;
         if(var_969 == null)
         {
            return null;
         }
         var _loc4_:Array = var_969.getValue(param1);
         if(_loc4_ != null && param2 <= _loc4_.length - 1)
         {
            _loc3_ = int(_loc4_[param2]);
            return getWallItemData(_loc3_);
         }
         return null;
      }
      
      public function openHabboHomePage(param1:int, param2:String) : void
      {
         var _loc3_:String = null;
         if(propertyExists("link.format.userpage"))
         {
            _loc3_ = getProperty("link.format.userpage");
            _loc3_ = _loc3_.replace("%ID%",String(param1));
            _loc3_ = _loc3_.replace("%username%",param2);
            try
            {
               HabboWebTools.navigateToURL(_loc3_,"habboMain");
            }
            catch(e:Error)
            {
               class_21.log("Error occurred!");
            }
         }
      }
      
      public function pickAllFurniture(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all}",0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":pickall");
               }
            });
         }
      }
      
      public function resetScores(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.resetscores}",0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":resetscores");
               }
            });
         }
      }
      
      public function ejectAllFurniture(param1:int, param2:String) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         var message:String = param2;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.eject_all}",0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(message);
               }
            });
         }
      }
      
      public function ejectPets(param1:int) : void
      {
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         var _loc2_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isRoomOwner || isAnyRoomController)
         {
            sendSpecialCommandMessage(":ejectpets");
         }
      }
      
      public function pickAllBuilderFurniture(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all_bc}",0,function(param1:class_2001, param2:class_1758):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":pickallbc");
               }
            });
         }
      }
      
      public function loadProductData(param1:class_59 = null) : Boolean
      {
         if(var_2724)
         {
            return true;
         }
         if(param1 && _productDataListeners.indexOf(param1) == -1)
         {
            _productDataListeners.push(param1);
         }
         return false;
      }
      
      public function addProductsReadyEventListener(param1:class_59) : void
      {
         if(var_2724)
         {
            param1.productDataReady();
            return;
         }
         if(param1 && _productDataListeners.indexOf(param1) == -1)
         {
            _productDataListeners.push(param1);
         }
      }
      
      private function onProductsReady(param1:Event) : void
      {
         var_657.removeEventListener("PDP_product_data_ready",onProductsReady);
         var_2724 = true;
         for each(var _loc2_ in _productDataListeners)
         {
            if(_loc2_ != null && !_loc2_.disposed)
            {
               _loc2_.productDataReady();
            }
         }
         _productDataListeners = [];
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc3_:class_2169 = param1 as class_2169;
         if(_loc3_ == null || _loc3_.getParser() == null || param1.connection == null)
         {
            return;
         }
         var _loc2_:class_1854 = _loc3_.getParser();
         HabboWebTools.roomVisited(_loc2_.roomId);
      }
      
      public function sendSpecialCommandMessage(param1:String) : void
      {
         send(new class_2064(param1));
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function set newFurniDataHash(param1:String) : void
      {
         _newFurniDataHash = param1;
      }
      
      public function refreshFurniData() : void
      {
         _floorItems = new class_55();
         _wallItems = new class_55();
         var_1036 = new class_55();
         var_969 = new class_55();
         initFurnitureData(false);
      }
      
      public function removeFurniDataListener(param1:class_60) : void
      {
         if(!_furniDataListeners)
         {
            return;
         }
         var _loc2_:int = int(_furniDataListeners.indexOf(param1));
         if(_loc2_ > -1)
         {
            _furniDataListeners.splice(_loc2_,1);
         }
      }
      
      public function getFurniData(param1:class_60) : Vector.<class_1800>
      {
         if(_floorItems == null || _floorItems.length == 0)
         {
            if(_furniDataListeners.indexOf(param1) == -1)
            {
               _furniDataListeners.push(param1);
            }
            return null;
         }
         return Vector.<class_1800>(_floorItems.getValues().concat(_wallItems.getValues()));
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
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get nameChangeAllowed() : Boolean
      {
         return var_1858;
      }
      
      public function get perksReady() : Boolean
      {
         return var_1192 != null && var_1192.isReady;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return var_1192.isPerkAllowed(param1);
      }
      
      public function getPerkErrorMessage(param1:String) : String
      {
         return var_1192.getPerkErrorMessage(param1);
      }
      
      public function get currentTalentTrack() : String
      {
         return getBoolean("talent.track.citizenship.enabled") && !isPerkAllowed("CITIZEN") ? "citizenship" : "helper";
      }
      
      public function get mysteryBoxColor() : String
      {
         return _mysteryBoxColor;
      }
      
      public function get mysteryKeyColor() : String
      {
         return _mysteryKeyColor;
      }
      
      public function hasNftChatStyle(param1:int) : Boolean
      {
         return var_3461 != null && var_3461.indexOf(param1) != -1;
      }
      
      public function hasPurchasableChatStyle(param1:int) : Boolean
      {
         return var_1153 != null && var_1153.indexOf(param1) != -1;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
   }
}

