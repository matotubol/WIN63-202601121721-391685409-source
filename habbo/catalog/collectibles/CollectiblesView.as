package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.catalog.collectibles.tabs.MintInventoryListTab;
   import com.sulake.habbo.catalog.collectibles.tabs.RewardClaimsTab;
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   import com.sulake.habbo.catalog.collectibles.tabs.TransferNftsTab;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleWalletAddressesMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollectionsScoreMessageEventParser;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleWalletAddressesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsScoreMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleWalletAddressesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectorScoreMessageComposer;
   
   public class CollectiblesView implements class_13
   {
      
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static const STARDUST_WALLET_DISPLAY_NAME:String = "Collector Wallet";
      
      private static const TAB_COLLECTIONS:String = "top_view_collections_button";
      
      private static const TAB_MINT:String = "top_view_minting_button";
      
      private static const TAB_INFO:String = "top_view_info_button";
      
      private static const TAB_TRANSFER:String = "top_view_transfer_button";
      
      private static const TAB_SHOP:String = "top_view_shop_button";
      
      private static const TAB_REWARDS:String = "top_view_rewards_button";
      
      private static const TAB_COLLECTOR_PROFILE:String = "top_view_profile_button";
      
      private static const TAB_LEVELS:String = "top_view_levels_button";
      
      private var _windowManager:class_38;
      
      private var var_55:CollectiblesController;
      
      private var _window:class_1812;
      
      private var _currentTab:String = "top_view_rewards_button";
      
      private var var_750:MintInventoryListTab;
      
      private var var_364:CollectionsTab;
      
      private var var_524:TransferNftsTab;
      
      private var var_2509:ShopTab;
      
      private var var_1625:RewardClaimsTab;
      
      private var var_2843:Boolean = false;
      
      private var var_667:Array = null;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1622:String;
      
      private var var_3546:String;
      
      public function CollectiblesView(param1:CollectiblesController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("collectible_view_xml").content),1) as class_1812;
         _window.findChildByName("top_view_profile_button").procedure = onTab;
         _window.findChildByName("top_view_collections_button").procedure = onTab;
         _window.findChildByName("top_view_levels_button").procedure = onTab;
         _window.findChildByName("top_view_minting_button").procedure = onTab;
         _window.findChildByName("top_view_info_button").procedure = onTab;
         _window.findChildByName("top_view_transfer_button").procedure = onTab;
         _window.findChildByName("top_view_shop_button").procedure = onTab;
         _window.findChildByName("top_view_rewards_button").procedure = onTab;
         _window.findChildByName("top_view_collections_button").caption = "${collectibles.collections.title}";
         _window.findChildByName("top_view_shop_button").caption = "${collectibles.shop.title}";
         _window.findChildByName("top_view_minting_button").caption = "${shop.minting.title}";
         _window.findChildByName("top_view_transfer_button").caption = "${collectibles.transfer}";
         _window.findChildByName("top_view_info_button").caption = "${collectibles.info.title}";
         _window.findChildByName("top_view_rewards_button").caption = "${collectibles.claim.title}";
         addMessageEvents();
         refresh();
         requestWalletAddresses();
         var _loc6_:Boolean = param1.context.configuration.getBoolean("nft.minting.enabled");
         _window.findChildByName("top_view_minting_button").visible = _loc6_;
         var _loc3_:Boolean = param1.context.configuration.getBoolean("collectibles.transfer.enabled");
         _window.findChildByName("top_view_transfer_button").visible = _loc3_;
         var _loc4_:Boolean = param1.context.configuration.getBoolean("nft.shop.enabled");
         _window.findChildByName("top_view_shop_button").visible = _loc4_;
         levelTitle.caption = param1.localizationManager.getLocalization("collectibles.level").toUpperCase();
         centerTabLayout();
         initWidgets();
         var _loc5_:class_1741 = _window.findChildByName("header_button_close");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onWindowClose);
         }
         infoLink.addEventListener("WE_LINK",onClickHtmlLink);
         infoLink.initializeLinkStyle();
         transferLink.addEventListener("WE_LINK",onClickHtmlLink);
         transferLink.initializeLinkStyle();
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
      
      private function hideWindow() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function showWindow() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
      }
      
      private function centerTabLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:class_1741 = null;
         var _loc4_:ISelectorListWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context")).selector;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.numSelectables)
         {
            _loc1_ = _loc4_.getSelectableAt(_loc3_);
            if(_loc1_.visible)
            {
               var _loc2_:int = 0 + _loc1_.width;
            }
            else
            {
               _loc1_.width = 0;
            }
            _loc3_++;
         }
         _loc4_.x = _window.width / 2 - 0 / 2;
         window.findChildByName("tab_bg").visible = 0 > 350;
      }
      
      private function addMessageEvents() : void
      {
         if(!var_55)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CollectibleWalletAddressesMessageEvent(onCollectableWalletAddressMessage));
         _messageEvents.push(new NftCollectionsScoreMessageEvent(onCollectionsScoreMessage));
         for each(var _loc1_ in _messageEvents)
         {
            var_55.addMessageEvent(_loc1_);
         }
      }
      
      public function updateBalances(param1:class_1831) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:class_1741 = _window.findChildByName("emerald_currency_value");
         if(_loc2_)
         {
            _loc2_.caption = "" + param1.emeraldBalance;
         }
         var _loc3_:class_1741 = _window.findChildByName("silver_currency_value");
         if(_loc3_)
         {
            _loc3_.caption = "" + param1.silverBalance;
         }
         if(var_524)
         {
            var_524.onSilverBalanceUpdated();
         }
      }
      
      private function onCollectionsScoreMessage(param1:NftCollectionsScoreMessageEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:NftCollectionsScoreMessageEventParser = param1.getParser();
         levelValue.caption = String(_loc2_.level);
         scoreValue.caption = String(_loc2_.score);
         hiscoreValue.caption = String(_loc2_.highestScore);
         var _loc4_:int;
         switch(_loc4_ = Math.max(0,(_loc2_.level - 1) / 5))
         {
            case 0:
               _loc3_ = 8162450;
               break;
            case 1:
               _loc3_ = 2529547;
               break;
            case 2:
               _loc3_ = 32234;
               break;
            case 3:
               _loc3_ = 13828339;
               break;
            default:
               _loc3_ = 15571457;
         }
         collectorLevelBg.color = _loc3_;
         collectorLevelBg2.color = _loc3_;
      }
      
      private function onCollectableWalletAddressMessage(param1:CollectibleWalletAddressesMessageEvent) : void
      {
         var_2843 = false;
         var _loc2_:CollectibleWalletAddressesMessageEventParser = param1.getParser();
         var_667 = _loc2_.walletAddresses;
         var_3546 = _loc2_.stardustWalletAddress;
         if(var_364)
         {
            var_364.onWalletsAddressesUpdated(var_667);
         }
         if(var_524)
         {
            var_524.onWalletsAddressesUpdated(nonStardustWallets);
         }
         if(var_1625)
         {
            var_1625.onWalletsAddressesUpdated(var_667);
         }
         setActiveWalletIndex(0);
      }
      
      public function get nonStardustWallets() : Array
      {
         if(var_667 == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(var _loc1_ in var_667)
         {
            if(_loc1_ != var_3546)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function walletsLoaded() : Boolean
      {
         return var_667 != null;
      }
      
      public function setActiveWalletIndex(param1:int) : void
      {
         if(var_667.length > 0 && (param1 < 0 || param1 >= var_667.length || var_667[param1] == var_1622))
         {
            return;
         }
         var_1622 = var_667.length > 0 ? var_667[param1] : null;
         if(var_364)
         {
            var_364.activeWallet = var_1622;
         }
         if(var_750)
         {
            var_750.activeWallet = var_1622;
         }
         if(var_1622 != null)
         {
            var_55.send(new GetCollectorScoreMessageComposer(var_1622));
         }
      }
      
      private function requestWalletAddresses() : void
      {
         if(var_2843)
         {
            return;
         }
         var_2843 = true;
         var_55.send(new GetCollectibleWalletAddressesMessageComposer());
      }
      
      public function get walletAddresses() : Array
      {
         return var_667;
      }
      
      private function refresh() : void
      {
         var _loc1_:ITabContextWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context"));
         _loc1_.selector.setSelected(ISelectableWindow(_window.findChildByName(_currentTab)));
         hideAllTabContainers();
         switch(_currentTab)
         {
            case "top_view_profile_button":
               _window.findChildByName("collectorProfileContainer").visible = true;
               break;
            case "top_view_collections_button":
               _window.findChildByName("collectionsContainer").visible = true;
               if(!var_364)
               {
                  var_364 = new CollectionsTab(this,var_55);
               }
               break;
            case "top_view_levels_button":
               _window.findChildByName("levelsContainer").visible = true;
               break;
            case "top_view_minting_button":
               _window.findChildByName("mintingContainer").visible = true;
               if(!var_750)
               {
                  var_750 = new MintInventoryListTab(this,var_55);
               }
               break;
            case "top_view_transfer_button":
               _window.findChildByName("transferContainer").visible = true;
               if(!var_524)
               {
                  var_524 = new TransferNftsTab(this,var_55);
               }
               break;
            case "top_view_info_button":
               _window.findChildByName("infoContainer").visible = true;
               break;
            case "top_view_shop_button":
               _window.findChildByName("shopContainer").visible = true;
               if(!var_2509)
               {
                  var_2509 = new ShopTab(this,var_55);
               }
               break;
            case "top_view_rewards_button":
               _window.findChildByName("rewardsContainer").visible = true;
               if(!var_1625)
               {
                  var_1625 = new RewardClaimsTab(this,var_55);
               }
         }
      }
      
      private function initWidgets() : void
      {
         if(!var_364)
         {
            var_364 = new CollectionsTab(this,var_55);
         }
         if(!var_750)
         {
            var_750 = new MintInventoryListTab(this,var_55);
         }
         if(!var_524)
         {
            var_524 = new TransferNftsTab(this,var_55);
         }
         if(!var_2509)
         {
            var_2509 = new ShopTab(this,var_55);
         }
         if(!var_1625)
         {
            var_1625 = new RewardClaimsTab(this,var_55);
         }
      }
      
      public function get activeWallet() : String
      {
         return var_1622;
      }
      
      private function hideAllTabContainers() : void
      {
         _window.findChildByName("collectorProfileContainer").visible = false;
         _window.findChildByName("collectionsContainer").visible = false;
         _window.findChildByName("levelsContainer").visible = false;
         _window.findChildByName("mintingContainer").visible = false;
         _window.findChildByName("transferContainer").visible = false;
         _window.findChildByName("infoContainer").visible = false;
         _window.findChildByName("shopContainer").visible = false;
         _window.findChildByName("rewardsContainer").visible = false;
      }
      
      private function onTab(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _currentTab = param2.name;
         refresh();
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function onClickHtmlLink(param1:class_1758) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_55 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_55.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function get stardustWallet() : String
      {
         return var_3546;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         if(var_364)
         {
            var_364.dispose();
            var_364 = null;
         }
         if(var_750)
         {
            var_750.dispose();
            var_750 = null;
         }
         if(var_524)
         {
            var_524.dispose();
            var_524 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get mintInventoryListWidget() : MintInventoryListTab
      {
         return var_750;
      }
      
      public function get transferWidget() : TransferNftsTab
      {
         return var_524;
      }
      
      public function get collectionsWidget() : CollectionsTab
      {
         return var_364;
      }
      
      private function get scoreValue() : ITextWindow
      {
         return _window.findChildByName("current_score_value") as ITextWindow;
      }
      
      private function get hiscoreValue() : ITextWindow
      {
         return _window.findChildByName("current_hiscore_value") as ITextWindow;
      }
      
      private function get levelValue() : ITextWindow
      {
         return _window.findChildByName("collector_level") as ITextWindow;
      }
      
      private function get levelTitle() : ITextWindow
      {
         return _window.findChildByName("level_title") as ITextWindow;
      }
      
      private function get collectorLevelBg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg") as IStaticBitmapWrapperWindow;
      }
      
      private function get collectorLevelBg2() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg2") as IStaticBitmapWrapperWindow;
      }
      
      private function get infoLink() : class_1899
      {
         return _window.findChildByName("info_desc") as class_1899;
      }
      
      private function get transferLink() : class_1899
      {
         return _window.findChildByName("transfer_desc") as class_1899;
      }
   }
}

