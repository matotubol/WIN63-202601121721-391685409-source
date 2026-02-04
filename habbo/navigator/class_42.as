package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.inroom.RoomEventInfoCtrl;
   import com.sulake.habbo.navigator.inroom.RoomEventViewCtrl;
   import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
   import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
   import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
   import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public interface class_42 extends class_41
   {
      
      function get assets() : class_40;
      
      function get windowManager() : class_38;
      
      function get data() : NavigatorData;
      
      function get mainViewCtrl() : ITransitionalMainViewCtrl;
      
      function get tabs() : Tabs;
      
      function get roomInfoViewCtrl() : RoomInfoViewCtrl;
      
      function get roomCreateViewCtrl() : RoomCreateViewCtrl;
      
      function get communication() : class_57;
      
      function get roomSettingsCtrl() : RoomSettingsCtrl;
      
      function get sessionData() : ISessionDataManager;
      
      function get passwordInput() : GuestRoomPasswordInput;
      
      function get doorbell() : GuestRoomDoorbell;
      
      function get roomEventViewCtrl() : RoomEventViewCtrl;
      
      function get localization() : class_27;
      
      function get officialRoomEntryManager() : OfficialRoomEntryManager;
      
      function get toolbar() : IHabboToolbar;
      
      function get habboHelp() : IHabboHelp;
      
      function get roomEventInfoCtrl() : RoomEventInfoCtrl;
      
      function get roomFilterCtrl() : RoomFilterCtrl;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get enforceCategoryCtrl() : EnforceCategoryCtrl;
      
      function send(param1:IMessageComposer, param2:Boolean = false) : void;
      
      function getXmlWindow(param1:String, param2:uint = 1) : class_1741;
      
      function getText(param1:String) : String;
      
      function registerParameter(param1:String, param2:String, param3:String) : String;
      
      function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : class_2251;
      
      function refreshButton(param1:class_1812, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void;
      
      function getButtonImage(param1:String, param2:String = "_png") : BitmapData;
      
      function openCatalogClubPage(param1:String) : void;
      
      function openCatalogRoomAdsPage() : void;
      
      function openCatalogRoomAdsExtendPage(param1:String, param2:String, param3:Date, param4:int) : void;
      
      function showFavouriteRooms() : void;
      
      function showHistoryRooms() : void;
      
      function showFrequentRooms() : void;
      
      function get tracking() : class_53;
      
      function goToMainView() : void;
      
      function goToRoom(param1:int, param2:Boolean, param3:String = "", param4:int = -1, param5:Boolean = false) : void;
      
      function isPerkAllowed(param1:String) : Boolean;
      
      function trackGoogle(param1:String, param2:String, param3:int = -1) : void;
      
      function trackNavigationDataPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void;
      
      function getBoolean(param1:String) : Boolean;
      
      function getInteger(param1:String, param2:int) : int;
      
      function getProperty(param1:String, param2:Dictionary = null) : String;
   }
}

