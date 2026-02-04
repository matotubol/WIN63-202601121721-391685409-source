package com.sulake.habbo.catalog.earnings
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import package_129.class_2469;
   import package_129.class_2915;
   import package_129.class_2930;
   import package_158.class_2697;
   import package_158.class_3206;
   import package_158.class_3482;
   
   public class EarningsController extends class_17 implements ILinkEventTracker, class_1839
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _notifications:class_536;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_18:EarningsView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_4397:Boolean = true;
      
      private var var_1302:Boolean = false;
      
      public function EarningsController(param1:class_15, param2:uint = 0, param3:class_40 = null)
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
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_2930(onIncomeRewardStatusMessageEvent));
         addMessageEvent(new class_2915(onIncomeRewardClaimResponseMessageEvent));
         addMessageEvent(new class_2469(onIncomeRewardNotificationMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onIncomeRewardStatusMessageEvent(param1:class_2930) : void
      {
         var _loc3_:class_3482 = param1.getParser();
         if(var_18 && !var_18.disposed)
         {
            var_18.onIncomeRewardDataReceived(_loc3_.data);
         }
         if(var_4397)
         {
            var_4397 = false;
            for each(var _loc2_ in _loc3_.data)
            {
               if(_loc2_.rewardType != 0 && _loc2_.amount > 0)
               {
                  var_1302 = true;
                  break;
               }
            }
            if(var_1302)
            {
               _toolbar.refreshPurseAreaIndicators();
            }
         }
      }
      
      private function onIncomeRewardClaimResponseMessageEvent(param1:class_2915) : void
      {
         var _loc2_:class_2697 = null;
         if(var_18 && !var_18.disposed)
         {
            _loc2_ = param1.getParser();
            var_18.onIncomeRewardClaimResponse(_loc2_.rewardCategory,_loc2_.result);
         }
      }
      
      private function onIncomeRewardNotificationMessageEvent(param1:class_2469) : void
      {
         _notifications.addItem("${notification.earning.new}","earning",null,"habboUI/open/vault");
         if(var_18)
         {
            _sessionDataManager.getIncomeRewardStatus();
         }
         if(!var_18 || var_18.disposed)
         {
            var_1302 = true;
            _toolbar.refreshPurseAreaIndicators();
         }
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function openCatalogue() : void
      {
         context.createLinkEvent("catalog/open");
      }
      
      public function get linkPattern() : String
      {
         return "habboUI/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            var _loc3_:* = _loc2_[2];
            if("vault" === _loc3_)
            {
               showEarnings();
            }
         }
      }
      
      public function withdrawVaultCredits() : void
      {
         _sessionDataManager.withdrawCreditVault();
      }
      
      public function claimReward(param1:int) : void
      {
         _sessionDataManager.claimReward(param1);
      }
      
      private function showEarnings() : void
      {
         if(var_1302)
         {
            var_1302 = false;
            _toolbar.refreshPurseAreaIndicators();
         }
         _sessionDataManager.getIncomeRewardStatus();
         if(!var_18 || var_18.disposed)
         {
            var_18 = new EarningsView(this,_windowManager);
         }
      }
      
      public function get showingIndicator() : Boolean
      {
         return var_1302;
      }
      
      public function removeView() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      override public function dispose() : void
      {
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         removeView();
         _messageEvents = null;
         super.dispose();
      }
   }
}

