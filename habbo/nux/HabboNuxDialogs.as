package com.sulake.habbo.nux
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.class_2597;
   import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent;
   import com.sulake.habbo.communication.messages.incoming.nux.class_3217;
   import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferEventParser;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class HabboNuxDialogs extends class_17 implements ILinkEventTracker
   {
      
      protected var _communicationManager:class_57;
      
      protected var _navigator:class_41;
      
      protected var _windowManager:class_38;
      
      protected var _localizationManager:class_27;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _roomSessionManager:IRoomSessionManager;
      
      private var var_37:IConnection;
      
      private var var_2564:NuxOfferOldUserView;
      
      private var var_2367:NuxGiftSelectionView;
      
      private var var_2553:NuxNoobRoomOfferView;
      
      private var var_1510:Timer;
      
      public function HabboNuxDialogs(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         context.removeLinkEventTracker(this);
         if(_windowManager)
         {
            _windowManager = null;
         }
         destroyGiftSelectionView();
         destroyNoobRoomOfferView();
         destroyNuxOfferView();
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         var_37 = _communicationManager.connection;
         if(var_37)
         {
            var_37.addMessageEvent(new NewUserExperienceNotCompleteEvent(onNewUserExperienceNotCompleteMessage));
            var_37.addMessageEvent(new NewUserExperienceGiftOfferEvent(onNewUserExperienceGiftOfferMessage));
         }
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "nux/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("lobbyoffer" !== _loc3_)
         {
            class_21.log("HabboNuxDialogs unknown link-type received: " + _loc2_[1]);
         }
         else if(_loc2_.length > 2 && _loc2_[2] == "show")
         {
            createNoobRoomOfferView();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function onVerify() : void
      {
         var_37.send(new SetPhoneNumberVerificationStatusMessageComposer(0));
      }
      
      public function onReject() : void
      {
         _windowManager.confirm("${phone.number.never.again.confirm.title}","${phone.number.never.again.confirm.text}",0,onNeverAgainConfirmClose);
      }
      
      private function onNeverAgainConfirmClose(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK" && var_37)
         {
            destroyNuxOfferView();
            var_37.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
         }
      }
      
      public function onSendGetGifts(param1:Vector.<class_2597>) : void
      {
         destroyGiftSelectionView();
         var_37.send(new NewUserExperienceGetGiftsMessageComposer(param1));
      }
      
      private function onNewUserExperienceNotCompleteMessage(param1:NewUserExperienceNotCompleteEvent) : void
      {
         createNuxOfferView();
      }
      
      private function onNewUserExperienceGiftOfferMessage(param1:NewUserExperienceGiftOfferEvent) : void
      {
         var _loc2_:NewUserExperienceGiftOfferEventParser = param1.getParser();
         createGiftSelectionView(_loc2_.giftOptions);
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         var _loc2_:* = 0;
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         if(param1.type == "RSE_STARTED" && param1.session && param1.session.roomId == _navigator.homeRoomId)
         {
            _loc2_ = getInteger("nux.noob.lobby.popup.delay",70) * 1000;
            var_1510 = new Timer(_loc2_,1);
            var_1510.addEventListener("timer",createNoobRoomOfferView);
            var_1510.start();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get configuration() : class_16
      {
         return this;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function createNuxOfferView() : void
      {
         destroyNuxOfferView();
         var_2564 = new NuxOfferOldUserView(this);
      }
      
      public function destroyNuxOfferView() : void
      {
         if(var_2564)
         {
            var_2564.dispose();
            var_2564 = null;
         }
      }
      
      private function createGiftSelectionView(param1:Vector.<class_3217>) : void
      {
         destroyGiftSelectionView();
         var_2367 = new NuxGiftSelectionView(this,param1);
      }
      
      private function destroyGiftSelectionView() : void
      {
         if(var_2367)
         {
            var_2367.dispose();
            var_2367 = null;
         }
      }
      
      private function startNoobRoomOfferTimer() : void
      {
      }
      
      private function createNoobRoomOfferView(param1:TimerEvent = null) : void
      {
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         destroyNoobRoomOfferView();
         var_2553 = new NuxNoobRoomOfferView(this);
         var_37.send(new EventLogMessageComposer("NewNavigator","nux.offer.lobby","nux.offer.lobby"));
      }
      
      public function destroyNoobRoomOfferView() : void
      {
         if(var_1510)
         {
            var_1510.reset();
            var_1510 = null;
         }
         if(var_2553)
         {
            var_2553.dispose();
            var_2553 = null;
         }
      }
   }
}

