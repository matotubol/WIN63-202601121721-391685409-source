package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_info.WiredMenuInfoTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.WiredMenuInspectionTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor.WiredMenuMonitorTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings.WiredMenuSettingsTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.WiredMenuOverviewTab;
   
   public class WiredMenuTabConfigs
   {
      
      public static var TAB_MONITOR_ID:String = "monitor";
      
      public static var TAB_OVERVIEW_ID:String = "variable_overview";
      
      public static var TAB_INSPECTION_ID:String = "inspection";
      
      public static var TAB_SETTINGS_ID:String = "settings";
      
      public static var TAB_INFO_ID:String = "info";
      
      private var var_5167:Vector.<WiredMenuTabConfig>;
      
      public function WiredMenuTabConfigs(param1:WiredMenuController)
      {
         super();
         var_5167 = Vector.<WiredMenuTabConfig>([new WiredMenuTabConfig(TAB_MONITOR_ID,WiredMenuMonitorTab),new WiredMenuTabConfig(TAB_OVERVIEW_ID,WiredMenuOverviewTab),new WiredMenuTabConfig(TAB_INSPECTION_ID,WiredMenuInspectionTab),new WiredMenuTabConfig(TAB_SETTINGS_ID,WiredMenuSettingsTab),new WiredMenuTabConfig(TAB_INFO_ID,WiredMenuInfoTab,true,true,false)]);
      }
      
      public function get menuTabs() : Vector.<WiredMenuTabConfig>
      {
         return var_5167;
      }
   }
}

