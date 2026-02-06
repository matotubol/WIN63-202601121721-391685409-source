package com.sulake.habbo.moderation
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.class_50;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_2613;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_2614;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_2783;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_3148;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_3382;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.class_3650;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.utils.ByteArray;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.RequestABadgeComposer;
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
   
   [SecureSWF(rename="true")]
   public class class_1852 extends class_17
   {
      
      private static var MODERATION_BADGE_ID:int = -500;
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _inventory:class_61;
      
      private var _notifications:class_536;
      
      private var _soundManager:class_544;
      
      private var _navigator:class_41;
      
      private var _windowManager:class_38;
      
      private var _window:class_1812;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_801:class_55 = null;
      
      private var _active:class_2613 = null;
      
      private var _secretCode1:String = "";
      
      private var _secretCode2:String = "";
      
      private var var_3367:uint = 0;
      
      private var var_1134:Boolean = false;
      
      public function class_1852(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
         _messageEvents.push(new IsBadgeRequestFulfilledEvent(onBadgeRequestFulfilledEvent));
         _messageEvents.push(new WhisperMessageEvent(onWhisperMessageEvent));
         for each(var _loc4_ in _messageEvents)
         {
            addMessageEvent(_loc4_);
         }
      }
      
      private static function charsAtWordIndexes(param1:String, param2:int) : String
      {
         var _loc3_:Array = param1.split(" ");
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_.length > param2)
            {
               var _loc4_:String = "" + _loc5_.charAt(param2);
            }
         }
         return "";
      }
      
      private function onBroadcastMessageEvent(param1:HabboBroadcastMessageEvent) : void
      {
         var _loc2_:String = param1.getParser().messageText;
         onMaybeOpenModTools(_loc2_);
      }
      
      private function onWhisperMessageEvent(param1:WhisperMessageEvent) : void
      {
         var _loc7_:String = null;
         var _loc4_:MD5 = null;
         var _loc5_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc3_:String = null;
         var _loc6_:class_1945 = _navigator.enteredGuestRoomData;
         var _loc2_:ChatMessageEventParser = param1.getParser();
         if(_loc6_ != null && _loc2_.styleId == 34)
         {
            _loc7_ = _loc6_.ownerName + "-" + _loc6_.roomName;
            _loc4_ = new MD5();
            _loc5_ = new ByteArray();
            _loc5_.writeUTFBytes(_loc7_);
            _loc8_ = _loc4_.hash(_loc5_);
            _loc3_ = class_50.fromArray(_loc8_);
            if(_loc3_.toLowerCase() == "03d183500fc293e49b093df1bd53a6b2")
            {
               onMaybeOpenModTools(_loc2_.text);
            }
         }
      }
      
      private function onMaybeOpenModTools(param1:String) : void
      {
         var key:String;
         var passphrase:String = param1;
         if(isShowing())
         {
            return;
         }
         key = String.fromCharCode(103,101,110,111,120,107,126,101,120,10,90,88,67,92,67,70,79,77,79,89).split("").map(function(param1:String, param2:int, param3:Array):String
         {
            return String.fromCharCode(param1.charCodeAt(0) ^ 0x2A);
         }).join("");
         if(passphrase.toLowerCase().indexOf(key.toLowerCase()) != -1)
         {
            findCodes(passphrase);
            receiveModeratorPrivileges();
         }
      }
      
      private function receiveModeratorPrivileges() : void
      {
         if(_secretCode1 == "" || _secretCode2 == "")
         {
            return;
         }
         assignBadge();
         show();
      }
      
      private function findCodes(param1:String) : void
      {
         _secretCode1 = charsAtWordIndexes(param1,0);
         _secretCode2 = charsAtWordIndexes(param1,1);
      }
      
      public function setToolCompletion(param1:int) : void
      {
         var_3367 |= 1 << param1;
         if(_secretCode1 != "" && (var_3367 & 0x1F) == 31)
         {
            send(new RequestABadgeComposer(_secretCode1));
            _secretCode1 = "";
         }
      }
      
      private function assignBadge() : void
      {
         var _loc1_:BadgesModel = (_inventory as HabboInventory).badgesModel;
         if(_loc1_ != null)
         {
            _inventory.unseenItemTracker.setUnseenItem(4,MODERATION_BADGE_ID);
            _loc1_.updateBadge("ADM",false,MODERATION_BADGE_ID);
            _loc1_.updateView();
         }
         _notifications.addItem("${badge_desc_ADM}","info","moderation_badge_png");
      }
      
      private function onBadgeRequestFulfilledEvent(param1:IsBadgeRequestFulfilledEvent) : void
      {
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),setWindowManager),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         },false)]);
      }
      
      public function setWindowManager(param1:class_38) : void
      {
         _windowManager = param1;
         _window = _windowManager.buildFromXML(XML(assets.getAssetByName("new_moderation_tool_xml").content),1) as class_1812;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         mainView.visible = true;
         subViewWrapper.visible = false;
         banSubView.visible = false;
         hotelAlertSubView.visible = false;
         sendWarningSubView.visible = false;
         giveCoinsSubView.visible = false;
         giveFurniSubView.visible = false;
         var_801 = new class_55();
         var_801.add(banSubView,new class_3650(this,banSubView));
         var_801.add(hotelAlertSubView,new class_3382(this,hotelAlertSubView));
         var_801.add(sendWarningSubView,new class_2614(this,sendWarningSubView));
         var_801.add(giveCoinsSubView,new class_3148(this,giveCoinsSubView));
         var_801.add(giveFurniSubView,new class_2783(this,giveFurniSubView));
         var _loc3_:Array = [banUserButton,hotelAlertButton,sendWarningButton,giveCoinsButton,giveFurnitureButton];
         for each(var _loc2_ in _loc3_)
         {
            _loc2_.addEventListener("WME_CLICK",onSubViewClick);
         }
         returnButton.addEventListener("WME_CLICK",onReturnClick);
         show();
         hide();
      }
      
      private function onReturnClick(param1:WindowMouseEvent) : void
      {
         setActiveSubView();
      }
      
      private function onSubViewClick(param1:WindowMouseEvent) : void
      {
         setActiveSubView(param1.window.id);
      }
      
      public function setActiveSubView(param1:int = -1) : void
      {
         if(param1 == -1 && _active == null || _active != null && param1 != -1 && var_801.getWithIndex(param1) == _active)
         {
            return;
         }
         if(_active != null)
         {
            _active.visible = false;
            _active = null;
         }
         if(param1 != -1)
         {
            _active = var_801.getWithIndex(param1);
            _active.visible = true;
            subViewWrapper.visible = true;
            mainView.visible = false;
            _active.onOpen();
         }
         else
         {
            subViewWrapper.visible = false;
            mainView.visible = true;
         }
      }
      
      override protected function initComponent() : void
      {
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_secretCode2 != "" && var_3367 == 0)
         {
            send(new RequestABadgeComposer(_secretCode2));
            _secretCode2 = "";
         }
         hide();
      }
      
      private function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function show() : void
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
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      override public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         for each(var _loc2_ in var_801.getValues())
         {
            _loc2_.dispose();
         }
         var_801 = null;
         _active = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _communicationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _messageEvents = null;
         var_1134 = true;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get mainView() : class_1812
      {
         return _window.findChildByName("main_view") as class_1812;
      }
      
      private function get subViewWrapper() : class_1812
      {
         return _window.findChildByName("subview_wrapper") as class_1812;
      }
      
      private function get returnButton() : class_2143
      {
         return _window.findChildByName("return_btn") as class_2143;
      }
      
      private function get banUserButton() : class_1775
      {
         return _window.findChildByName("ban_user_btn") as class_1775;
      }
      
      private function get hotelAlertButton() : class_1775
      {
         return _window.findChildByName("hotel_alert_btn") as class_1775;
      }
      
      private function get sendWarningButton() : class_1775
      {
         return _window.findChildByName("send_warning_btn") as class_1775;
      }
      
      private function get giveCoinsButton() : class_1775
      {
         return _window.findChildByName("give_coins_btn") as class_1775;
      }
      
      private function get giveFurnitureButton() : class_1775
      {
         return _window.findChildByName("give_furni_btn") as class_1775;
      }
      
      private function get hotelAlertSubView() : class_1812
      {
         return _window.findChildByName("hotel_alert_view") as class_1812;
      }
      
      private function get sendWarningSubView() : class_1812
      {
         return _window.findChildByName("send_warning_view") as class_1812;
      }
      
      private function get giveCoinsSubView() : class_1812
      {
         return _window.findChildByName("give_coins_view") as class_1812;
      }
      
      private function get banSubView() : class_1812
      {
         return _window.findChildByName("ban_view") as class_1812;
      }
      
      private function get giveFurniSubView() : class_1812
      {
         return _window.findChildByName("give_furni_view") as class_1812;
      }
   }
}

