package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.clubcenter.util.BadgeResolver;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.Stage;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEventParser;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_3429;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.users.ScrGetKickbackInfoMessageComposer;
   
   public class HabboClubCenter extends class_17 implements ILinkEventTracker, IOfferExtension
   {
      
      private static const USE_FAKE_DATA:Boolean = false;
      
      private static const DATA_UPDATE_INTERVAL_MSEC:int = 10000;
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:class_48;
      
      private var _windowManager:class_38;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _offerCenter:IOfferCenter;
      
      private var var_2683:Boolean = false;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_18:ClubCenterView;
      
      private var var_2001:ClubSpecialInfoBubbleView;
      
      private var var_24:class_3429;
      
      private var var_3833:int = -10000;
      
      private var var_2187:Boolean = false;
      
      private var var_605:String;
      
      private var var_2402:int;
      
      private var var_2561:Vector.<class_55>;
      
      public function HabboClubCenter(param1:class_15, param2:uint = 0, param3:class_40 = null)
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
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
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
         addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
         addMessageEvent(new ScrSendKickbackInfoMessageEvent(onKickbackInfoMessageEvent));
         addMessageEvent(new BadgesEvent(onBadges));
         context.addLinkEventTracker(this);
         if(getBoolean("offers.enabled") && getBoolean("offers.habboclub.enabled"))
         {
            _offerCenter = catalog.getOfferCenter(this);
         }
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
         if(_sessionDataManager != null && _sessionDataManager.events)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         }
         if(_offerCenter != null)
         {
            _offerCenter = null;
         }
         removeView();
         var_24 = null;
         _messageEvents = null;
         super.dispose();
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
            if("hccenter" === _loc3_)
            {
               showClubCenter();
            }
         }
      }
      
      private function showClubCenter() : void
      {
         if(!var_18)
         {
            var_18 = new ClubCenterView(this,_windowManager,_sessionDataManager.figure);
         }
         if(updateNeeded())
         {
            updateData();
         }
         else
         {
            populate();
         }
         if(_offerCenter && var_18 && var_2683)
         {
            var_2683 = false;
            indicateVideoAvailable(true);
         }
      }
      
      public function removeView() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         removeBreakdown();
         var_2187 = false;
      }
      
      public function removeBreakdown() : void
      {
         if(var_2001)
         {
            var_2001.dispose();
            var_2001 = null;
         }
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onKickbackInfoMessageEvent(param1:ScrSendKickbackInfoMessageEvent) : void
      {
         var _loc2_:ScrSendKickbackInfoMessageEventParser = param1.getParser();
         var_24 = _loc2_.data;
         var_2187 = false;
         var_3833 = getTimer();
         populate();
      }
      
      private function onClubGiftInfo(param1:ClubGiftInfoEvent) : void
      {
         var_2402 = param1.getParser().giftsAvailable;
         populate();
      }
      
      private function onBadgeReady(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != var_605 || !_sessionDataManager)
         {
            return;
         }
         _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         populate();
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc3_:BadgesEventParser = (param1 as BadgesEvent).getParser();
         if(var_2561 == null)
         {
            var_2561 = new Vector.<class_55>(_loc3_.totalFragments,true);
         }
         var _loc4_:class_55 = new class_55();
         _loc4_.concatenate(_loc3_.currentFragment);
         var _loc2_:class_55 = addMessageFragment(_loc4_,_loc3_.totalFragments,_loc3_.fragmentNo,var_2561);
         if(!_loc2_)
         {
            return;
         }
         var_2561 = null;
         var_605 = BadgeResolver.resolveClubBadgeId(_loc2_.getKeys());
      }
      
      private function updateNeeded() : Boolean
      {
         return !var_2187 && getTimer() - var_3833 > 10000;
      }
      
      private function updateData() : void
      {
         var_2187 = true;
         _communicationManager.connection.send(new GetBadgesComposer());
         _communicationManager.connection.send(new GetClubGiftMessageComposer());
         _communicationManager.connection.send(new ScrGetKickbackInfoMessageComposer());
      }
      
      private function populate() : void
      {
         if(var_18)
         {
            var_18.dataReceived(var_24,getPurse(),getGiftsAvailable(),BadgeResolver.resolveBadgeBitmap(var_605,onBadgeReady,_sessionDataManager));
         }
      }
      
      private function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function getPurse() : class_1831
      {
         return catalog != null ? catalog.getPurse() : null;
      }
      
      private function getGiftsAvailable() : int
      {
         return var_2402;
      }
      
      public function get localization() : class_27
      {
         return catalog != null ? catalog.localization : null;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function resolveClubStatus() : String
      {
         if(!catalog)
         {
            return "none";
         }
         var _loc1_:class_1831 = getPurse();
         if(_loc1_.clubDays > 0)
         {
            return "active";
         }
         if(_loc1_.pastClubDays > 0 || _loc1_.pastVipDays > 0)
         {
            return "expired";
         }
         return "none";
      }
      
      public function openPurchasePage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      public function openClubGiftPage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("club_gifts","NORMAL");
         }
      }
      
      public function showPaydayBreakdownView() : void
      {
         if(var_2001)
         {
            removeBreakdown();
            return;
         }
         var_2001 = new ClubSpecialInfoBubbleView(this,_windowManager,var_24,var_18.getSpecialCalloutAnchor());
      }
      
      public function openPaydayHelpPage() : void
      {
         context.createLinkEvent("habbopages/hcpayday");
      }
      
      public function openHelpPage() : void
      {
         context.createLinkEvent("habbopages/habboclub");
      }
      
      public function processHotelLink(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
      
      public function isKickbackEnabled() : Boolean
      {
         var _loc1_:String = getProperty("hccenter.activity.enabled");
         if(_loc1_ == null || _loc1_ == "")
         {
            return true;
         }
         return _loc1_ == "1" || _loc1_ == "true";
      }
      
      public function get stage() : Stage
      {
         return context && context.displayObjectContainer ? context.displayObjectContainer.stage : null;
      }
      
      public function getOffers() : void
      {
         _catalog.getHabboClubOffers(3);
      }
      
      public function get offerCenter() : IOfferCenter
      {
         return _offerCenter;
      }
      
      public function indicateRewards() : void
      {
      }
      
      public function indicateVideoAvailable(param1:Boolean) : void
      {
         if(var_18)
         {
            var_18.setVideoOfferButtonVisibility(param1,_offerCenter != null && !_offerCenter.showingVideo);
         }
         else
         {
            var_2683 = param1;
         }
      }
      
      private function addMessageFragment(param1:class_55, param2:int, param3:int, param4:Vector.<class_55>) : class_55
      {
         if(param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each(var _loc5_ in param4)
         {
            if(_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:class_55 = new class_55();
         for each(var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
   }
}

