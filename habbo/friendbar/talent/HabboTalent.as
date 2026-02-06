package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.IHabboTalent;
   import com.sulake.habbo.friendbar.view.AbstractView;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboAvatarEditor;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.habbo.communication.messages.parser.talent.class_3355;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   
   public class HabboTalent extends AbstractView implements IHabboTalent, ILinkEventTracker
   {
      
      private var _talentTrack:TalentTrackController;
      
      private var _talentLevelUp:TalentLevelUpController;
      
      private var _talentPromo:TalentPromoCtrl;
      
      private var _citizenshipPopup:CitizenshipPopupController;
      
      private var _communicationManager:class_57;
      
      private var _habboHelp:IHabboHelp;
      
      private var _navigator:class_41;
      
      private var _toolbar:IHabboToolbar;
      
      private var _avatarEditor:class_141;
      
      public function HabboTalent(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get sessionManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get habboTalentEnabled() : Boolean
      {
         return getBoolean("talent.track.enabled");
      }
      
      public function get citizenshipEnabled() : Boolean
      {
         return getBoolean("talent.track.citizenship.enabled");
      }
      
      public function get newUserTourEnabled() : Boolean
      {
         return getBoolean("guide.help.new.user.tour.enabled");
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get avatarEditor() : class_141
      {
         return _avatarEditor;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_141):void
         {
            _avatarEditor = param1;
         })]);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_talentLevelUp)
            {
               _talentLevelUp.dispose();
               _talentLevelUp = null;
            }
            if(_talentTrack)
            {
               _talentTrack.dispose();
               _talentTrack = null;
            }
            if(_talentPromo)
            {
               _talentPromo.dispose();
               _talentPromo = null;
            }
            if(_citizenshipPopup != null)
            {
               _citizenshipPopup.dispose();
               _citizenshipPopup = null;
            }
            context.removeLinkEventTracker(this);
            super.dispose();
         }
      }
      
      override protected function initComponent() : void
      {
         if(!habboTalentEnabled)
         {
            return;
         }
         _talentTrack = new TalentTrackController(this);
         _talentLevelUp = new TalentLevelUpController(this);
         _talentPromo = new TalentPromoCtrl(this);
         if(citizenshipEnabled)
         {
            _citizenshipPopup = new CitizenshipPopupController(this);
         }
         context.addLinkEventTracker(this);
         _talentTrack.initialize();
         _talentLevelUp.initialize();
         _talentPromo.initialize();
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : class_1741
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:class_1741 = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboTalent","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getModalXmlWindow(param1:String) : IModalDialog
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IModalDialog = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildModalDialogFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboTalent","Failed to build window " + param1 + "_xml, " + _loc4_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc3_;
      }
      
      public function testLevelUp(param1:String, param2:class_3355) : void
      {
         _talentLevelUp.showWindow(param1,param2.level,param2.rewardPerks,param2.rewardProducts);
      }
      
      public function get linkPattern() : String
      {
         return "talent/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc4_:* = _loc2_[1];
         if("open" !== _loc4_)
         {
            class_21.log("Catalog unknown link-type receive: " + _loc2_[1]);
         }
         else if(_loc2_.length > 2)
         {
            _loc3_ = _loc2_[2];
            switch(_loc3_)
            {
               case "citizenship":
                  _tracking.trackTalentTrackOpen("citizenship","citizenshiplink");
                  send(new GetTalentTrackMessageComposer("citizenship"));
                  break;
               case "helper":
                  _tracking.trackTalentTrackOpen("helper","helperlink");
                  send(new GetTalentTrackMessageComposer("helper"));
            }
         }
      }
   }
}

