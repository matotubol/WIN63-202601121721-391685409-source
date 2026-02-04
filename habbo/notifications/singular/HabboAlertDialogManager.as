package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   
   public class HabboAlertDialogManager
   {
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _habboHelp:IHabboHelp;
      
      public function HabboAlertDialogManager(param1:class_38, param2:class_27, param3:IHabboHelp)
      {
         super();
         _windowManager = param1;
         _localization = param2;
         _habboHelp = param3;
      }
      
      private static function getTimeZeroPadded(param1:int) : String
      {
         var _loc2_:String = "0" + String(param1);
         return _loc2_.substr(_loc2_.length - 2,_loc2_.length);
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         _localization = null;
         _habboHelp = null;
      }
      
      public function handleModeratorCaution(param1:String, param2:String = "") : void
      {
         showModerationMessage(param1,param2);
      }
      
      public function handleModeratorMessage(param1:String, param2:String = "") : void
      {
         showModerationMessage(param1,param2,false);
      }
      
      public function handleUserBannedMessage(param1:String) : void
      {
         showModerationMessage(param1,"");
      }
      
      private function showModerationMessage(param1:String, param2:String, param3:Boolean = true) : void
      {
         var message:String = param1;
         var url:String = param2;
         var showHabboWay:Boolean = param3;
         var p:RegExp = /\\r/g;
         message = message.replace(p,"\r");
         _windowManager.simpleAlert("","${mod.alert.title}",message,"${mod.alert.link}",url,null,"illumina_alert_illustrations_frank_neutral_png",null,function():void
         {
            if(_habboHelp != null && showHabboWay)
            {
               _habboHelp.showHabboWay();
            }
         });
      }
      
      public function handleHotelClosingMessage(param1:int) : void
      {
         _localization.registerParameter("opening.hours.shutdown","m",String(param1));
         _windowManager.simpleAlert("","${opening.hours.title}","${opening.hours.shutdown}");
      }
      
      public function handleHotelMaintenanceMessage(param1:int, param2:int) : void
      {
         _localization.registerParameter("maintenance.shutdown","m",String(param1));
         _localization.registerParameter("maintenance.shutdown","d",String(param2));
         _windowManager.simpleAlert("","${opening.hours.title}","${maintenance.shutdown}");
      }
      
      public function handleHotelClosedMessage(param1:int, param2:int, param3:Boolean) : void
      {
         var openHour:int = param1;
         var openMinute:int = param2;
         var userThrownOutAtClose:Boolean = param3;
         if(userThrownOutAtClose)
         {
            _localization.registerParameter("opening.hours.disconnected","h",getTimeZeroPadded(openHour));
            _localization.registerParameter("opening.hours.disconnected","m",getTimeZeroPadded(openMinute));
            _windowManager.alert("${opening.hours.title}","${opening.hours.disconnected}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
         }
         else
         {
            _localization.registerParameter("opening.hours.closed","h",getTimeZeroPadded(openHour));
            _localization.registerParameter("opening.hours.closed","m",getTimeZeroPadded(openMinute));
            _windowManager.alert("${opening.hours.title}","${opening.hours.closed}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
         }
      }
      
      public function handleLoginFailedHotelClosedMessage(param1:int, param2:int) : void
      {
         var openHour:int = param1;
         var openMinute:int = param2;
         _localization.registerParameter("opening.hours.disconnected","h",getTimeZeroPadded(openHour));
         _localization.registerParameter("opening.hours.disconnected","m",getTimeZeroPadded(openMinute));
         _windowManager.alert("${opening.hours.title}","${opening.hours.disconnected}",0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
      
      public function handleBanInfoMessage(param1:String, param2:Number, param3:String) : void
      {
         var dateText:String;
         var reason:String = param1;
         var expiryDateSeconds:Number = param2;
         var localizedReason:String = param3;
         var getDescriptionText:* = function():String
         {
            if(localizedReason != null && localizedReason != "")
            {
               return localizedReason.replace("{expiryDate}",dateText);
            }
            var _loc2_:String = _localization.getLocalization("login.banned.until");
            var _loc1_:String = _localization.getLocalization("login.banned.reason");
            return "<b>" + _loc2_ + "</b><br>" + dateText + "<br><b>" + _loc1_ + "</b><br>" + reason;
         };
         var banExpiryDate:Date = new Date();
         banExpiryDate.setTime(banExpiryDate.getTime() + expiryDateSeconds * 1000);
         dateText = expiryDateSeconds > -1 ? banExpiryDate.toLocaleString() : "";
         _windowManager.simpleAlert("","",getDescriptionText());
      }
   }
}

