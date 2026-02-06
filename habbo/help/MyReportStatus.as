package com.sulake.habbo.help
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.help.reportstatus.ReportStatusTableObject;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.globalization.DateTimeFormatter;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MyCfhReportStatusMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.AppealCfhMessageComposer;
   import com.sulake.habbo.communication.messages.parser.callforhelp.MyCfhReportStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.callforhelp.class_2748;
   
   public class MyReportStatus implements class_13
   {
      
      public static var COLUMN_REPORT_DATE:String = "report_date";
      
      public static var COLUMN_REPORTED_ACCOUNT:String = "account";
      
      public static var COLUMN_REASON:String = "reason";
      
      public static var COLUMN_APPEAL_STATUS:String = "appeal_status";
      
      private var _disposed:Boolean = false;
      
      private var _window:class_1812;
      
      private var _habboHelp:HabboHelp;
      
      private var var_647:TableView;
      
      private var _shownObject:ReportStatusTableObject;
      
      private var var_1888:Boolean;
      
      private var var_264:class_2872;
      
      private var var_2437:DateTimeFormatter;
      
      public function MyReportStatus(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         var_2437 = new DateTimeFormatter("i-default");
         var_2437.setDateTimePattern("dd/MM/yyyy");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_647)
         {
            var_647.dispose();
            var_647 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _shownObject = null;
         if(var_264)
         {
            var_264.dispose();
            var_264 = null;
         }
         var_1888 = false;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function openWindow(param1:MyCfhReportStatusMessageEvent) : void
      {
         dispose();
         _disposed = false;
         _window = _habboHelp.getXmlWindow("my_reports") as class_1812;
         var_264 = _window.findChildByName("status_info_bubble") as class_2872;
         _window.desktop.addChild(var_264);
         var_264.visible = false;
         appealButton.addEventListener("WME_CLICK",onClickAppeal);
         _window.center();
         _window.procedure = windowEventHandler;
         createTable();
         var _loc2_:MyCfhReportStatusMessageEventParser = param1.getParser() as MyCfhReportStatusMessageEventParser;
         setTableObjects(_loc2_.messages);
      }
      
      public function createTable() : void
      {
         var_647 = new TableView(_habboHelp.windowManager,reportsTableContainer);
         var _loc1_:Array = [new TableColumn(COLUMN_REPORT_DATE,localize("report.status.col.report_date"),0.26,"left"),new TableColumn(COLUMN_REPORTED_ACCOUNT,localize("report.status.col.reported_account"),0.18,"left"),new TableColumn(COLUMN_REASON,localize("report.status.col.reason"),0.38,"left"),new TableColumn(COLUMN_APPEAL_STATUS,localize("report.status.col.appeal_status"),0.18,"left")];
         var_647.initialize(Vector.<TableColumn>(_loc1_),true,false);
         var_647.onRowHoveredCallback = onRowHover;
      }
      
      public function setTableObjects(param1:Vector.<class_2748>) : void
      {
         var message:class_2748;
         var messages:Vector.<class_2748> = param1;
         var tableObjects:Vector.<ITableObject> = new Vector.<ITableObject>();
         messages.sort(function(param1:class_2748, param2:class_2748):int
         {
            if(param1.creationTime > param2.creationTime)
            {
               return -1;
            }
            if(param1.creationTime < param2.creationTime)
            {
               return 1;
            }
            return 0;
         });
         for each(message in messages)
         {
            tableObjects.push(new ReportStatusTableObject(this,message));
         }
         var_647.setObjects(tableObjects);
      }
      
      public function localize(param1:String, param2:String = null) : String
      {
         return _habboHelp.localization.getLocalization(param1,param2 ?? param1);
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK" || !param2)
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            dispose();
         }
      }
      
      private function onRowHover(param1:ReportStatusTableObject) : void
      {
         if(param1 != null && _shownObject != param1 && var_1888)
         {
            setFocusRow(param1);
         }
      }
      
      public function clickInfoButton(param1:ReportStatusTableObject) : void
      {
         var_1888 = !var_1888;
         setFocusRow(var_1888 ? param1 : null);
      }
      
      private function setFocusRow(param1:ReportStatusTableObject) : void
      {
         if(param1 == _shownObject)
         {
            return;
         }
         _shownObject = param1;
         var_264.visible = _shownObject != null;
         if(var_264.visible)
         {
            refreshBubbleUI();
            relocateBubbleAndFocus();
         }
      }
      
      private function refreshBubbleUI() : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc4_:class_2748 = _shownObject.message;
         var _loc6_:* = _loc4_.appealStatus != class_2748.var_4277;
         var _loc5_:Boolean = _loc6_ ? _loc4_.appealResolutionTime != -1 : _loc4_.closeTime != -1;
         var _loc10_:String = _loc6_ ? (_loc5_ ? var_2437.format(new Date(_loc4_.appealResolutionTime)) : "-") : (_loc5_ ? var_2437.format(new Date(_loc4_.closeTime)) : "-");
         var _loc3_:String = _loc6_ ? "report.status.info.appealed" : "report.status.info.reported";
         if(_loc5_)
         {
            _loc8_ = _loc4_.sanctioned ? "report.status.info.action" : "report.status.info.no_action";
            actionDescText.text = localize(getActionExplanation(_loc4_.sanctioned,_loc4_.sanctionGivenByAutoModeration,_loc4_.appealStatus));
         }
         else
         {
            _loc8_ = "report.status.info.sanction_pending";
            actionDescText.text = "";
         }
         actionText.text = localize(_loc8_);
         createdKeyText.text = localize(_loc3_);
         var _loc1_:Number = _loc6_ ? _loc4_.appealCreationTime : _loc4_.creationTime;
         reportedDateText.text = var_2437.format(new Date(_loc1_));
         decisionDateText.text = _loc10_;
         var _loc2_:Boolean = _loc4_.appealStatus == class_2748.var_4277 && _loc5_ && !_loc4_.sanctioned;
         if(_loc2_)
         {
            appealButton.enable();
         }
         else
         {
            appealButton.disable();
         }
         if(_loc4_.sanctioned)
         {
            _loc9_ = _habboHelp.getProperty("zendesk.url");
            _loc7_ = _habboHelp.localization.getLocalizationWithParams("report.status.info.sanction_help","","url",_loc9_);
            sanctionInfoText.text = _loc7_;
            sanctionInfoText.initializeLinkStyle();
            sanctionInfoText.addEventListener("WE_LINK",onClickHtmlLink);
         }
         else
         {
            sanctionInfoText.text = "";
         }
      }
      
      private function onClickHtmlLink(param1:class_1758) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function onClickAppeal(param1:WindowMouseEvent) : void
      {
         if(_shownObject == null)
         {
            return;
         }
         _habboHelp.sendMessage(new AppealCfhMessageComposer(_shownObject.message.id));
         appealButton.disable();
      }
      
      private function getActionExplanation(param1:Boolean, param2:Boolean, param3:int) : String
      {
         if(param3 == class_2748.var_5313)
         {
            return "report.status.info.appeal.action";
         }
         if(param3 == class_2748.var_5350)
         {
            return "report.status.info.appeal.no_action";
         }
         return param2 ? (param1 ? "report.status.info.auto_moderated.action" : "report.status.info.auto_moderated.no_action") : (param1 ? "report.status.info.manually_moderated.action" : "report.status.info.manually_moderated.no_action");
      }
      
      private function relocateBubbleAndFocus() : void
      {
         var _loc1_:Rectangle = var_647.getGlobalRowRectangle(_shownObject);
         var_264.position = new Point(_loc1_.x + _loc1_.width - 2,_loc1_.y + _loc1_.height / 2 - var_264.height / 2);
         var_264.activate();
      }
      
      private function get reportsTableContainer() : class_1812
      {
         return _window.findChildByName("reports_table_cont") as class_1812;
      }
      
      private function get reportedDateText() : ITextWindow
      {
         return var_264.findChildByName("reported_date_txt") as ITextWindow;
      }
      
      private function get decisionDateText() : ITextWindow
      {
         return var_264.findChildByName("decision_date_txt") as ITextWindow;
      }
      
      private function get createdKeyText() : ITextWindow
      {
         return var_264.findChildByName("created_key_txt") as ITextWindow;
      }
      
      private function get actionText() : ITextWindow
      {
         return var_264.findChildByName("action_txt") as ITextWindow;
      }
      
      private function get actionDescText() : ITextWindow
      {
         return var_264.findChildByName("action_desc_txt") as ITextWindow;
      }
      
      private function get appealButton() : class_1775
      {
         return var_264.findChildByName("appeal_button") as class_1775;
      }
      
      private function get sanctionInfoText() : class_1899
      {
         return var_264.findChildByName("sanction_info_txt") as class_1899;
      }
   }
}

