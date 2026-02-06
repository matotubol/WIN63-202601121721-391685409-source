package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetErrorLogsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredClearErrorLogsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetRoomStatsMessageComposer;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogsConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import package_192.WiredGetRoomLogsComposer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorLogsEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_4089;
   import package_99.ProgressTreasureHuntMessageComposer;
   
   public class WiredMenuMonitorTab extends WiredMenuDefaultTab implements class_31
   {
      
      private static var POLL_MONITOR_MS:uint = 500;
      
      private static var CLEAR_LOGS_TIMEOUT:uint = 4000;
      
      private static var COLOR_RED:String = "ff5733";
      
      private static var COLOR_ORANGE:String = "BD7800";
      
      private static var COLOR_GREEN:String = "008000";
      
      private static var THRESHOLD_USAGE_1:Number = 0.3;
      
      private static var THRESHOLD_USAGE_2:Number = 0.7;
      
      private static var THRESHOLD_FURNI_1:Number = 0.6;
      
      private static var THRESHOLD_FURNI_2:Number = 0.85;
      
      private static var THRESHOLD_VARS_1:Number = 0.5;
      
      private static var THRESHOLD_VARS_2:Number = 0.8;
      
      public static var LOG_COLUMN_TYPE:String = "type";
      
      public static var var_5247:String = "category";
      
      public static var var_4541:String = "quantity";
      
      public static var LOG_COLUMN_LATEST:String = "latest";
      
      private var var_2809:TableView;
      
      private var var_4210:int = 0;
      
      private var var_1400:WiredErrorInfoView = null;
      
      private var var_4656:Number = 0;
      
      private var var_1295:Vector.<class_4089> = null;
      
      private var var_99:WiredRoomStatsData = null;
      
      public function WiredMenuMonitorTab(param1:WiredMenuController, param2:class_1812)
      {
         super(param1,param2);
         createLogTable();
         addMessageEvent(new WiredRoomStatsEvent(onRoomStatsEvent));
         addMessageEvent(new WiredErrorLogsEvent(onErrorLogsEvent));
         clearButton.addEventListener("WME_CLICK",onClearButtonClicked);
         logOverviewButton.addEventListener("WME_CLICK",onLogOverviewButtonClicked);
         monitorImage2.addEventListener("WME_CLICK",onClickMonitor);
      }
      
      private static function colorize(param1:int, param2:int, param3:int, param4:Number, param5:Number) : String
      {
         var _loc6_:Number = (param1 - param2) / (param3 - param2);
         if(_loc6_ < param4)
         {
            return COLOR_GREEN;
         }
         if(_loc6_ < param5)
         {
            return COLOR_ORANGE;
         }
         return COLOR_RED;
      }
      
      private function createLogTable() : void
      {
         var_2809 = new TableView(controller.windowManager,logTableContainer);
         var _loc1_:Array = [new TableColumn(LOG_COLUMN_TYPE,loc("wiredmenu.monitor.column.type"),0.33),new TableColumn(var_5247,loc("wiredmenu.monitor.column.category"),0.22),new TableColumn(var_4541,loc("wiredmenu.monitor.column.occurrences"),0.15),new TableColumn(LOG_COLUMN_LATEST,loc("wiredmenu.monitor.column.latest"),0.3)];
         var_2809.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_1295 != null && var_99 != null;
      }
      
      private function clearData() : void
      {
         var_1295 = null;
         var_99 = null;
      }
      
      private function requestData() : void
      {
         var_4210 = getTimer();
         controller.send(new WiredGetRoomStatsMessageComposer());
         controller.send(new WiredGetErrorLogsMessageComposer());
      }
      
      private function onRoomStatsEvent(param1:WiredRoomStatsEvent) : void
      {
         var_99 = param1.getParser().roomStats;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateRoomStatsUI();
            updateImageUI();
         }
      }
      
      private function onErrorLogsEvent(param1:WiredErrorLogsEvent) : void
      {
         var_1295 = param1.getParser().errors;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateErrorLogsUI();
            updateButtonsUI();
            updateImageUI();
         }
      }
      
      private function onClearButtonClicked(param1:WindowMouseEvent) : void
      {
         clearButton.disable();
         controller.send(new WiredClearErrorLogsMessageComposer());
         var_4656 = getTimer();
         setTimeout(updateButtonsUI,CLEAR_LOGS_TIMEOUT + 500);
      }
      
      private function onLogOverviewButtonClicked(param1:WindowMouseEvent) : void
      {
         controller.roomLogListController.send(new WiredGetRoomLogsComposer(1,WiredRoomLogsConfig.PAGE_SIZE,-1,-1,""));
      }
      
      override protected function initializeInterface() : void
      {
         updateRoomStatsUI();
         updateErrorLogsUI();
         updateButtonsUI();
         updateImageUI();
      }
      
      private function updateRoomStatsUI() : void
      {
         statWiredUsageHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.usage","","color",usageStatColor,"amount",var_99.executionCost.toFixed(0),"limit",var_99.executionCostCap.toFixed(0));
         statHeavyHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.is_heavy","","color",var_99.isHeavy ? COLOR_ORANGE : COLOR_GREEN,"bool",var_99.isHeavy ? localization.getLocalization("wiredmenu.bool.yes") : localization.getLocalization("wiredmenu.bool.no"));
         statFloorCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.floorfurni","","color",floorItemStatColor,"amount",var_99.floorItemCount,"limit",var_99.floorItemCap);
         statWallCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.wallfurni","","color",wallItemStatColor,"amount",var_99.wallItemCount,"limit",var_99.wallItemCap);
         statPermFurniVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_furni_vars","","color",varLimitColor(var_99.permanentFurniVariables,var_99.maxPermanentFurniVariables),"amount",var_99.permanentFurniVariables,"limit",var_99.maxPermanentFurniVariables);
         statPermUserVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_user_vars","","color",varLimitColor(var_99.permanentUserVariables,var_99.maxPermanentUserVariables),"amount",var_99.permanentUserVariables,"limit",var_99.maxPermanentUserVariables);
         statPermGlobalVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_global_vars","","color",varLimitColor(var_99.permanentGlobalVariables,var_99.maxPermanentGlobalVariables),"amount",var_99.permanentGlobalVariables,"limit",var_99.maxPermanentGlobalVariables);
      }
      
      private function get usageStatColor() : String
      {
         return colorize(var_99.executionCost,0,var_99.executionCostCap,THRESHOLD_USAGE_1,THRESHOLD_USAGE_2);
      }
      
      private function get floorItemStatColor() : String
      {
         return colorize(var_99.floorItemCount,0,var_99.floorItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function get wallItemStatColor() : String
      {
         return colorize(var_99.wallItemCount,0,var_99.wallItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function varLimitColor(param1:int, param2:int) : String
      {
         return colorize(param1,0,param2,THRESHOLD_VARS_1,THRESHOLD_VARS_2);
      }
      
      private function updateErrorLogsUI() : void
      {
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc2_ in var_1295)
         {
            _loc1_.push(new ErrorDataTableObject(this,_loc2_,localization));
         }
         var_2809.setObjects(_loc1_);
      }
      
      private function updateImageUI() : void
      {
         var _loc1_:Boolean = isFrankPanicking;
         monitorImage1.visible = !_loc1_;
         monitorImage2.visible = _loc1_;
      }
      
      private function get isFrankPanicking() : Boolean
      {
         if(var_99.isHeavy)
         {
            return true;
         }
         if(usageStatColor != COLOR_GREEN || floorItemStatColor != COLOR_GREEN || wallItemStatColor != COLOR_GREEN)
         {
            return true;
         }
         return hasErrors;
      }
      
      internal function onErrorLinkClicked(param1:class_4089) : void
      {
         if(var_1400 == null)
         {
            var_1400 = new WiredErrorInfoView(controller);
         }
         var_1400.initialize(param1);
         var_1400.show();
      }
      
      private function updateButtonsUI() : void
      {
         Util.disableSection(logOverviewButton,!controller.hasReadPermission);
         var _loc1_:* = getTimer() < var_4656 + CLEAR_LOGS_TIMEOUT;
         Util.disableSection(clearButton,!controller.hasWritePermission || _loc1_);
      }
      
      private function get hasErrors() : Boolean
      {
         for each(var _loc1_ in var_1295)
         {
            if(_loc1_.throwCount > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function permissionsUpdated() : void
      {
         updateButtonsUI();
      }
      
      private function onClickMonitor(param1:WindowMouseEvent) : void
      {
         if(param1.localX < 14 || param1.localX > 61 || param1.localY < 45 || param1.localY > 107)
         {
            return;
         }
         controller.send(new ProgressTreasureHuntMessageComposer("wf15",(param1.window as IStaticBitmapWrapperWindow).assetUri));
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var _loc2_:int = getTimer();
         if(var_4210 < _loc2_ - POLL_MONITOR_MS)
         {
            requestData();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_1400 != null)
         {
            var_1400.dispose();
            var_1400 = null;
         }
         var_2809.dispose();
         var_1295 = null;
         var_99 = null;
         super.dispose();
      }
      
      private function get statWiredUsageHtml() : class_1899
      {
         return container.findChildByName("statistics_usage_html") as class_1899;
      }
      
      private function get statHeavyHtml() : class_1899
      {
         return container.findChildByName("statistics_heavy_html") as class_1899;
      }
      
      private function get statFloorCountHtml() : class_1899
      {
         return container.findChildByName("statistics_floorfurni_html") as class_1899;
      }
      
      private function get statWallCountHtml() : class_1899
      {
         return container.findChildByName("statistics_wallfurni_html") as class_1899;
      }
      
      private function get statPermFurniVarsHtml() : class_1899
      {
         return container.findChildByName("statistics_perm_vars_furni_html") as class_1899;
      }
      
      private function get statPermUserVarsHtml() : class_1899
      {
         return container.findChildByName("statistics_perm_vars_user_html") as class_1899;
      }
      
      private function get statPermGlobalVarsHtml() : class_1899
      {
         return container.findChildByName("statistics_perm_vars_global_html") as class_1899;
      }
      
      private function get logTableContainer() : class_1812
      {
         return container.findChildByName("log_table_container") as class_1812;
      }
      
      private function get clearButton() : class_1775
      {
         return container.findChildByName("clear_log_btn") as class_1775;
      }
      
      private function get logOverviewButton() : class_1775
      {
         return container.findChildByName("log_overview_btn") as class_1775;
      }
      
      private function get monitorImage1() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_1") as IStaticBitmapWrapperWindow;
      }
      
      private function get monitorImage2() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_2") as IStaticBitmapWrapperWindow;
      }
   }
}

