package com.sulake.habbo.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.help.guidehelp.GuideSessionController;
   import com.sulake.habbo.help.guidehelp.HelpController;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_175.class_3018;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   
   public class GuideHelpManager implements class_13
   {
      
      private var _habboHelp:HabboHelp;
      
      private var var_1496:HelpController;
      
      private var var_1268:GuideSessionController;
      
      private var var_1925:ChatReviewReporterFeedbackCtrl;
      
      private var _disposed:Boolean = false;
      
      private var var_4059:Boolean;
      
      private var var_5403:int;
      
      private var _panicRoomName:String;
      
      private var var_1510:Timer;
      
      public function GuideHelpManager(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         var_1496 = new HelpController(this);
         var_1268 = new GuideSessionController(this);
         var_1925 = new ChatReviewReporterFeedbackCtrl(_habboHelp);
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
      }
      
      public function get habboHelp() : HabboHelp
      {
         return _habboHelp;
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(_habboHelp.newUserTourEnabled && _habboHelp.newIdentity && !var_4059 && !_habboHelp.sessionDataManager.isRealNoob)
         {
            var_1510 = new Timer(getTourPopupDelay(),1);
            var_1510.addEventListener("timer",onTourPopup);
            var_1510.start();
            _habboHelp.tracking.trackEventLog("Help","","tour.new_user.create","",getTourPopupDelay());
            _habboHelp.trackGoogle("newbieTourWindow","timer_popupCreated");
         }
      }
      
      private function onTourPopup(param1:TimerEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         _habboHelp.tracking.trackEventLog("Help","","tour.new_user.show","",getTourPopupDelay());
         _habboHelp.trackGoogle("newbieTourWindow","timer_popupShown");
         openTourPopup();
      }
      
      public function openTourPopup() : void
      {
         var_1496.openTourPopup();
         var_4059 = true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_1496)
         {
            var_1496.dispose();
            var_1496 = null;
         }
         if(var_1268)
         {
            var_1268.dispose();
            var_1268 = null;
         }
         if(var_1925)
         {
            var_1925.dispose();
            var_1925 = null;
         }
         if(var_1510)
         {
            var_1510.reset();
            var_1510 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showGuideTool() : void
      {
         var_1268.showGuideTool();
      }
      
      public function showPendingTicket(param1:class_3018) : void
      {
         var_1496.showPendingTicket(param1);
      }
      
      public function createHelpRequest(param1:uint) : void
      {
         var_1268.createHelpRequest(param1);
      }
      
      public function openReportWindow() : void
      {
         var_1268.openReportWindow();
      }
      
      public function showFeedback(param1:String) : void
      {
         var_1925.show(param1);
      }
      
      private function getTourPopupDelay() : int
      {
         return _habboHelp.getInteger("guide.help.new.user.tour.popup.delay",30) * 1000;
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            switch(param1.iconId)
            {
               case "HTIE_ICON_HELP":
                  _habboHelp.toggleNewHelpWindow();
                  break;
               case "HTIE_ICON_GUIDE":
                  showGuideTool();
            }
         }
      }
   }
}

