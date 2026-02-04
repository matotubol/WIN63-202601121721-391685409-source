package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.roomevents.wired_menu.tabs.class_2710;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import flash.utils.Dictionary;
   
   public class WiredMenuView implements class_13
   {
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _windowManager:class_38;
      
      private var var_55:WiredMenuController;
      
      private var _window:class_1812;
      
      private var var_4460:WiredMenuTabConfigs;
      
      private var var_1134:Boolean = false;
      
      private var var_817:Dictionary;
      
      private var var_855:String = null;
      
      private var var_1000:Boolean = false;
      
      public function WiredMenuView(param1:WiredMenuController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         var_4460 = new WiredMenuTabConfigs(param1);
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("wired_menu_view_xml").content),1) as class_1812;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         discordRegion.addEventListener("WME_CLICK",onClickDiscord);
      }
      
      public function initialize() : void
      {
         initializeTabs();
      }
      
      public function show() : void
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
         if(!var_1000)
         {
            activeTab.startViewing();
            var_1000 = true;
         }
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
            if(var_1000)
            {
               activeTab.stopViewing();
               var_1000 = false;
            }
         }
      }
      
      private function initializeTabs() : void
      {
         var_817 = new Dictionary();
         var _loc1_:WiredMenuTabConfig = null;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.isCreateImmediately)
            {
               getOrCreateTab(_loc3_.id);
            }
            if(_loc1_ == null && _loc3_.isEnabled)
            {
               _loc1_ = _loc3_;
            }
            var _loc2_:ITabButtonWindow = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            null.addEventListener("WE_SELECTED",onTabSelected);
            _window.findChildByName(_loc3_.containerName).visible = false;
         }
         selectTab(_loc1_.id);
         alignTabs();
      }
      
      public function selectTab(param1:String) : void
      {
         var _loc2_:WiredMenuTabConfig = getTabConfigById(param1);
         if(_loc2_ == null || !_loc2_.isEnabled)
         {
            return;
         }
         tabContext.selector.setSelected(ISelectableWindow(_window.findChildByName(_loc2_.tabButtonName)));
      }
      
      private function alignTabs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ITabButtonWindow = null;
         var _loc4_:WiredMenuTabConfig = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            _loc4_ = getTabConfigByTabName(_loc3_.name);
            if(_loc4_.isEnabled)
            {
               _loc1_ += 1;
            }
            else
            {
               _loc3_.visible = false;
               _loc3_.width = 0;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            if(_loc3_.visible)
            {
               _loc3_.width = _loc3_.parent.width / _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function onTabSelected(param1:class_1758) : void
      {
         var _loc2_:String = null;
         var _loc4_:class_1741 = param1.target;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.tabButtonName == _loc4_.name)
            {
               _loc2_ = _loc3_.id;
               break;
            }
         }
         setActiveTab(_loc2_);
      }
      
      private function setActiveTab(param1:String) : void
      {
         var _loc2_:class_2710 = null;
         var _loc5_:WiredMenuTabConfig = null;
         var _loc4_:WiredMenuTabConfig = getTabConfigById(param1);
         if(_loc4_.id == var_855)
         {
            return;
         }
         if(var_855 != null)
         {
            _loc2_ = getTabById(var_855);
            _loc5_ = getTabConfigById(var_855);
            if(var_1000)
            {
               _loc2_.stopViewing();
            }
            _loc2_.setTabInactive();
            if(!_loc5_.isReusable)
            {
               _loc2_.dispose();
               delete var_817[var_855];
            }
            _window.findChildByName(_loc5_.containerName).visible = false;
         }
         var_855 = param1;
         var _loc3_:class_2710 = getOrCreateTab(param1);
         _window.findChildByName(_loc4_.containerName).visible = true;
         _loc3_.setTabActive();
         if(var_1000)
         {
            _loc3_.startViewing();
         }
         headerTitle.text = var_55.localizationManager.getLocalization(_loc4_.titleLocalizationKey,_loc4_.id);
      }
      
      internal function permissionsUpdated() : void
      {
         for each(var _loc1_ in var_817)
         {
            _loc1_.permissionsUpdated();
         }
      }
      
      private function get tabConfigs() : Vector.<WiredMenuTabConfig>
      {
         return var_4460.menuTabs;
      }
      
      private function getTabConfigById(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabConfigByTabName(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.tabButtonName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabById(param1:String) : class_2710
      {
         return var_817[param1];
      }
      
      public function get activeTab() : class_2710
      {
         return getTabById(var_855);
      }
      
      public function get activeTabId() : String
      {
         return var_855;
      }
      
      private function getOrCreateTab(param1:String) : class_2710
      {
         var _loc3_:WiredMenuTabConfig = getTabConfigById(param1);
         var _loc2_:class_2710 = var_817[param1];
         if(_loc2_ == null)
         {
            _loc2_ = _loc3_.createTab(var_55,_window.findChildByName(_loc3_.containerName) as class_1812);
            var_817[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function onClickDiscord(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_55.getProperty("wired.discord.link"));
      }
      
      public function dispose() : void
      {
         var _loc1_:class_2710 = null;
         var _loc2_:ITabButtonWindow = null;
         if(var_1134)
         {
            return;
         }
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         for each(var _loc3_ in tabConfigs)
         {
            _loc1_ = getTabById(_loc3_.id);
            if(_loc1_ != null)
            {
               if(_loc3_.id == var_855)
               {
                  if(var_1000)
                  {
                     _loc1_.stopViewing();
                  }
                  _loc1_.setTabInactive();
               }
               _loc1_.dispose();
            }
            _loc2_ = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            _loc2_.removeEventListener("WE_SELECTED",onTabSelected);
         }
         var_817 = null;
         var_855 = null;
         var_1000 = false;
         _window.dispose();
         _window = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get tabContext() : ITabContextWindow
      {
         return _window.findChildByName("tab_context") as ITabContextWindow;
      }
      
      private function get headerTitle() : ITextWindow
      {
         return _window.findChildByName("header_title") as ITextWindow;
      }
      
      public function get loadingContainer() : class_1812
      {
         return _window.findChildByName("loading_view") as class_1812;
      }
      
      public function get discordRegion() : IRegionWindow
      {
         return _window.findChildByName("discord_region") as IRegionWindow;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

