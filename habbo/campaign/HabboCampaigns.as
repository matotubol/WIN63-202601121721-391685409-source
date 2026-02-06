package com.sulake.habbo.campaign
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.campaign.calendar.CalendarView;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorAsStaffComposer;
   import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorComposer;
   import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDoorOpenedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDoorOpenedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.campaign.class_2349;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageEventParser;
   
   public class HabboCampaigns extends class_17 implements ILinkEventTracker
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1207:CalendarView;
      
      private var var_551:class_2349;
      
      private var var_2110:int = -1;
      
      private var var_3761:Boolean = false;
      
      public function HabboCampaigns(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDataMessageEvent(onCampaignCalendarDataMessageEvent));
         _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDoorOpenedMessageEvent(onCampaignCalendarDoorOpenedMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function onCampaignCalendarDataMessageEvent(param1:CampaignCalendarDataMessageEvent) : void
      {
         var _loc2_:CampaignCalendarDataMessageEventParser = param1.getParser();
         var_551 = _loc2_.cloneData();
      }
      
      private function onCampaignCalendarDoorOpenedMessageEvent(param1:CampaignCalendarDoorOpenedMessageEvent) : void
      {
         var _loc2_:CampaignCalendarDoorOpenedMessageEventParser = param1.getParser();
         if(_loc2_.doorOpened)
         {
            showProductNotification(_loc2_.productName,_loc2_.customImage,_loc2_.furnitureClassName);
         }
      }
      
      public function openPackage(param1:int) : void
      {
         var_2110 = param1;
         _communicationManager.connection.send(new OpenCampaignCalendarDoorComposer(var_551.campaignName,param1));
      }
      
      public function openPackageAsStaff(param1:int) : void
      {
         var_2110 = param1;
         _communicationManager.connection.send(new OpenCampaignCalendarDoorAsStaffComposer(var_551.campaignName,param1));
      }
      
      private function showProductNotification(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:class_1949 = _sessionDataManager.getProductData(param1);
         if(_loc4_ != null)
         {
            var_551.openedDays.push(var_2110);
            var_2110 = -1;
            if(param2 && param2 != "")
            {
               var_1207.setReceivedProduct(_loc4_,getImageGalleryUrl() + param2);
            }
            else if(param3 && param3 != "")
            {
               var_1207.setReceivedProduct(_loc4_);
               requestIconFromRoomEngine(var_1207,param3);
            }
         }
      }
      
      private function requestIconFromRoomEngine(param1:class_1829, param2:String) : class_2198
      {
         var _loc4_:class_1800 = null;
         _loc4_ = _sessionDataManager.getFloorItemDataByName(param2);
         if(_loc4_)
         {
            var _loc3_:class_2198 = _roomEngine.getFurnitureIcon(_loc4_.id,param1);
         }
         else
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param2);
            if(_loc4_)
            {
               _loc3_ = _roomEngine.getWallItemIcon(_loc4_.id,param1);
            }
         }
         return null;
      }
      
      public function get linkPattern() : String
      {
         return "openView/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "calendar")
         {
            showCalendar();
         }
      }
      
      private function showCalendar() : void
      {
         if(!var_1207 && var_551)
         {
            var_1207 = new CalendarView(this,_windowManager);
         }
      }
      
      public function hideCalendar() : void
      {
         if(var_1207)
         {
            var_1207.dispose();
            var_1207 = null;
         }
      }
      
      private function getImageGalleryUrl() : String
      {
         return getProperty("image.library.url");
      }
      
      public function get calendarData() : class_2349
      {
         return var_551;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return _sessionDataManager.isAnyRoomController;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
   }
}

