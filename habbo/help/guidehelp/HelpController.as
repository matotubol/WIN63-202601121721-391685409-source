package com.sulake.habbo.help.guidehelp
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.help.GuideHelpManager;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3111;
   import flash.utils.getTimer;
   import package_175.class_3018;
   
   public class HelpController implements class_13
   {
      
      private var _habboHelp:HabboHelp;
      
      private var _guideHelp:GuideHelpManager;
      
      private var _disposed:Boolean = false;
      
      private var var_607:IModalDialog;
      
      private var _tourPopup:class_1812;
      
      private var _tourPopupShowTime:int;
      
      private var var_574:class_1812;
      
      public function HelpController(param1:GuideHelpManager)
      {
         super();
         _habboHelp = param1.habboHelp;
         _guideHelp = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         closeTourPopup();
         _habboHelp = null;
         _guideHelp = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function openWindow() : void
      {
         if(var_607 == null && !disposed)
         {
            var_607 = _guideHelp.habboHelp.getModalXmlWindow("main_help");
            var_607.rootWindow.procedure = windowEventProcedure;
         }
      }
      
      public function closeWindow() : void
      {
         if(var_607 != null)
         {
            var_607.dispose();
            var_607 = null;
         }
      }
      
      private function windowEventProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "tour_button":
               _guideHelp.createHelpRequest(_habboHelp.newIdentity ? 0 : 2);
               _habboHelp.trackGoogle("helpWindow","click_userTour");
               closeWindow();
               break;
            case "bully_button":
               closeWindow();
               _habboHelp.toggleNewHelpWindow();
               _habboHelp.trackGoogle("helpWindow","click_reportBully");
               break;
            case "instructions_button":
               _guideHelp.createHelpRequest(1);
               _habboHelp.trackGoogle("helpWindow","click_instructions");
               closeWindow();
               break;
            case "self_help_link":
               HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"),"habboMain");
               _habboHelp.trackGoogle("helpWindow","click_selfHelp");
               closeWindow();
               break;
            case "habboway_link":
               if(_habboHelp.getBoolean("habboway.enabled"))
               {
                  _habboHelp.showHabboWay();
               }
               else
               {
                  HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"),"habboMain");
               }
               _habboHelp.trackGoogle("helpWindow","click_habboWay");
               closeWindow();
               break;
            case "safetybooklet_link":
               _habboHelp.showSafetyBooklet();
               _habboHelp.trackGoogle("helpWindow","click_showSafetyBooklet");
               closeWindow();
               break;
            case "emergency_button":
               var _loc3_:class_1885 = class_1812(var_607.rootWindow).findChildByName("leave_room") as class_1885;
               closeWindow();
               _habboHelp.startEmergencyRequest();
               _habboHelp.trackGoogle("helpWindow","click_emergency");
         }
      }
      
      public function openTourPopup() : void
      {
         if(_tourPopup == null && !disposed)
         {
            _tourPopupShowTime = getTimer();
            _tourPopup = _guideHelp.habboHelp.getXmlWindow("welcome_tour_popup") as class_1812;
            _tourPopup.center();
            _tourPopup.y *= 0.25;
            _tourPopup.procedure = tourPopupEventProcedure;
         }
      }
      
      private function closeTourPopup() : void
      {
         if(_tourPopup != null)
         {
            _tourPopup.dispose();
            _tourPopup = null;
         }
      }
      
      private function tourPopupEventProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = (_tourPopupShowTime - getTimer()) / 1000;
         switch(param2.name)
         {
            case "refuse_tour":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.cancel","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_refuseTour");
               closeTourPopup();
               break;
            case "header_button_close":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.dismiss","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_closeWindow");
               closeTourPopup();
               break;
            case "take_tour":
               _guideHelp.createHelpRequest(0);
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.accept","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_acceptTour");
               closeTourPopup();
         }
      }
      
      public function showPendingTicket(param1:class_3018) : void
      {
         var _loc2_:String = null;
         if(param1.isGuide)
         {
            _loc2_ = "pending_guide_session";
         }
         else
         {
            switch(param1.type)
            {
               case 0:
               case 2:
                  _loc2_ = "pending_tour_request";
                  break;
               case 1:
                  _loc2_ = "pending_instructions_request";
                  break;
               case 3:
                  _loc2_ = "pending_bully_request";
                  break;
               default:
                  return;
            }
         }
         var_574 = _habboHelp.getXmlWindow(_loc2_) as class_1812;
         var_574.center();
         var_574.procedure = onPendingReuqestEvent;
         if(param1.isGuide)
         {
            return;
         }
         switch(param1.type - 1)
         {
            case 0:
               var_574.findChildByName("description").caption = param1.description;
               class_3111(class_2010(var_574.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               break;
            case 2:
               var_574.findChildByName("user_name").caption = param1.otherPartyName;
               class_2478(class_2010(var_574.findChildByName("user_avatar")).widget).figure = param1.otherPartyFigure;
               class_3111(class_2010(var_574.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               _habboHelp.localization.registerParameter("guide.pending.bully.room","room",param1.roomName);
         }
      }
      
      private function onPendingReuqestEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "close_button":
                  if(var_574 != null && !var_574.disposed)
                  {
                     var_574.dispose();
                     var_574 = null;
                  }
            }
         }
      }
   }
}

