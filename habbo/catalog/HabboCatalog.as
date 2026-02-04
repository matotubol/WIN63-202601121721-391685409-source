package com.sulake.habbo.catalog
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.club.ClubExtendController;
   import com.sulake.habbo.catalog.club.ClubGiftController;
   import com.sulake.habbo.catalog.clubcenter.HabboClubCenter;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.class_2113;
   import com.sulake.habbo.catalog.collectibles.tabs.MintTokenPurchaseOffer;
   import com.sulake.habbo.catalog.collectibles.tabs.NftStorePurchaseOffer;
   import com.sulake.habbo.catalog.earnings.EarningsController;
   import com.sulake.habbo.catalog.earnings.class_1839;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.event.CatalogUserEvent;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceLogic;
   import com.sulake.habbo.catalog.marketplace.class_2042;
   import com.sulake.habbo.catalog.navigation.CatalogNavigator;
   import com.sulake.habbo.catalog.navigation.RequestedPage;
   import com.sulake.habbo.catalog.navigation.class_1737;
   import com.sulake.habbo.catalog.navigation.class_1917;
   import com.sulake.habbo.catalog.navigation.events.CatalogFurniPurchaseEvent;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.offers.OfferCenter;
   import com.sulake.habbo.catalog.purchase.GiftWrappingConfiguration;
   import com.sulake.habbo.catalog.purchase.PlacedObjectPurchaseData;
   import com.sulake.habbo.catalog.purchase.PurchaseConfirmationDialog;
   import com.sulake.habbo.catalog.purchase.RentConfirmationWindow;
   import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
   import com.sulake.habbo.catalog.purse.Purse;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.RecyclerLogic;
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsController;
   import com.sulake.habbo.catalog.targetedoffers.OfferController;
   import com.sulake.habbo.catalog.viewer.CatalogViewer;
   import com.sulake.habbo.catalog.viewer.GameTokensOffer;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.PageLocalization;
   import com.sulake.habbo.catalog.viewer.Product;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_1998;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import com.sulake.habbo.catalog.viewer.class_2050;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1785;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2139;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2174;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.friendbar.events.FriendBarSelectionEvent;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
   import com.sulake.habbo.room.object.data.class_2108;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.furniture.class_60;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_1902;
   import com.sulake.iid.*;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import package_10.SnowWarGameTokensMessageEvent;
   import package_10.class_1760;
   import package_10.class_1766;
   import package_10.class_1776;
   import package_10.class_1803;
   import package_10.class_1826;
   import package_10.class_1838;
   import package_10.class_1844;
   import package_10.class_1858;
   import package_10.class_1863;
   import package_10.class_1933;
   import package_10.class_2030;
   import package_10.class_2053;
   import package_10.class_2062;
   import package_10.class_2082;
   import package_10.class_2099;
   import package_10.class_2101;
   import package_10.class_2103;
   import package_10.class_2104;
   import package_10.class_2110;
   import package_10.class_2135;
   import package_10.class_2138;
   import package_10.class_2167;
   import package_10.class_2204;
   import package_10.class_2215;
   import package_10.class_2219;
   import package_10.class_2232;
   import package_13.GetSnowWarGameTokensOfferComposer;
   import package_13.PurchaseSnowWarGameTokensOfferComposer;
   import package_13.class_1768;
   import package_13.class_1848;
   import package_13.class_1920;
   import package_13.class_1941;
   import package_13.class_1956;
   import package_13.class_1976;
   import package_13.class_1981;
   import package_13.class_1984;
   import package_13.class_1985;
   import package_13.class_2020;
   import package_13.class_2105;
   import package_13.class_2128;
   import package_13.class_2131;
   import package_13.class_2144;
   import package_13.class_2145;
   import package_13.class_2147;
   import package_13.class_2185;
   import package_13.class_2186;
   import package_13.class_2205;
   import package_13.class_2260;
   import package_20.class_1784;
   import package_20.class_2084;
   import package_20.class_2255;
   import package_26.class_1861;
   import package_26.class_1961;
   import package_29.class_1832;
   import package_29.class_1943;
   import package_29.class_2000;
   import package_29.class_2037;
   import package_29.class_2170;
   import package_29.class_2183;
   import package_29.class_2249;
   import package_3.class_2006;
   import package_3.class_2022;
   import package_3.class_2238;
   import package_30.class_1833;
   import package_36.class_1859;
   import package_36.class_2036;
   import package_36.class_2184;
   import package_47.class_1924;
   import package_47.class_2095;
   import package_47.class_2180;
   import package_48.class_1935;
   import package_48.class_2222;
   import package_48.class_2240;
   import package_49.class_1960;
   import package_5.class_1746;
   import package_5.class_2097;
   import package_5.class_2172;
   import package_54.class_2039;
   import package_55.class_2048;
   import package_6.SnowWarGameTokenOffer;
   import package_6.SnowWarGameTokensMessageParser;
   import package_6.class_1749;
   import package_6.class_1754;
   import package_6.class_1871;
   import package_6.class_1919;
   import package_6.class_1940;
   import package_6.class_1951;
   import package_6.class_2013;
   import package_6.class_2021;
   import package_6.class_2024;
   import package_6.class_2120;
   import package_6.class_2216;
   import package_6.class_2236;
   import package_7.class_1751;
   import package_7.class_1906;
   import package_7.class_1922;
   import package_7.class_1926;
   import package_7.class_2106;
   import package_7.class_2223;
   import package_70.class_2176;
   import package_70.class_2209;
   import package_73.class_2208;
   import package_8.class_1982;
   import package_8.class_2014;
   import package_9.class_1869;
   
   public class HabboCatalog extends class_17 implements IHabboCatalog, class_59, class_31, ILinkEventTracker, class_60
   {
      
      public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
      
      public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
      
      public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
      
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const MAX_SEARCH_RESULTS_LENGTH:uint = 200;
      
      private static const NO_KNOWN_OFFER:int = -1;
      
      private static const DEFAULT_VIEW_LOCATION:Point = new Point(100,20);
      
      private static const DEFAULT_VIEW_LOCATION_LARGE:Point = new Point(100,5);
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _toolbar:IHabboToolbar;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_977:IRoomSession;
      
      private var _localization:class_27;
      
      private var _notifications:class_536;
      
      private var _inventory:class_61;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:class_48;
      
      private var _soundManager:class_544;
      
      private var _friendList:class_258;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _avatarEditor:class_141;
      
      private var _questEngine:class_498;
      
      private var _freeFlowChat:class_51;
      
      private var var_2094:VideoOfferManager;
      
      private var var_704:Boolean = false;
      
      private var var_2724:Boolean = false;
      
      private var var_2993:Boolean = false;
      
      private var var_106:CatalogViewer;
      
      private var _catalogNavigators:Dictionary;
      
      private var var_139:Purse;
      
      private var var_188:RecyclerLogic;
      
      private var var_276:IMarketPlace;
      
      private var var_39:class_1812;
      
      private var var_69:PurchaseConfirmationDialog;
      
      private var var_3708:String;
      
      private var var_2442:Boolean;
      
      private var var_4379:Boolean = true;
      
      private var var_2910:Boolean = false;
      
      private var var_4467:GiftWrappingConfiguration;
      
      private var var_2490:ClubGiftController;
      
      private var var_947:ClubBuyController;
      
      private var var_1198:ClubExtendController;
      
      private var var_1462:class_55 = new class_55();
      
      private var var_594:Boolean = false;
      
      private var _offerInFurniPlacing:class_1793;
      
      private var _offerPlacingCallbackReceiver:class_2050;
      
      private var var_148:PlacedObjectPurchaseData;
      
      private var var_2609:Boolean;
      
      private var var_4292:Boolean;
      
      private var var_281:RoomPreviewer;
      
      private var var_854:GuildMembershipsController;
      
      private var var_2593:OfferController;
      
      private var _utils:HabboCatalogUtils;
      
      private var var_2175:Boolean = false;
      
      private var var_970:String = null;
      
      private var var_987:GameTokensOffer;
      
      private var var_1022:GameTokensOffer;
      
      private var var_999:GameTokensOffer;
      
      private var _bundleDiscountRuleset:class_1766 = null;
      
      private var var_632:RequestedPage;
      
      private var var_3589:int;
      
      private var var_425:RoomAdPurchaseData;
      
      private var var_1623:RentConfirmationWindow;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_327:String = "NORMAL";
      
      private var var_587:Vector.<class_1800>;
      
      private var _frontPageItems:Vector.<class_1933>;
      
      private var var_1354:Timer;
      
      private var var_3456:Dictionary;
      
      private var var_4888:Boolean;
      
      private var var_3622:int = -1;
      
      private var var_3671:int;
      
      private var var_4848:int;
      
      private var var_3206:int;
      
      private var var_3712:int;
      
      private var _builderMembershipUpdateTime:int;
      
      private var _builderMembershipDisplayUpdateTime:int;
      
      private var var_3184:Boolean;
      
      private var var_2716:Boolean;
      
      private var _offerCenter:OfferCenter;
      
      private var var_196:CollectiblesController;
      
      private var var_3472:SpecialItemsController;
      
      private var var_3423:EarningsController;
      
      public function HabboCatalog(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_139 = new Purse();
         _utils = new HabboCatalogUtils(this);
         registerUpdateReceiver(this,1);
         var_632 = new RequestedPage();
         param1.attachComponent(new HabboClubCenter(param1,0,param3),[new IIDHabboClubCenter()]);
         var_3423 = new EarningsController(param1,0,param3);
         param1.attachComponent(var_3423,[new IIDVaultController()]);
         var_196 = new CollectiblesController(param1,0,param3);
         param1.attachComponent(var_196,[new IIDCollectiblesController()]);
         var_3472 = new SpecialItemsController(param1,0,param3);
         param1.attachComponent(var_3472,[new IIDSpecialItemsController()]);
      }
      
      public static function setElementImageCentered(param1:class_1741, param2:BitmapData, param3:int = 0) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc8_:int = param3 > 0 ? param3 : param1.height;
         var _loc5_:int = (param1.width - param2.width) / 2;
         var _loc6_:int = (_loc8_ - param2.height) / 2;
         if(param1 as class_2251 != null)
         {
            var _loc7_:class_2251 = class_2251(param1);
            if(_loc7_.bitmap == null || param3 > 0)
            {
               null.bitmap = new BitmapData(param1.width,_loc8_,true,16777215);
            }
            null.bitmap.fillRect(null.bitmap.rect,16777215);
            null.bitmap.copyPixels(param2,param2.rect,new Point(_loc5_,_loc6_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as class_1970 != null)
         {
            var _loc4_:class_1970 = class_1970(param1);
            _loc4_.setDisplayObject(new Bitmap(param2));
            param1.invalidate();
         }
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get giftWrappingConfiguration() : GiftWrappingConfiguration
      {
         return var_4467;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         if(var_281 == null)
         {
            initializeRoomPreviewer();
         }
         return var_281;
      }
      
      public function get navigator() : class_41
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get utils() : HabboCatalogUtils
      {
         return _utils;
      }
      
      public function get questEngine() : class_498
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get videoOffers() : IVideoOfferManager
      {
         return var_2094;
      }
      
      public function get frontPageItems() : Vector.<class_1933>
      {
         return _frontPageItems;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         },false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REOE_PLACED",
            "callback":onObjectPlacedInRoom
         },{
            "type":"REOE_PLACED_ON_USER",
            "callback":onObjectPlaceOnUser
         },{
            "type":"REOE_SELECTED",
            "callback":onObjectSelected
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         },false),new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }]),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboFriendBar(),null,false,[{
            "type":"FBVE_FRIEND_SELECTED",
            "callback":onFriendBarSelectionEvent
         }]),new ComponentDependency(new IIDHabboGroupsManager(),null,false,[{
            "type":"GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",
            "callback":onGuildVisualSettingsChanged
         }]),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_141):void
         {
            _avatarEditor = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_498):void
         {
            _questEngine = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_2022(onGuildMemberships));
         addMessageEvent(new class_2240(onRecyclerPrizes));
         addMessageEvent(new class_2101(onCatalogPublished));
         addMessageEvent(new class_2037(onMarketPlaceOffers));
         addMessageEvent(new class_2036(onNftStorePurchase));
         addMessageEvent(new class_2167(onClubGiftInfo));
         addMessageEvent(new class_2215(onLtdRaffleResult));
         addMessageEvent(new class_2249(onMarketPlaceBuyResult));
         addMessageEvent(new class_1935(onRecyclerFinished));
         addMessageEvent(new class_2103(onBundleDiscountRulesetMessageEvent));
         addMessageEvent(new class_2170(onMarketplaceMakeOfferResult));
         addMessageEvent(new class_1861(onActivityPoints));
         addMessageEvent(new class_2082(onGiftReceiverNotFound));
         addMessageEvent(new class_1960(onCreditBalance));
         addMessageEvent(new class_2204(onPurchaseOK));
         addMessageEvent(new class_1776(onBuildersClubSubscriptionStatus));
         addMessageEvent(new class_1760(onBuildersClubFurniCount));
         addMessageEvent(new SnowWarGameTokensMessageEvent(onSnowWarGameTokenOffer));
         addMessageEvent(new class_1803(onPurchaseError));
         addMessageEvent(new class_1826(onVoucherRedeemOk));
         addMessageEvent(new class_2135(onPurchaseNotAllowed));
         addMessageEvent(new class_1858(onLimitedEditionSoldOut));
         addMessageEvent(new class_2232(onCatalogPage));
         addMessageEvent(new class_1859(onEmeraldBalance));
         addMessageEvent(new class_2039(onRoomExit));
         addMessageEvent(new class_1844(onCatalogIndex));
         addMessageEvent(new class_2219(onLtdRaffleEntered));
         addMessageEvent(new class_2000(onMarketPlaceOwnOffers));
         addMessageEvent(new class_1961(onActivityPointNotification));
         addMessageEvent(new class_2030(onHabboClubOffers));
         addMessageEvent(new class_1838(onSellablePalettes));
         addMessageEvent(new class_2006(onApproveNameResult));
         addMessageEvent(new class_2238(onSubscriptionInfo));
         addMessageEvent(new class_2062(onVoucherRedeemError));
         addMessageEvent(new class_2184(onSilverBalance));
         addMessageEvent(new class_2222(onRecyclerStatus));
         addMessageEvent(new class_1863(onGiftWrappingConfiguration));
         addMessageEvent(new class_2110(onProductOffer));
         addMessageEvent(new class_1943(onMarketplaceItemStats));
         addMessageEvent(new class_2183(onMarketPlaceCancelResult));
         addMessageEvent(new class_1832(onMarketplaceConfiguration));
         addMessageEvent(new class_2099(onHabboClubExtendOffer));
         addMessageEvent(new class_2053(onNotEnoughBalance));
         context.addLinkEventTracker(this);
         _sessionDataManager.loadProductData(this);
         var_4292 = isNewItemsNotificationEnabled();
         var_2094 = new VideoOfferManager(this);
         var_2593 = new OfferController(this);
         var_587 = _sessionDataManager.getFurniData(this);
         var_3456 = null;
      }
      
      private function onLtdRaffleResult(param1:class_2215) : void
      {
         if(var_69 != null)
         {
            var_69.ltdRaffleEnded();
            var_69.dispose();
            var_69 = null;
         }
         var _loc2_:class_2021 = param1.getParser() as class_2021;
         var _loc4_:String = "notification.raffle." + (_loc2_.hasWon ? "won" : "lost");
         var _loc3_:String = _localization.getLocalization(_loc4_,_loc4_);
         _notifications.addItem(_loc3_,"ltd");
      }
      
      private function onLtdRaffleEntered(param1:class_2219) : void
      {
         if(var_69 != null)
         {
            var_69.ltdRaffleStarted();
         }
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
         removeUpdateReceiver(this);
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(var_2094)
         {
            var_2094.dispose();
            var_2094 = null;
         }
         if(_offerCenter != null)
         {
            _offerCenter.dispose();
            _offerCenter = null;
         }
         reset(true);
         context.removeLinkEventTracker(this);
         if(var_69 != null)
         {
            var_69.dispose();
            var_69 = null;
         }
         if(var_188 != null)
         {
            var_188.dispose();
            var_188 = null;
         }
         var_139 = null;
         var_276 = null;
         if(var_947 != null)
         {
            var_947.dispose();
            var_947 = null;
         }
         if(var_1198 != null)
         {
            var_1198.dispose();
            var_1198 = null;
         }
         if(var_1462 != null)
         {
            var_1462.dispose();
            var_1462 = null;
         }
         var_977 = null;
         if(var_1623 != null)
         {
            var_1623.dispose();
            var_1623 = null;
         }
         resetPlacedOfferData();
         var_594 = false;
         _offerPlacingCallbackReceiver = null;
         if(var_281 != null)
         {
            var_281.dispose();
            var_281 = null;
         }
         if(var_854 != null)
         {
            var_854.dispose();
            var_854 = null;
         }
         if(_utils != null)
         {
            _utils.dispose();
            _utils = null;
         }
         disposeSnowWarTokens();
         if(var_632)
         {
            var_632 = null;
         }
         if(var_2593)
         {
            var_2593.dispose();
            var_2593 = null;
         }
         super.dispose();
      }
      
      private function disposeSnowWarTokens() : void
      {
         if(var_987 != null)
         {
            var_987.dispose();
            var_987 = null;
         }
         if(var_1022 != null)
         {
            var_1022.dispose();
            var_1022 = null;
         }
         if(var_999 != null)
         {
            var_999.dispose();
            var_999 = null;
         }
      }
      
      private function init() : Boolean
      {
         if(!var_704 && var_2724)
         {
            if(var_2993)
            {
               refreshFurniData();
            }
            createMainWindow();
            createCatalogNavigators();
            createCatalogViewer();
            var_704 = true;
            updatePurse();
            createRecycler();
            createMarketPlace();
            createClubGiftController();
            getGiftWrappingConfiguration();
            createClubBuyController();
            createClubExtendController();
            createGroupMembershipsController();
            initBundleDiscounts();
            events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
            send(new class_1768());
            return true;
         }
         return false;
      }
      
      private function reset(param1:Boolean = false) : void
      {
         var_704 = false;
         if(var_106 != null)
         {
            var_106.dispose();
            var_106 = null;
         }
         if(_catalogNavigators != null)
         {
            for each(var _loc3_ in _catalogNavigators)
            {
               _loc3_.dispose();
            }
            _catalogNavigators = null;
         }
         if(var_39 != null)
         {
            var_39.dispose();
            var_39 = null;
         }
         if(!param1)
         {
            if(_sessionDataManager == null)
            {
               class_23.crash("Could not reload product data after reset() because _sessionDataManager was null",7);
               return;
            }
            var _loc2_:Boolean = _sessionDataManager.loadProductData(this);
            events.dispatchEvent(new CatalogEvent("CATALOG_NOT_READY"));
         }
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(connection == null)
         {
            return;
         }
         connection.send(param1);
      }
      
      public function loadCatalogPage(param1:int, param2:int, param3:String) : void
      {
         isBusy = true;
         var_3589 = param1;
         send(new class_2205(param1,param2,param3));
      }
      
      public function purchaseGameTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && var_987)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_987.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && var_1022)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_1022.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && var_999)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_999.offerId));
         }
      }
      
      public function purchaseMintTokens(param1:int, param2:String) : void
      {
         send(new class_2209(param1,param2));
      }
      
      public function purchaseNftOffer(param1:String, param2:String) : void
      {
         send(new class_2176(param1,param2));
      }
      
      public function purchaseOffer(param1:int, param2:String = "", param3:int = 1) : void
      {
         var _loc5_:class_1737 = getCatalogNavigator("NORMAL");
         if(_loc5_ != null)
         {
            var _loc4_:Vector.<class_1917> = _loc5_.getNodesByOfferId(param1,true);
            if(_loc4_ != null)
            {
               purchaseProduct(undefined[0].pageId,param1,param2,param3);
            }
         }
      }
      
      public function purchaseProduct(param1:int, param2:int, param3:String = "", param4:int = 1) : void
      {
         if(roomAdPurchaseData == null || roomAdPurchaseData.offerId != param2)
         {
            send(new class_2131(param1,param2,param3,param4));
         }
         else
         {
            if(var_425.extended && var_425.expirationTime.getTime() < new Date().getTime())
            {
               var_425.extended = false;
            }
            send(new class_1976(param1,param2,roomAdPurchaseData.flatId,roomAdPurchaseData.name,roomAdPurchaseData.extended,roomAdPurchaseData.description,roomAdPurchaseData.categoryId));
         }
      }
      
      public function purchaseVipMembershipExtension(param1:int) : void
      {
         send(new class_2186(param1));
      }
      
      public function purchaseBasicMembershipExtension(param1:int) : void
      {
         send(new class_2020(param1));
      }
      
      public function purchaseProductAsGift(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:Boolean = false) : void
      {
         send(new class_2185(param1,param2,param3,param4,param5,param6,param7,param8,param9));
      }
      
      public function get roomAdPurchaseData() : RoomAdPurchaseData
      {
         return var_425;
      }
      
      public function set roomAdPurchaseData(param1:RoomAdPurchaseData) : void
      {
         var_425 = param1;
      }
      
      public function approveName(param1:String, param2:int) : void
      {
         send(new class_1869(param1,param2));
      }
      
      public function getRecyclerStatus() : void
      {
         send(new class_1924());
      }
      
      public function getRecyclerPrizes() : void
      {
         send(new class_2180());
      }
      
      public function sendRecycleItems(param1:Array) : void
      {
         send(new class_2095(param1));
      }
      
      public function set giftReceiver(param1:String) : void
      {
         var_3708 = param1;
      }
      
      public function getSeasonalCurrencyActivityPointType() : int
      {
         return getInteger("seasonalcurrencyindicator.currency",1);
      }
      
      public function showPurchaseConfirmation(param1:class_1793, param2:int, param3:String = "", param4:int = 1, param5:IStuffData = null, param6:String = null, param7:Boolean = true, param8:BitmapData = null) : void
      {
         var _loc11_:Array = null;
         var _loc9_:String = null;
         var _loc13_:class_1917 = null;
         if(param2 == -12345678)
         {
            var _loc14_:Vector.<class_1917> = currentCatalogNavigator.getNodesByOfferId(param1.offerId,true);
            if(_loc14_ != null)
            {
               param2 = int(undefined[0].pageId);
            }
         }
         class_21.log("buy: " + [param4,param1.offerId,param3]);
         var _loc12_:int = param1.priceInCredits;
         var _loc15_:int = param1.priceInActivityPoints;
         if(multiplePurchaseEnabled)
         {
            _loc12_ = _utils.calculateBundlePrice(true,param1.priceInCredits,param4);
            _loc15_ = _utils.calculateBundlePrice(true,param1.priceInActivityPoints,param4);
         }
         var _loc10_:* = param1 is GameTokensOffer;
         if(_loc12_ > 0 && _loc12_ > var_139.credits && !_loc10_)
         {
            showNotEnoughCreditsAlert();
            return;
         }
         if(_loc15_ > 0 && _loc15_ > var_139.getActivityPointsForType(param1.activityPointType) && !_loc10_)
         {
            showNotEnoughActivityPointsAlert(param1.activityPointType);
            return;
         }
         if(param1 is Offer || var_2442 || param1 is GameTokensOffer || param1 is MintTokenPurchaseOffer || param1 is NftStorePurchaseOffer)
         {
            if(var_69 == null || var_69.disposed)
            {
               var_69 = new PurchaseConfirmationDialog(_localization,assets);
            }
            _loc11_ = [];
            if(_friendList != null)
            {
               _loc11_ = _friendList.getFriendNames();
            }
            _loc9_ = param6;
            if(_loc9_ == null)
            {
               if(var_3708 != null)
               {
                  _loc9_ = var_3708;
               }
            }
            var_69.showOffer(this,_roomEngine,param1,param2,param3,param4,param5,_loc11_,_loc9_,param8);
         }
         else if(param1 is ClubBuyOfferData)
         {
            if(param2 == -1)
            {
               _loc13_ = currentCatalogNavigator.getNodeByName("hc_membership");
               if(_loc13_ != null)
               {
                  param2 = _loc13_.pageId;
               }
            }
            if(param2 >= 0)
            {
               var_947.showConfirmation(param1 as ClubBuyOfferData,param2);
            }
         }
         if(var_2442)
         {
            var_2442 = false;
            var_69.turnIntoGifting();
         }
      }
      
      public function purchaseWillBeGift(param1:Boolean) : void
      {
         var_2442 = param1;
      }
      
      private function initializeRoomPreviewer() : void
      {
         if(_roomEngine != null && _roomEngine.isInitialized && getBoolean("catalog.furniture.animation"))
         {
            if(var_281 == null)
            {
               var_281 = new RoomPreviewer(_roomEngine);
               var_281.createRoomForPreviews();
            }
         }
      }
      
      private function isNewItemsNotificationEnabled() : Boolean
      {
         return getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function openCatalog() : void
      {
         cancelFurniInMover();
         toggleCatalog("NORMAL",true);
      }
      
      public function openCatalogPage(param1:String, param2:String = null) : void
      {
         cancelFurniInMover();
         toggleCatalog(param2 == null ? "NORMAL" : param2,true,false);
         if(!var_704 || _catalogNavigators == null || !currentCatalogNavigator.initialized)
         {
            var_632.requestByName = param1;
            return;
         }
         currentCatalogNavigator.openPage(param1);
      }
      
      public function openRoomAdCatalogPageInExtendedMode(param1:String, param2:String, param3:String, param4:String, param5:Date, param6:int) : void
      {
         var _loc8_:int = var_3589;
         var_425 = new RoomAdPurchaseData();
         var_425.name = param2;
         var_425.extended = true;
         var_425.extendedFlatId = _roomEngine.activeRoomId;
         var_425.description = param3;
         var_425.flatId = _roomEngine.activeRoomId;
         var_425.roomName = param4;
         var_425.expirationTime = param5;
         var_425.categoryId = param6;
         openCatalogPage(param1);
         var _loc7_:class_1917 = currentCatalogNavigator.getNodeByName(param1);
         if(_loc7_ != null && _loc7_.pageId == _loc8_)
         {
            getRoomAdsPurchaseInfo();
         }
      }
      
      public function openCatalogPageByOfferId(param1:int, param2:String) : void
      {
         openCatalogPageById(-12345678,param1,param2);
      }
      
      public function openCatalogPageById(param1:int, param2:int, param3:String) : void
      {
         if(var_704 && _catalogNavigators != null && getCatalogNavigator(param3).initialized)
         {
            toggleCatalog(param3,true,false);
            var_106.setForceRefresh();
            currentCatalogNavigator.openPageById(param1,param2);
         }
         else
         {
            toggleCatalog(param3);
            var_632.requestById = param1;
            var_632.requestedOfferId = param2;
         }
      }
      
      public function openInventoryCategory(param1:String) : void
      {
         if(_inventory == null)
         {
            return;
         }
         _inventory.toggleInventoryPage(param1);
      }
      
      public function openCreditsHabblet() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
      }
      
      public function setupInventoryForRecycler(param1:Boolean) : void
      {
         if(_inventory == null)
         {
            return;
         }
         _inventory.setupRecycler(param1);
      }
      
      public function get privateRoomSessionActive() : Boolean
      {
         return var_2910;
      }
      
      public function get tradingActive() : Boolean
      {
         if(_inventory == null)
         {
            return false;
         }
         return _inventory.tradingActive;
      }
      
      public function requestInventoryFurniToRecycler() : int
      {
         if(_inventory == null)
         {
            return 0;
         }
         return _inventory.requestSelectedFurniToRecycler();
      }
      
      public function returnInventoryFurniFromRecycler(param1:int) : Boolean
      {
         if(_inventory == null)
         {
            return false;
         }
         return _inventory.returnInventoryFurniFromRecycler(param1);
      }
      
      public function getProductData(param1:String) : class_1949
      {
         return _sessionDataManager.getProductData(param1);
      }
      
      public function getFurnitureData(param1:int, param2:String) : class_1800
      {
         if(param2 == "s")
         {
            var _loc3_:class_1800 = _sessionDataManager.getFloorItemData(param1);
         }
         if(param2 == "i")
         {
            _loc3_ = _sessionDataManager.getWallItemData(param1);
         }
         return null;
      }
      
      public function getFurnitureDataByName(param1:String, param2:String, param3:int = 0) : class_1800
      {
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            var _loc4_:class_1800 = _sessionDataManager.getFloorItemDataByName(param1);
         }
         if(param2 == "i")
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param1);
         }
         return null;
      }
      
      public function getPurse() : class_1831
      {
         return var_139;
      }
      
      public function getEarnings() : class_1839
      {
         return var_3423;
      }
      
      public function getRecycler() : IRecycler
      {
         return var_188;
      }
      
      public function getMarketPlace() : IMarketPlace
      {
         return var_276;
      }
      
      public function getClubGiftController() : ClubGiftController
      {
         return var_2490;
      }
      
      public function getClubBuyController() : ClubBuyController
      {
         return var_947;
      }
      
      public function getClubExtendController() : ClubExtendController
      {
         return var_1198;
      }
      
      public function getPublicMarketPlaceOffers(param1:int, param2:int, param3:String, param4:int) : void
      {
         send(new class_1751(param1,param2,param3,param4));
      }
      
      public function getRoomAdsPurchaseInfo() : void
      {
         send(new class_1920());
      }
      
      public function sendRoomAdPurchaseInitiatedEvent() : void
      {
         send(new class_2105());
      }
      
      public function getOwnMarketPlaceOffers() : void
      {
         send(new class_1926());
      }
      
      public function buyMarketPlaceOffer(param1:int) : void
      {
         send(new class_2106(param1));
      }
      
      public function redeemSoldMarketPlaceOffers() : void
      {
         send(new class_2223());
      }
      
      public function redeemExpiredMarketPlaceOffer(param1:int) : void
      {
         send(new class_1906(param1));
      }
      
      public function getMarketplaceItemStats(param1:int, param2:int) : void
      {
         if(!_communication)
         {
            return;
         }
         send(new class_1922(param1,param2));
      }
      
      public function getGroupMembershipsController() : GuildMembershipsController
      {
         return var_854;
      }
      
      public function getPixelEffectIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = (_inventory as class_17).assets.getAssetByName("fx_icon_" + param1 + "_png") as BitmapDataAsset;
         if(_loc2_ != null && _loc2_.content != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSubscriptionProductIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = assets.getAssetByName("icon_hc") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getMintTokenProductIcon() : BitmapData
      {
         var _loc1_:BitmapDataAsset = assets.getAssetByName("minting_token_large") as BitmapDataAsset;
         if(_loc1_ != null)
         {
            return (_loc1_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSellablePetPalettes(param1:String) : Array
      {
         var _loc2_:Array = var_1462.getValue(param1);
         if(_loc2_ != null)
         {
            return _loc2_.slice();
         }
         send(new class_1956(param1));
         return null;
      }
      
      private function updatePurse() : void
      {
         var _loc4_:String = null;
         if(var_39 == null)
         {
            return;
         }
         _localization.registerParameter("catalog.purse.creditbalance","balance",String(var_139.credits));
         _localization.registerParameter("catalog.purse.pixelbalance","balance",String(var_139.getActivityPointsForType(0)));
         var _loc3_:uint = 11;
         if(!var_139.hasClubLeft)
         {
            _loc4_ = "catalog.purse.club.join";
         }
         else
         {
            if(var_139.isVIP)
            {
               _loc4_ = "catalog.purse.vipdays";
               _loc3_ = 12;
            }
            else
            {
               _loc4_ = "catalog.purse.clubdays";
            }
            _localization.registerParameter(_loc4_,"days",String(var_139.clubDays));
            _localization.registerParameter(_loc4_,"months",String(var_139.clubPeriods));
         }
         var _loc2_:IIconWindow = var_39.findChildByName("clubIcon") as IIconWindow;
         if(_loc2_)
         {
            _loc2_.style = _loc3_;
         }
         var _loc1_:ITextWindow = var_39.findChildByName("clubText") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.caption = _localization.getLocalization(_loc4_);
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != "HTE_TOOLBAR_CLICK")
         {
            return;
         }
         switch(param1.iconId)
         {
            case "HTIE_ICON_CATALOGUE":
               toggleCatalog("NORMAL");
               break;
            case "HTIE_ICON_BUILDER":
               toggleCatalog("BUILDERS_CLUB");
         }
      }
      
      private function setElementColour(param1:String, param2:int) : void
      {
         if(var_39 == null)
         {
            return;
         }
         var _loc3_:class_1741 = var_39.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.color = param2;
         }
      }
      
      public function get buildersClubEnabled() : Boolean
      {
         return getBoolean("builders.club.enabled");
      }
      
      public function toggleCatalog(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         if(!_sessionDataManager.hasSecurity(5) && !buildersClubEnabled)
         {
            param1 = "NORMAL";
         }
         var _loc5_:* = param1 != var_327;
         var_327 = param1;
         cancelFurniInMover();
         if(var_39 == null)
         {
            if(init() == false)
            {
               return;
            }
         }
         if(currentCatalogNavigator == null || !currentCatalogNavigator.initialized)
         {
            refreshCatalogIndex(var_327);
         }
         if(!mainWindowVisible() || param2 || _loc5_)
         {
            if(var_2609)
            {
               var_2609 = false;
               events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_HIDE"));
               markNewAdditionPageOpened();
            }
            showMainWindow();
         }
         else if(!WindowToggle.isHiddenByOtherWindows(var_39))
         {
            hideMainWindow();
         }
         if(mainWindowVisible())
         {
            if(var_39 != null)
            {
               var_39.activate();
               var _loc4_:ITextFieldWindow = var_39.findChildByName("search.input") as ITextFieldWindow;
               if(_loc4_)
               {
                  null.focus();
                  null.setSelection(0,null.text.length);
               }
            }
            else
            {
               class_21.log("[Catalog] No main container!");
            }
            HabboTracking.getInstance().trackGoogle("catalogue","open");
         }
         if(var_39 != null)
         {
            var_39.color = param1 == "NORMAL" ? 4296112 : 16758076;
            var_39.caption = param1 == "NORMAL" ? "${catalog.title}" : "${builder.catalog.title}";
            var_39.findChildByName("catalog.header.background.border").color = param1 == "NORMAL" ? 4281819765 : 4283320388;
            var_39.findChildByName("catalog.header.background.body").color = param1 == "NORMAL" ? 4279123794 : 4281149220;
            var_39.findChildByName("catalog.mode.header").visible = param1 == "NORMAL";
            var_39.findChildByName("builder.mode.header").visible = param1 == "BUILDERS_CLUB";
            refreshBuilderStatus();
         }
         if(mainWindowVisible())
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_OPEN"));
            if(var_188 != null && getCurrentLayoutCode() == "recycler")
            {
               var_188.activate();
            }
         }
         else
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_CLOSE"));
            if(var_188 != null && getCurrentLayoutCode() == "recycler")
            {
               var_188.cancel();
            }
         }
         if(var_188 != null)
         {
            setupInventoryForRecycler(var_188.active && mainWindowVisible());
         }
         if(_loc5_ && currentCatalogNavigator != null)
         {
            if(param3)
            {
               currentCatalogNavigator.deactivateCurrentNode();
               currentCatalogNavigator.loadFrontPage();
            }
            currentCatalogNavigator.showIndex();
            if(var_106 != null)
            {
               var_106.setForceRefresh();
            }
         }
      }
      
      private function getCurrentLayoutCode() : String
      {
         if(var_106 == null)
         {
            return "";
         }
         return var_106.getCurrentLayoutCode();
      }
      
      private function refreshCatalogIndex(param1:String) : void
      {
         send(new class_1985(param1));
      }
      
      private function markNewAdditionPageOpened() : void
      {
         send(new class_2144());
      }
      
      private function createCatalogNavigators() : void
      {
         _catalogNavigators = new Dictionary();
         _catalogNavigators["NORMAL"] = new CatalogNavigator(this,var_39,"NORMAL");
         _catalogNavigators["BUILDERS_CLUB"] = new CatalogNavigator(this,var_39,"BUILDERS_CLUB");
         var _loc1_:BitmapDataAsset = assets.getAssetByName("purse_coins_small") as BitmapDataAsset;
         setElementImage("creditsIcon",_loc1_.content as BitmapData);
         var _loc3_:BitmapDataAsset = assets.getAssetByName("purse_pixels_small") as BitmapDataAsset;
         setElementImage("pixelsIcon",_loc3_.content as BitmapData);
         var _loc2_:BitmapDataAsset = assets.getAssetByName("purse_club_small") as BitmapDataAsset;
         setElementImage("clubIcon",_loc2_.content as BitmapData);
      }
      
      private function createCatalogViewer() : void
      {
         var _loc1_:class_1812 = var_39.findChildByName("layoutContainer") as class_1812;
         var_106 = new CatalogViewer(this,_loc1_);
      }
      
      private function createMainWindow() : void
      {
         var _loc4_:String = null;
         if(useNonTabbedCatalog())
         {
            _loc4_ = "catalog_ubuntu";
         }
         else
         {
            _loc4_ = "catalog_ubuntu_with_tabs";
         }
         var _loc5_:XmlAsset = assets.getAssetByName(_loc4_) as XmlAsset;
         var_39 = _windowManager.buildFromXML(_loc5_.content as XML,1) as class_1812;
         var_39.tags.push("habbo_catalog");
         var_39.position = DEFAULT_VIEW_LOCATION_LARGE;
         hideMainWindow();
         var _loc3_:class_1741 = var_39.findChildByName("titlebar_close_button");
         if(_loc3_ == null)
         {
            _loc3_ = var_39.findChildByTag("close");
         }
         if(_loc3_ != null)
         {
            _loc3_.procedure = onWindowClose;
         }
         var _loc1_:ITextFieldWindow = var_39.findChildByName("search.input") as ITextFieldWindow;
         if(_loc1_)
         {
            _loc1_.addEventListener("WKE_KEY_DOWN",onSearchInputEvent);
            _loc1_.addEventListener("WKE_KEY_UP",onSearchInputEvent);
            _loc1_.setSelection(0,_loc1_.text.length);
            _loc1_.focus();
            var _loc2_:class_1741 = var_39.findChildByName("clear_search_button");
         }
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         var _loc2_:class_1741 = null;
         if(var_39)
         {
            var_39.caption = param1 ? "${generic.loading}" : "${catalog.title}";
            _loc2_ = var_39.findChildByName("search_waiting_for_results_mask");
            if(_loc2_)
            {
               _loc2_.visible = param1;
            }
         }
      }
      
      private function onSelectSearch(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc2_)
         {
            _loc2_.setSelection(0,_loc2_.text.length);
            _loc2_.focus();
         }
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         var _loc2_:ITextFieldWindow = var_39.findChildByName("search.input") as ITextFieldWindow;
         _loc2_.caption = "";
         _loc2_.setSelection(0,_loc2_.text.length);
         _loc2_.focus();
         var _loc3_:IStaticBitmapWrapperWindow = var_39.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = "common_small_pen";
         if(var_106.previousPageId > 0)
         {
            currentCatalogNavigator.openPageById(var_106.previousPageId,-1);
         }
         var_39.findChildByName("search.helper").visible = true;
      }
      
      private function onSearchInputEvent(param1:WindowKeyboardEvent) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(var_1354)
            {
               var_1354.stop();
            }
            return;
         }
         if(var_1354 == null)
         {
            var_1354 = new Timer(50,1);
         }
         if(param1.target.caption.length >= 3)
         {
            var_1354.addEventListener("timer",onKeyUpSearchTimer);
            var_1354.start();
         }
         var _loc2_:class_1741 = var_39.findChildByName("search.helper");
         _loc2_.visible = param1.target.caption.length == 0;
         var _loc3_:IStaticBitmapWrapperWindow = var_39.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = param1.target.caption.length > 0 ? "icons_close" : "common_small_pen";
         if(param1.target.caption.length == 0)
         {
            onClearSearch();
         }
         else if(param1.keyCode == 13)
         {
            performSearch(param1.target.caption);
         }
      }
      
      private function onKeyUpSearchTimer(param1:TimerEvent) : void
      {
         var _loc2_:ITextFieldWindow = var_39.findChildByName("search.input") as ITextFieldWindow;
         performSearch(_loc2_.caption);
      }
      
      private function performSearch(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc8_:* = undefined;
         var _loc5_:* = undefined;
         if(var_1354)
         {
            var_1354.stop();
         }
         if(var_587 == null || param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc4_:Vector.<class_1800> = new Vector.<class_1800>(0);
         var _loc7_:String = param1.toLocaleLowerCase().replace(" ","");
         for each(var _loc6_ in var_587)
         {
            if(!(var_327 == "BUILDERS_CLUB" && !_loc6_.availableForBuildersClub))
            {
               if(!(var_327 == "NORMAL" && _loc6_.excludedFromDynamic))
               {
                  _loc3_ = [_loc6_.localizedName,_loc6_.description,_loc6_.className].join(" ");
                  _loc3_ = _loc3_.replace(/ /gi,"");
                  if(var_327 == "BUILDERS_CLUB" && _loc6_.purchaseOfferId == -1 && _loc6_.rentOfferId == -1)
                  {
                     if(_loc6_.furniLine != "" && _loc2_.indexOf(_loc6_.furniLine) < 0)
                     {
                        if(_loc3_.toLocaleLowerCase().indexOf(_loc7_) >= 0)
                        {
                           _loc2_.push(_loc6_.furniLine);
                        }
                     }
                  }
                  else
                  {
                     _loc8_ = currentCatalogNavigator.getNodesByOfferId(_loc6_.purchaseOfferId,true);
                     _loc5_ = currentCatalogNavigator.getNodesByOfferId(_loc6_.rentOfferId,true);
                     if(_loc8_ != null || var_327 == "NORMAL" && _loc5_ != null)
                     {
                        if(_loc3_.toLocaleLowerCase().indexOf(_loc7_) >= 0)
                        {
                           _loc4_.push(_loc6_);
                           if(_loc4_.length >= 200)
                           {
                              break;
                           }
                        }
                     }
                  }
               }
            }
         }
         localization.registerParameter("catalog.search.results","count",_loc4_.length.toString());
         localization.registerParameter("catalog.search.results","needle",param1);
         var_39.findChildByName("catalog.header.title").caption = "${catalog.search.header}";
         currentCatalogNavigator.deactivateCurrentNode();
         var_106.showSearchResults(_loc4_);
         currentCatalogNavigator.filter(_loc7_,_loc2_);
      }
      
      public function furniDataReady() : void
      {
         var_587 = _sessionDataManager.getFurniData(this);
         var_3456 = null;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               var_2910 = param1.session.isPrivateRoom;
               var_977 = param1.session;
               if(var_188 != null)
               {
                  var_188.setRoomSessionActive(true);
               }
               break;
            case "RSE_ENDED":
               var_2910 = false;
               var_977 = null;
               if(var_188 != null)
               {
                  var_188.setRoomSessionActive(false);
               }
         }
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetRoomChangedEvent());
         }
      }
      
      private function createRecycler() : void
      {
         var_188 = new RecyclerLogic(this,_windowManager);
      }
      
      private function createMarketPlace() : void
      {
         if(var_276 == null)
         {
            var_276 = new MarketPlaceLogic(this,_windowManager,_roomEngine);
         }
      }
      
      private function createClubGiftController() : void
      {
         if(var_2490 == null)
         {
            var_2490 = new ClubGiftController(this);
         }
      }
      
      private function createClubBuyController() : void
      {
         if(var_947 == null)
         {
            var_947 = new ClubBuyController(this,connection);
         }
      }
      
      private function createClubExtendController() : void
      {
         if(var_1198 == null)
         {
            var_1198 = new ClubExtendController(this);
         }
      }
      
      private function createGroupMembershipsController() : void
      {
         if(var_854 == null)
         {
            var_854 = new GuildMembershipsController(this);
         }
      }
      
      private function getGiftWrappingConfiguration() : void
      {
         send(new class_2147());
      }
      
      public function getHabboClubOffers(param1:int) : void
      {
         send(new class_2260(param1));
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideMainWindow();
         if(var_106 != null)
         {
            var_106.catalogWindowClosed();
         }
         if(var_188 != null && getCurrentLayoutCode() == "recycler")
         {
            var_188.cancel();
            setupInventoryForRecycler(false);
         }
      }
      
      private function onCatalogIndex(param1:class_1844) : void
      {
         var _loc2_:class_1737 = getCatalogNavigator(param1.catalogType);
         if(_loc2_ == null)
         {
            return;
         }
         var_2609 = param1.newAdditionsAvailable;
         _loc2_.buildCatalogIndex(param1.root);
         if(param1.catalogType == var_327)
         {
            _loc2_.showIndex();
         }
         switch(var_632.requestType)
         {
            case 0:
               if(var_2609 && var_4292 && !newAdditionsPageOpenDisabled && param1.catalogType == "NORMAL")
               {
                  events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_SHOW"));
                  openCatalogPage("new_additions");
                  break;
               }
               _loc2_.loadFrontPage();
               break;
            case 1:
               _loc2_.openPageById(var_632.requestId,var_632.requestedOfferId);
               var_632.resetRequest();
               break;
            case 2:
               _loc2_.openPage(var_632.requestName);
               var_632.resetRequest();
         }
      }
      
      private function onCatalogPage(param1:class_2232) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:class_1949 = null;
         var _loc8_:class_1800 = null;
         var _loc12_:Offer = null;
         var _loc13_:class_1951 = param1.getParser();
         if(_loc13_.catalogType != var_327)
         {
            return;
         }
         var _loc9_:int = _loc13_.pageId;
         var _loc4_:String = _loc13_.layoutCode;
         var _loc5_:Array = _loc13_.localization.images.concat();
         var _loc14_:Array = _loc13_.localization.texts.concat();
         var _loc2_:class_1998 = new PageLocalization(_loc5_,_loc14_);
         var _loc15_:int = _loc13_.offerId;
         var _loc6_:Boolean = _loc13_.acceptSeasonCurrencyAsCredits;
         var _loc3_:Vector.<class_1793> = new Vector.<class_1793>(0);
         for each(var _loc16_ in _loc13_.offers)
         {
            _loc10_ = new Vector.<class_1857>(0);
            _loc11_ = getProductData(_loc16_.localizationId);
            for each(var _loc7_ in _loc16_.products)
            {
               _loc8_ = getFurnitureData(_loc7_.furniClassId,_loc7_.productType);
               _loc10_.push(new Product(_loc7_.productType,_loc7_.furniClassId,_loc7_.extraParam,_loc7_.productCount,_loc11_,_loc8_,this,_loc7_.uniqueLimitedItem,_loc7_.uniqueLimitedItemSeriesSize,_loc7_.uniqueLimitedItemsLeft));
            }
            if(!(_loc10_.length == 0 && !HabboCatalogUtils.buildersClub(_loc16_.localizationId)))
            {
               _loc12_ = new Offer(_loc16_.offerId,_loc16_.localizationId,_loc16_.isRent,_loc16_.priceInCredits,_loc16_.priceInActivityPoints,_loc16_.activityPointType,_loc16_.priceInSilver,_loc16_.giftable,_loc16_.clubLevel,_loc10_,_loc16_.bundlePurchaseAllowed,this);
               if(_loc12_.productContainer != null && isOfferCompatibleWithCurrentMode(_loc12_))
               {
                  _loc3_.push(_loc12_);
               }
               else
               {
                  _loc12_.dispose();
               }
            }
         }
         if(_loc13_.frontPageItems != null && _loc13_.frontPageItems.length > 0)
         {
            _frontPageItems = _loc13_.frontPageItems;
         }
         if(var_106 != null && var_3589 == _loc9_)
         {
            var_106.showCatalogPage(_loc9_,_loc4_,_loc2_,_loc3_,_loc15_,_loc6_);
         }
         isBusy = false;
      }
      
      private function isOfferCompatibleWithCurrentMode(param1:Offer) : Boolean
      {
         return var_327 == "NORMAL" || param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi";
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         var _loc2_:class_2101 = param1 as class_2101;
         if(_loc2_.newFurniDataHash)
         {
            sessionDataManager.newFurniDataHash = _loc2_.newFurniDataHash;
         }
         var_2993 = true;
         var _loc3_:Boolean = mainWindowVisible();
         reset();
         if(_loc3_)
         {
            _windowManager.alert("${catalog.alert.published.title}","${catalog.alert.published.description}",0,alertDialogEventProcessor);
         }
         else if(_notifications)
         {
            var _loc4_:String = localization.getLocalization("catalog.alert.published.description");
            _notifications.addItem(null,"info","if_icon_temp_png");
         }
      }
      
      private function refreshFurniData() : void
      {
         sessionDataManager.refreshFurniData();
         var_2993 = false;
      }
      
      private function onNftStorePurchase(param1:class_2036) : void
      {
         var _loc4_:class_1902 = null;
         var _loc3_:String = null;
         var _loc2_:class_1785 = param1.getParser();
         if(_loc2_.result == class_1785.var_5257)
         {
            _windowManager.alert("${catalog.alert.purchaseerror.title}","${notification.nft.purchase.error}",0,null);
         }
         else
         {
            _loc4_ = var_69.getNftImage();
            _loc3_ = var_196.getProductName(_loc4_.productInfo);
            _notifications.addItem(_localization.getLocalizationWithParams("notifications.text.purchase.ok","","productName",_loc3_),"info","icon_curator_stamp_large_png");
         }
         if(var_69 != null)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      private function onPurchaseError(param1:IMessageEvent) : void
      {
         var _loc3_:class_1803 = param1 as class_1803;
         var _loc2_:class_1940 = _loc3_.getParser();
         var _loc4_:int = _loc2_.errorCode;
         var _loc5_:String = _loc4_ > 0 ? "${catalog.alert.purchaseerror.description." + _loc4_ + "}" : "${catalog.alert.purchaseerror.description}";
         _windowManager.alert("${catalog.alert.purchaseerror.title}",_loc5_,0,alertDialogEventProcessor);
         if(var_69 != null)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      private function onPurchaseNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:class_2135 = param1 as class_2135;
         var _loc3_:class_1919 = _loc2_.getParser();
         var _loc4_:int = _loc3_.errorCode;
         var _loc5_:String = "";
         switch(_loc4_ - 1)
         {
            case 0:
               _loc5_ = "${catalog.alert.purchasenotallowed.hc.description}";
               break;
            default:
               _loc5_ = "${catalog.alert.purchasenotallowed.unknown.description}";
         }
         _windowManager.alert("${catalog.alert.purchasenotallowed.title}",_loc5_,0,alertDialogEventProcessor);
      }
      
      private function onPurchaseOK(param1:IMessageEvent) : void
      {
         var _loc6_:class_2251 = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc5_:String = null;
         var _loc3_:class_2204 = param1 as class_2204;
         var _loc4_:class_2024 = _loc3_.getParser();
         events.dispatchEvent(new CatalogFurniPurchaseEvent(_loc4_.offer.localizationId));
         if(var_69 != null)
         {
            if(!var_594 && !var_69.isGiftPurchase())
            {
               _loc6_ = var_69.getIconWrapper();
               if(_loc6_)
               {
                  _loc2_ = _loc6_.bitmap;
                  if(_loc2_)
                  {
                     _loc7_ = new Point();
                     _loc6_.getGlobalPosition(_loc7_);
                     _loc5_ = "HTIE_ICON_INVENTORY";
                     if(var_69.productType == "e")
                     {
                        _loc5_ = "HTIE_ICON_MEMENU";
                     }
                     _toolbar.createTransitionToIcon(_loc5_,_loc2_.clone(),_loc7_.x,_loc7_.y);
                  }
               }
            }
            var_69.ltdRaffleEnded();
            var_69.dispose();
         }
         var_69 = null;
      }
      
      private function onGiftReceiverNotFound(param1:class_2082) : void
      {
         if(var_69 != null)
         {
            var_69.receiverNotFound();
         }
      }
      
      private function onNotEnoughBalance(param1:IMessageEvent) : void
      {
         var _loc3_:class_2053 = param1 as class_2053;
         var _loc2_:class_1754 = _loc3_.getParser();
         if(_loc2_.notEnoughCredits)
         {
            showNotEnoughCreditsAlert();
         }
         else if(_loc2_.notEnoughActivityPoints)
         {
            showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
         }
         if(var_69 != null)
         {
            var_69.notEnoughCredits();
         }
      }
      
      public function setLeftPaneVisibility(param1:Boolean) : void
      {
         if(!var_39)
         {
            return;
         }
         var _loc2_:class_1741 = var_39.findChildByName("navigationContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = var_39.findChildByName("searchContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function showNotEnoughCreditsAlert() : void
      {
         if(!_windowManager)
         {
            return;
         }
         _windowManager.confirm("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,noCreditsConfirmDialogEventProcessor);
      }
      
      public function showNotEnoughActivityPointsAlert(param1:int) : void
      {
         var _loc2_:String = getActivityPointName(param1);
         var _loc3_:String = localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.title","","currencyname",_loc2_);
         var _loc4_:String = localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.description","","currencyname",_loc2_);
         if(param1 == 0)
         {
            _windowManager.confirm(_loc3_,_loc4_,0,noDucketsConfirmDialogEventProcessor);
         }
         else
         {
            _windowManager.alert(_loc3_,_loc4_,0,alertDialogEventProcessor);
         }
      }
      
      public function getActivityPointName(param1:int) : String
      {
         var _loc2_:String = getProperty("activitypoint.name." + param1);
         return localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function onSilverBalance(param1:class_2184) : void
      {
         var _loc2_:class_2174 = param1.getParser();
         var_139.silverBalance = _loc2_.silverBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_silver_balance",var_139.silverBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onEmeraldBalance(param1:class_1859) : void
      {
         var _loc2_:class_2139 = param1.getParser();
         var_139.emeraldBalance = _loc2_.emeraldBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_emerald_balance",var_139.emeraldBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onVoucherRedeemOk(param1:class_1826) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = "${catalog.alert.voucherredeem.ok.description}";
         if(param1.productName != "")
         {
            _loc2_ = "catalog.alert.voucherredeem.ok.description.furni";
            _localization.registerParameter(_loc2_,"productName",param1.productName);
            _localization.registerParameter(_loc2_,"productDescription",param1.productDescription);
            _loc2_ = "${" + _loc2_ + "}";
         }
         _windowManager.alert("${catalog.alert.voucherredeem.ok.title}",_loc2_,0,alertDialogEventProcessor);
      }
      
      private function onVoucherRedeemError(param1:class_2062) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = "${catalog.alert.voucherredeem.error.description." + param1.errorCode + "}";
         _windowManager.alert("${catalog.alert.voucherredeem.error.title}",_loc3_,0,alertDialogEventProcessor);
      }
      
      private function onApproveNameResult(param1:class_2006) : void
      {
         if(param1 == null || var_106 == null)
         {
            return;
         }
         var _loc2_:class_1982 = param1.getParser();
         var_106.dispatchWidgetEvent(new CatalogWidgetApproveNameResultEvent(_loc2_.result,_loc2_.nameValidationInfo));
      }
      
      private function onCreditBalance(param1:IMessageEvent) : void
      {
         var _loc3_:class_1960 = param1 as class_1960;
         var _loc2_:class_1833 = _loc3_.getParser();
         var_139.credits = _loc2_.balance;
         updatePurse();
         if(!var_4379 && _soundManager != null)
         {
            _soundManager.playSound("HBST_purchase");
         }
         var_4379 = false;
         events.dispatchEvent(new PurseEvent("catalog_purse_credit_balance",var_139.credits,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPointNotification(param1:IMessageEvent) : void
      {
         var _loc2_:class_1961 = param1 as class_1961;
         var_139.activityPoints[_loc2_.type] = _loc2_.amount;
         updatePurse();
         if(_soundManager != null && _loc2_.type == 0)
         {
            _soundManager.playSound("HBST_pixels");
         }
         events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc2_.amount,_loc2_.type));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_1861 = param1 as class_1861;
         var_139.activityPoints = _loc3_.points;
         updatePurse();
         for(var _loc2_ in _loc3_.points)
         {
            _loc4_ = int(_loc2_);
            events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc3_.points[_loc4_],_loc4_));
         }
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:class_2014 = (param1 as class_2238).getParser();
         var_139.clubDays = Math.max(0,_loc2_.daysToPeriodEnd);
         var_139.clubPeriods = Math.max(0,_loc2_.periodsSubscribedAhead);
         var_139.isVIP = _loc2_.isVIP;
         var_139.pastClubDays = _loc2_.pastClubDays;
         var_139.pastVipDays = _loc2_.pastVipDays;
         var_139.isExpiring = _loc2_.responseType == 3 ? true : false;
         var_139.minutesUntilExpiration = _loc2_.minutesUntilExpiration;
         var_139.minutesSinceLastModified = _loc2_.minutesSinceLastModified;
         if(ExternalInterface.available)
         {
            if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
            {
               _loc3_ = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
               ExternalInterface.call("FlashExternalInterface.subscriptionUpdated",_loc3_);
            }
         }
         updatePurse();
         if(_loc2_.responseType == 2)
         {
            reset();
            if(var_970 != null)
            {
               openCatalogPage(var_970);
               var_970 = null;
            }
         }
      }
      
      private function onClubGiftInfo(param1:class_2167) : void
      {
         if(!param1 || !var_2490)
         {
            return;
         }
         var _loc2_:class_2236 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var_2490.setInfo(_loc2_.daysUntilNextGift,_loc2_.giftsAvailable,_loc2_.offers,_loc2_.giftData);
      }
      
      private function onRecyclerStatus(param1:IMessageEvent) : void
      {
         var _loc2_:class_2255 = (param1 as class_2222).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.setSystemStatus(_loc2_.recyclerStatus,_loc2_.recyclerTimeoutSeconds);
      }
      
      private function onRecyclerFinished(param1:IMessageEvent) : void
      {
         var _loc2_:class_2084 = (param1 as class_1935).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.setFinished(_loc2_.recyclerFinishedStatus,_loc2_.prizeId);
      }
      
      private function onRecyclerPrizes(param1:IMessageEvent) : void
      {
         var _loc2_:class_1784 = (param1 as class_2240).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.storePrizeTable(_loc2_.prizeLevels);
      }
      
      private function onMarketPlaceOffers(param1:IMessageEvent) : void
      {
         if(var_276 != null)
         {
            var_276.onOffers(param1);
         }
      }
      
      private function onMarketPlaceOwnOffers(param1:IMessageEvent) : void
      {
         if(var_276 != null)
         {
            var_276.onOwnOffers(param1);
         }
      }
      
      private function onMarketPlaceBuyResult(param1:IMessageEvent) : void
      {
         if(var_276 != null)
         {
            var_276.onBuyResult(param1);
         }
      }
      
      private function onMarketPlaceCancelResult(param1:IMessageEvent) : void
      {
         if(var_276 != null)
         {
            var_276.onCancelResult(param1);
         }
      }
      
      private function onGiftWrappingConfiguration(param1:class_1863) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_4467 = new GiftWrappingConfiguration(param1);
      }
      
      private function onMarketplaceItemStats(param1:class_1943) : void
      {
         if(!param1 || !var_276)
         {
            return;
         }
         var _loc2_:class_1746 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:class_2042 = new class_2042();
         _loc3_.averagePrice = _loc2_.averagePrice;
         _loc3_.offerCount = _loc2_.offerCount;
         _loc3_.historyLength = _loc2_.historyLength;
         _loc3_.dayOffsets = _loc2_.dayOffsets;
         _loc3_.averagePrices = _loc2_.averagePrices;
         _loc3_.soldAmounts = _loc2_.soldAmounts;
         _loc3_.furniCategoryId = _loc2_.furniCategoryId;
         _loc3_.furniTypeId = _loc2_.furniTypeId;
         var_276.itemStats = _loc3_;
      }
      
      private function onMarketplaceConfiguration(param1:class_1832) : void
      {
         if(!param1 || !var_276)
         {
            return;
         }
         var _loc2_:class_2097 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var_276.averagePricePeriod = _loc2_.averagePricePeriod;
      }
      
      private function onMarketplaceMakeOfferResult(param1:class_2170) : void
      {
         if(!param1 || !var_276)
         {
            return;
         }
         var _loc2_:class_2172 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.result == 1)
         {
            var_276.refreshOffers();
         }
      }
      
      private function onHabboClubOffers(param1:class_2030) : void
      {
         var _loc2_:class_2120 = param1.getParser();
         if(var_947 != null && (_loc2_.source == 0 || _loc2_.source == 1 || _loc2_.source == 2 || _loc2_.source == 6))
         {
            var_947.onOffers(_loc2_);
         }
      }
      
      private function onHabboClubExtendOffer(param1:class_2099) : void
      {
         if(!var_704)
         {
            init();
         }
         if(var_1198)
         {
            var_1198.onOffer(param1);
         }
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
      }
      
      private function onSellablePalettes(param1:class_1838) : void
      {
         var _loc2_:class_2013 = param1.getParser();
         var_1462.remove(_loc2_.productCode);
         var _loc3_:Array = _loc2_.sellablePalettes;
         if(_loc3_ != null)
         {
            var_1462.add(_loc2_.productCode,_loc3_.slice());
            var_106.dispatchWidgetEvent(new CatalogWidgetSellablePetPalettesEvent(_loc2_.productCode,_loc3_.slice()));
         }
      }
      
      private function setElementImage(param1:String, param2:BitmapData) : void
      {
         var _loc3_:class_2251 = var_39.findChildByName(param1) as class_2251;
         if(_loc3_ != null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
         else
         {
            class_21.log("Could not find element: " + param1);
         }
      }
      
      private function alertDialogEventProcessor(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         resetPlacedOfferData();
      }
      
      private function noCreditsConfirmDialogEventProcessor(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
         }
      }
      
      private function noDucketsConfirmDialogEventProcessor(param1:class_2001, param2:class_1758) : void
      {
         var _loc3_:String = null;
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            _loc3_ = getProperty("link.format.duckets");
            if(_loc3_ != "")
            {
               _windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
               HabboWebTools.navigateToURL(_loc3_,"habboMain");
            }
         }
      }
      
      private function onExternalLink(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      public function redeemVoucher(param1:String) : void
      {
         var _loc2_:IMessageComposer = new class_1941(param1);
         send(_loc2_);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function productDataReady() : void
      {
         var_2724 = true;
         events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
      }
      
      public function isDraggable(param1:class_1793) : Boolean
      {
         return getBoolean("catalog.drag_and_drop") && var_977 != null && (var_106.currentPage == null || var_106.currentPage.allowDragging) && (var_327 == "NORMAL" && (var_977.isRoomOwner || var_977.isGuildRoom && var_977.roomControllerLevel >= 2) || var_327 == "BUILDERS_CLUB" && getBuilderFurniPlaceableStatusForOffer(param1) == 0) && param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi" && param1.product != null && param1.product.productType != "e" && param1.product.productType != "h";
      }
      
      public function getBuilderFurniPlaceableStatusForOffer(param1:class_1793) : int
      {
         if(param1 == null)
         {
            return 1;
         }
         if(builderFurniCount < 0 || builderFurniCount >= builderFurniLimit)
         {
            return 2;
         }
         if(roomSession == null)
         {
            return 3;
         }
         return getBuilderFurniPlaceableStatus();
      }
      
      public function getBuilderFurniPlaceableStatus() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IRoomObject = null;
         var _loc1_:class_2146 = null;
         if(!roomSession.isRoomOwner && roomSession.isGuildRoom && !getBoolean("builders.club.furniture.placement.group.room.enabled"))
         {
            return 5;
         }
         if(roomSession.roomControllerLevel < 3)
         {
            return 4;
         }
         if(builderSecondsLeft <= 0)
         {
            _loc2_ = roomEngine.getRoomObjectCount(roomSession.roomId,100);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = roomEngine.getRoomObjectWithIndex(roomSession.roomId,_loc3_,100);
               _loc1_ = roomSession.userDataManager.getUserDataByIndex(_loc4_.getId());
               if(_loc1_ != null && _loc1_.type == 1 && _loc1_.roomObjectId != roomSession.ownUserRoomId && !_loc1_.isModerator)
               {
                  return 6;
               }
               _loc3_++;
            }
         }
         return 0;
      }
      
      public function canPlaceWithBC() : Boolean
      {
         return getBuilderFurniPlaceableStatus() == 0;
      }
      
      private function updateRoom(param1:String, param2:String) : void
      {
         var _loc4_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
         var _loc5_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
         var _loc3_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
         _loc4_ = _loc4_ && _loc4_.length > 0 ? _loc4_ : "101";
         _loc5_ = _loc5_ && _loc5_.length > 0 ? _loc5_ : "101";
         _loc3_ = _loc3_ && _loc3_.length > 0 ? _loc3_ : "1.1";
         switch(param1)
         {
            case "floor":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,param2,_loc4_,_loc3_,true);
               break;
            case "wallpaper":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,param2,_loc3_,true);
               break;
            case "landscape":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,param2,true);
               break;
            default:
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,_loc3_,true);
         }
      }
      
      public function requestSelectedItemToMover(param1:class_2050, param2:class_1793, param3:Boolean = false) : void
      {
         var _loc6_:int = 0;
         if(!isDraggable(param2))
         {
            return;
         }
         var _loc4_:class_1857;
         switch((_loc4_ = param2.product).productType)
         {
            case "s":
               _loc6_ = 10;
               break;
            case "i":
               _loc6_ = 20;
         }
         var _loc5_:Boolean = _roomEngine.initializeRoomObjectInsert("catalog",-param2.offerId,_loc6_,_loc4_.productClassId,_loc4_.extraParam ? _loc4_.extraParam.toString() : null,null,-1,-1,null,param3);
         if(_loc5_)
         {
            _offerInFurniPlacing = param2;
            _offerPlacingCallbackReceiver = param1;
            hideMainWindow();
            var_594 = true;
            var_4888 = param3;
         }
      }
      
      private function onObjectSelected(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:class_2146 = null;
         if(param1 == null)
         {
            return;
         }
         if(buildersClubEnabled && (!var_704 || !getCatalogNavigator("BUILDERS_CLUB").initialized))
         {
            init();
            refreshCatalogIndex("BUILDERS_CLUB");
         }
         if(param1.type == "REOE_SELECTED" && param1.category == 100)
         {
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               events.dispatchEvent(new CatalogUserEvent("CATALOG_USER_SELECTED",_loc2_.webID,_loc2_.name));
            }
         }
      }
      
      private function onFriendBarSelectionEvent(param1:FriendBarSelectionEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc4_:class_2050 = null;
         if(var_594 && param1.type == "FBVE_FRIEND_SELECTED")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc3_ = param1.friendId;
            _loc2_ = param1.friendName;
            _loc4_ = _offerPlacingCallbackReceiver;
            if(_loc4_ != null)
            {
               _loc4_.onDragAndDropDone(true,_loc2_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function getUserDataForEvent(param1:RoomEngineObjectEvent) : class_2146
      {
         if(_roomSessionManager != null)
         {
            var _loc3_:IRoomSession = _roomSessionManager.getSession(param1.roomId);
         }
         return null;
      }
      
      private function onObjectPlaceOnUser(param1:RoomEngineObjectPlacedOnUserEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:class_2146 = null;
         var _loc3_:class_2050 = null;
         if(var_594 && param1.type == "REOE_PLACED_ON_USER")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc4_ = null;
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.name;
            }
            _loc3_ = _offerPlacingCallbackReceiver;
            if(_loc3_ != null)
            {
               _loc3_.onDragAndDropDone(true,_loc4_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function onObjectPlacedInRoom(param1:RoomEngineObjectPlacedEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:class_1857 = null;
         var _loc5_:Boolean = false;
         if(var_594 && param1.type == "REOE_PLACED" && param1.placementSource == "catalog")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc7_ = param1.category;
            _loc2_ = _offerInFurniPlacing.product;
            _loc5_ = false;
            if(_loc7_ == 20)
            {
               switch(_loc2_.furnitureData.className)
               {
                  case "floor":
                  case "wallpaper":
                  case "landscape":
                     _loc5_ = param1.placedOnFloor || param1.placedOnWall;
                     break;
                  default:
                     _loc5_ = param1.placedInRoom;
               }
            }
            else
            {
               _loc5_ = param1.placedInRoom;
            }
            if(!_loc5_)
            {
               resetObjectMover();
               return;
            }
            var_148 = new PlacedObjectPurchaseData(param1.roomId,param1.objectId,param1.category,param1.wallLocation,param1.x,param1.y,param1.direction,_offerInFurniPlacing);
            var _loc6_:class_2050 = _offerPlacingCallbackReceiver;
            if(_loc6_ != null)
            {
               null.onDragAndDropDone(true,null);
            }
            switch(var_327)
            {
               case "NORMAL":
                  if(_loc7_ == 10)
                  {
                     _roomEngine.addObjectFurniture(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction,0,0),0,new class_2108());
                  }
                  else if(_loc7_ == 20)
                  {
                     switch(_loc2_.furnitureData.className)
                     {
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                           updateRoom(_loc2_.furnitureData.className,_loc2_.extraParam);
                           break;
                        default:
                           _roomEngine.addObjectWallItem(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction * 45,0,0),0,param1.instanceData,0);
                     }
                  }
                  var _loc4_:IRoomObjectController = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category) as IRoomObjectController;
                  if(_loc4_)
                  {
                     null.getModelController().setNumber("furniture_alpha_multiplier",0.5);
                  }
                  break;
               case "BUILDERS_CLUB":
                  var _loc8_:int = _offerInFurniPlacing.page.pageId;
                  if(_loc8_ == -12345678)
                  {
                     var _loc3_:Vector.<class_1917> = currentCatalogNavigator.getNodesByOfferId(_offerInFurniPlacing.offerId,true);
                  }
                  switch(_loc7_ - 10)
                  {
                     case 0:
                        send(new class_1848(0,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.x,param1.y,param1.direction));
                        break;
                     case 10:
                        send(new class_2128(0,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.wallLocation));
                  }
                  if(var_4888)
                  {
                     requestSelectedItemToMover(null,_offerInFurniPlacing,true);
                     break;
                  }
                  toggleBuilderCatalog();
            }
         }
      }
      
      private function resetObjectMover(param1:Boolean = true) : void
      {
         if(param1 && var_594)
         {
            showMainWindow();
         }
         var_594 = false;
         _offerPlacingCallbackReceiver = null;
      }
      
      public function syncPlacedOfferWithPurchase(param1:class_1793) : void
      {
         if(var_148)
         {
            if(var_148.offerId != param1.offerId)
            {
               resetPlacedOfferData();
            }
         }
      }
      
      public function resetPlacedOfferData(param1:Boolean = false) : void
      {
         if(!param1)
         {
            resetObjectMover();
         }
         if(var_148 != null)
         {
            if(var_148.category == 10)
            {
               _roomEngine.disposeObjectFurniture(var_148.roomId,var_148.objectId);
            }
            else
            {
               while(true)
               {
                  if(var_148.category == 20)
                  {
                     switch(var_148.furniData.className)
                     {
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                           updateRoom("reset","");
                           break;
                        default:
                           _roomEngine.disposeObjectWallItem(var_148.roomId,var_148.objectId);
                     }
                  }
                  else
                  {
                     _roomEngine.deleteRoomObject(var_148.objectId,var_148.category);
                  }
               }
               §§goto(addr00bc);
            }
            var_148.dispose();
            var_148 = null;
         }
         addr00bc:
      }
      
      public function cancelFurniInMover() : void
      {
         if(_offerInFurniPlacing != null)
         {
            _roomEngine.cancelRoomObjectInsert();
            var_594 = false;
            _offerInFurniPlacing = null;
         }
      }
      
      public function get collectorHub() : class_2113
      {
         return var_196;
      }
      
      public function get specialItemsController() : SpecialItemsController
      {
         return var_3472;
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:int) : void
      {
         var _loc8_:int = 0;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         if(var_148 != null && var_148.productClassId == param1)
         {
            if(var_148.roomId == _roomEngine.activeRoomId)
            {
               _loc8_ = param2;
               param3 = var_148.category;
               _loc6_ = var_148.wallLocation;
               _loc5_ = var_148.x;
               _loc7_ = var_148.y;
               _loc10_ = var_148.direction;
               switch(param3 - 2)
               {
                  case 0:
                     _loc9_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
                     if(var_148.extraParameter != _loc9_)
                     {
                        send(new class_2208(_loc8_));
                     }
                     break;
                  case 1:
                     _loc11_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
                     if(var_148.extraParameter != _loc11_)
                     {
                        send(new class_2208(_loc8_));
                     }
                     break;
                  case 2:
                     _loc4_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
                     if(var_148.extraParameter != _loc4_)
                     {
                        send(new class_2208(_loc8_));
                     }
                     break;
                  default:
                     send(new class_2048(_loc8_,param3,_loc6_,_loc5_,_loc7_,_loc10_));
               }
               resetPlacedOfferData();
            }
         }
      }
      
      public function setImageFromAsset(param1:class_1741, param2:String, param3:Function) : void
      {
         if(!param2 || !assets)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            retrievePreviewAsset(param2,param3);
            return;
         }
         if(param1)
         {
            HabboCatalog.setElementImageCentered(param1,_loc4_.content as BitmapData);
         }
      }
      
      public function get imageGalleryHost() : String
      {
         return getProperty("image.library.catalogue.url");
      }
      
      private function retrievePreviewAsset(param1:String, param2:Function) : void
      {
         if(!param1 || !assets)
         {
            return;
         }
         var _loc5_:String = imageGalleryHost + param1 + ".png";
         var _loc3_:URLRequest = new URLRequest(_loc5_);
         var _loc4_:AssetLoaderStruct = assets.loadAssetFromFile(param1,_loc3_,"image/png");
         if(!_loc4_)
         {
            return;
         }
         if(param2 != null)
         {
            _loc4_.addEventListener("AssetLoaderEventComplete",param2);
         }
      }
      
      private function showMainWindow() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && var_39 != null && var_39.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(var_39);
            }
         }
      }
      
      private function hideMainWindow() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && var_39 != null && var_39.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null && !var_2175)
            {
               _loc1_.removeChild(var_39);
               if(var_106 != null)
               {
                  var_106.catalogWindowClosed();
               }
            }
            var_2175 = false;
         }
      }
      
      private function mainWindowVisible() : Boolean
      {
         return _windowManager != null && var_39 != null && var_39.parent != null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(var_281 != null)
         {
            var_281.updatePreviewRoomView();
         }
         if(getTimer() - _builderMembershipDisplayUpdateTime > 500)
         {
            _loc3_ = builderSecondsLeft;
            _loc2_ = builderSecondsLeftWithGrace;
            if(_loc3_ > -3 && _loc3_ < 200 || _loc2_ > -3 && _loc2_ < 200)
            {
               refreshBuilderStatus();
            }
         }
      }
      
      public function onGuildMemberships(param1:class_2022) : void
      {
         if(var_854)
         {
            var_854.onGuildMembershipsMessageEvent(param1);
         }
      }
      
      private function onSnowWarGameTokenOffer(param1:SnowWarGameTokensMessageEvent) : void
      {
         var _loc3_:SnowWarGameTokensMessageParser = param1.getParser();
         disposeSnowWarTokens();
         for each(var _loc2_ in _loc3_.offers)
         {
            if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS")
            {
               var_987 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS2")
            {
               var_1022 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS3")
            {
               var_999 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
         }
      }
      
      public function buySnowWarTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && var_987)
         {
            showPurchaseConfirmation(var_987,-1,var_987.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && var_1022)
         {
            showPurchaseConfirmation(var_1022,-1,var_1022.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && var_999)
         {
            showPurchaseConfirmation(var_999,-1,var_999.localizationId);
         }
         else
         {
            _communication.connection.send(new GetSnowWarGameTokensOfferComposer());
         }
      }
      
      public function verifyClubLevel(param1:int = 1) : Boolean
      {
         if(_sessionDataManager.clubLevel >= param1)
         {
            return true;
         }
         openClubCenter();
         return false;
      }
      
      public function openClubCenter() : void
      {
         context.createLinkEvent("habboUI/open/hccenter");
      }
      
      public function openVault() : void
      {
         context.createLinkEvent("habboUI/open/vault");
      }
      
      private function onGuildVisualSettingsChanged(param1:GuildSettingsChangedInManageEvent) : void
      {
         if(var_854)
         {
            var_854.onGuildVisualSettingsChanged(param1.guildId);
         }
      }
      
      public function get avatarEditor() : class_141
      {
         return _avatarEditor;
      }
      
      public function checkGiftable(param1:class_1793) : void
      {
         send(new class_1981(param1.offerId));
      }
      
      public function rememberPageDuringVipPurchase(param1:int) : void
      {
         var _loc2_:class_1917 = currentCatalogNavigator.getNodeById(param1);
         if(_loc2_)
         {
            var_970 = _loc2_.pageName;
         }
         else
         {
            var_970 = "frontpage";
         }
      }
      
      public function forgetPageDuringVipPurchase() : void
      {
         var_970 = null;
         var_2175 = false;
      }
      
      public function doNotCloseAfterVipPurchase() : void
      {
         var_2175 = var_970 != null;
      }
      
      private function initBundleDiscounts() : void
      {
         sendGetBundleDiscountRuleset();
      }
      
      private function sendGetBundleDiscountRuleset() : void
      {
         send(new class_1984());
      }
      
      public function sendGetProductOffer(param1:int) : void
      {
         send(new class_2145(param1));
      }
      
      private function onBundleDiscountRulesetMessageEvent(param1:class_2103) : void
      {
         var _loc2_:class_1871 = param1.getParser();
         _bundleDiscountRuleset = _loc2_.bundleDiscountRuleset;
         _utils.resolveBundleDiscountFlatPriceSteps();
      }
      
      private function onLimitedEditionSoldOut(param1:class_1858) : void
      {
         _windowManager.alert("${catalog.alert.limited_edition_sold_out.title}","${catalog.alert.limited_edition_sold_out.message}",0,alertDialogEventProcessor);
         if(var_69 != null)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      private function onProductOffer(param1:class_2110) : void
      {
         var _loc6_:class_1800 = null;
         var _loc3_:class_1749 = param1.getParser();
         var _loc4_:class_2138 = _loc3_.offerData;
         if(!_loc4_ || _loc4_.products.length == 0)
         {
            return;
         }
         var _loc5_:class_2104 = _loc4_.products[0];
         if(_loc5_.uniqueLimitedItem)
         {
            var_106.currentPage.updateLimitedItemsLeft(_loc4_.offerId,_loc5_.uniqueLimitedItemsLeft);
         }
         var _loc7_:Vector.<class_1857> = new Vector.<class_1857>(0);
         var _loc8_:class_1949 = getProductData(_loc4_.localizationId);
         for each(_loc5_ in _loc4_.products)
         {
            _loc6_ = getFurnitureData(_loc5_.furniClassId,_loc5_.productType);
            _loc7_.push(new Product(_loc5_.productType,_loc5_.furniClassId,_loc5_.extraParam,_loc5_.productCount,_loc8_,_loc6_,this,_loc5_.uniqueLimitedItem,_loc5_.uniqueLimitedItemSeriesSize,_loc5_.uniqueLimitedItemsLeft));
         }
         var _loc2_:Offer = new Offer(_loc4_.offerId,_loc4_.localizationId,_loc4_.isRent,_loc4_.priceInCredits,_loc4_.priceInActivityPoints,_loc4_.activityPointType,_loc4_.priceInSilver,_loc4_.giftable,_loc4_.clubLevel,_loc7_,_loc4_.bundlePurchaseAllowed,this);
         if(!isOfferCompatibleWithCurrentMode(_loc2_))
         {
            _loc2_.dispose();
            return;
         }
         if(var_106 && var_106.currentPage)
         {
            _loc2_.page = var_106.currentPage;
            var_106.currentPage.dispatchWidgetEvent(new SelectProductEvent(_loc2_));
            if(_loc2_.product && _loc2_.product.productType == "i")
            {
               var_106.currentPage.dispatchWidgetEvent(new SetExtraPurchaseParameterEvent(_loc2_.product.extraParam));
            }
            if(var_594 && _offerInFurniPlacing)
            {
               _offerInFurniPlacing = _loc2_;
            }
         }
      }
      
      private function onBuildersClubSubscriptionStatus(param1:class_1776) : void
      {
         var _loc2_:class_2216 = param1.getParser();
         var_3671 = _loc2_.furniLimit;
         var_4848 = _loc2_.maxFurniLimit;
         var_3206 = _loc2_.secondsLeft;
         _builderMembershipUpdateTime = getTimer();
         var_3712 = _loc2_.secondsLeftWithGrace;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateBuildersClub",var_3206 > 0);
         }
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
         }
         refreshBuilderStatus();
      }
      
      private function onBuildersClubFurniCount(param1:class_1760) : void
      {
         var_3622 = param1.getParser().furniCount;
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
         }
         refreshBuilderStatus();
      }
      
      private function refreshBuilderStatus() : void
      {
         var _loc4_:Number = var_3206 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         var _loc2_:Number = var_3712 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         if(var_3184 && _loc4_ <= 0 && _loc2_ > 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_IN_GRACE"));
         }
         else if(var_2716 && _loc2_ <= 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_EXPIRED"));
         }
         var_3184 = _loc4_ > 0;
         var_2716 = _loc2_ > 0;
         var _loc3_:String = "builder.header.status." + (var_3184 ? "member" : (var_2716 ? "grace" : "trial"));
         var _loc5_:String = _localization.getLocalization(_loc3_);
         _localization.registerParameter("builder.header.title","bcstatus",_loc5_);
         var _loc1_:String = var_3184 ? FriendlyTime.getFriendlyTime(_localization,_loc4_) : (var_2716 ? FriendlyTime.getFriendlyTime(_localization,_loc2_) : _loc5_);
         _localization.registerParameter("builder.header.status.membership","duration","<font color=\"#ff8d00\"><b>" + _loc1_ + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","count","<font color=\"#ff8d00\"><b>" + var_3622 + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","limit","<font color=\"#ff8d00\"><b>" + var_3671 + "</b></font>");
         _builderMembershipDisplayUpdateTime = getTimer();
      }
      
      public function get bundleDiscountEnabled() : Boolean
      {
         return var_327 != "BUILDERS_CLUB";
      }
      
      public function get bundleDiscountRuleset() : class_1766
      {
         return _bundleDiscountRuleset;
      }
      
      public function get multiplePurchaseEnabled() : Boolean
      {
         return getBoolean("catalog.multiple.purchase.enabled") && var_327 != "BUILDERS_CLUB";
      }
      
      public function get newAdditionsPageOpenDisabled() : Boolean
      {
         return getBoolean("catalog.new.additions.page.open.disabled");
      }
      
      public function showVipBenefits() : void
      {
         if(!_utils)
         {
            init();
         }
         if(_utils)
         {
            if(!getCatalogNavigator("NORMAL").initialized)
            {
               refreshCatalogIndex("NORMAL");
            }
            _utils.showVipBenefits();
         }
      }
      
      public function get currentPage() : class_2044
      {
         return var_106?.currentPage;
      }
      
      public function displayProductIcon(param1:String, param2:int, param3:class_2251) : void
      {
         _utils.displayProductIcon(param1,param2,param3);
      }
      
      public function openRentConfirmationWindow(param1:class_1800, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         if(var_1623 == null)
         {
            var_1623 = new RentConfirmationWindow(this);
         }
         var_1623.show(param1,param2,param3,param4,param5);
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_977;
      }
      
      public function get linkPattern() : String
      {
         return "catalog/";
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
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2]);
                  break;
               }
               openCatalog();
               break;
            case "warehouse":
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2],"BUILDERS_CLUB");
                  break;
               }
               toggleCatalog("BUILDERS_CLUB",true);
               break;
            case "club_buy":
               openClubCenter();
               break;
            default:
               class_21.log("Catalog unknown link-type receive: " + _loc2_[1]);
         }
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get mainContainer() : class_1812
      {
         return var_39;
      }
      
      public function toggleBuilderCatalog() : void
      {
         toggleCatalog("BUILDERS_CLUB");
      }
      
      public function get catalogType() : String
      {
         return var_327;
      }
      
      public function getCatalogNavigator(param1:String) : class_1737
      {
         return _catalogNavigators != null ? _catalogNavigators[param1] : null;
      }
      
      public function get currentCatalogNavigator() : class_1737
      {
         return getCatalogNavigator(var_327);
      }
      
      public function get builderFurniLimit() : int
      {
         return var_3671;
      }
      
      public function get builderFurniCount() : int
      {
         return var_3622;
      }
      
      public function get builderMaxFurniLimit() : int
      {
         return var_4848;
      }
      
      public function get builderSecondsLeft() : Number
      {
         return var_3206 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function get builderSecondsLeftWithGrace() : Number
      {
         return var_3712 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function getOfferCenter(param1:IOfferExtension) : IOfferCenter
      {
         if(_offerCenter == null)
         {
            _offerCenter = new OfferCenter(windowManager,assets,this);
         }
         _offerCenter.offerExtension = param1;
         return _offerCenter;
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function useNonTabbedCatalog() : Boolean
      {
         return getBoolean("client.desktop.use.non.tabbed.catalog");
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
   }
}

