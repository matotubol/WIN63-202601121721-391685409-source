package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import package_122.class_2642;
   import package_122.class_3212;
   import package_74.class_3770;
   import package_79.class_3291;
   
   public class UserInfoCtrl implements class_13, class_3145
   {
      
      private static const secsInMinute:int = 60;
      
      private static const secsInHour:int = 3600;
      
      private static const secsInDay:int = 86400;
      
      private static const secsInYear:int = 31536000;
      
      private var _callerFrame:class_2250;
      
      private var _main:ModerationManager;
      
      private var var_1270:int;
      
      private var var_2726:class_3291;
      
      private var var_24:class_3770;
      
      private var var_1884:class_1812;
      
      private var _openToolsBelow:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_1286:IssueHandler;
      
      public function UserInfoCtrl(param1:class_2250, param2:ModerationManager, param3:class_3291, param4:IssueHandler = null, param5:Boolean = false)
      {
         super();
         _callerFrame = param1;
         _main = param2;
         var_2726 = param3;
         _openToolsBelow = param5;
         var_1286 = param4;
      }
      
      public static function formatTime(param1:int) : String
      {
         if(param1 < 2 * 60)
         {
            return param1 + " secs ago";
         }
         if(param1 < 2 * 3600)
         {
            return Math.round(param1 / 60) + " mins ago";
         }
         if(param1 < 2 * 86400)
         {
            return Math.round(param1 / 3600) + " hours ago";
         }
         if(param1 < 2 * 31536000)
         {
            return Math.round(param1 / 86400) + " days ago";
         }
         return Math.round(param1 / 31536000) + " years ago";
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function load(param1:class_1812, param2:int) : void
      {
         var_1884 = param1;
         var_1270 = param2;
         var_24 = null;
         refresh();
         _main.messageHandler.addUserInfoListener(this);
         _main.connection.send(new class_2642(param2));
      }
      
      public function onUserInfo(param1:class_3770) : void
      {
         if(param1.userId != var_1270)
         {
            return;
         }
         var_24 = param1;
         refresh();
      }
      
      public function refresh() : void
      {
         if(var_1884.disposed)
         {
            return;
         }
         var _loc1_:class_1812 = prepare();
         if(var_24 == null)
         {
            _loc1_.findChildByName("fields").visible = false;
            _loc1_.findChildByName("loading_txt").visible = true;
            return;
         }
         _loc1_.findChildByName("fields").visible = true;
         _loc1_.findChildByName("loading_txt").visible = false;
         setTxt(_loc1_,"name_txt",var_24.userName);
         setTxt(_loc1_,"registered_txt",formatTime(var_24.registrationAgeInMinutes * 60));
         setTxt(_loc1_,"cfh_count_txt","" + var_24.cfhCount);
         setAlertTxt(_loc1_,"abusive_cfh_count_txt",var_24.abusiveCfhCount);
         setAlertTxt(_loc1_,"caution_count_txt",var_24.cautionCount);
         setAlertTxt(_loc1_,"ban_count_txt",var_24.banCount);
         setAlertTxt(_loc1_,"trading_lock_count_txt",var_24.tradingLockCount);
         setTxt(_loc1_,"trading_lock_expiry_txt",var_24.tradingExpiryDate,"No active lock");
         setTxt(_loc1_,"last_login_txt",formatTime(var_24.minutesSinceLastLogin * 60));
         setTxt(_loc1_,"online_txt",var_24.online ? "Yes" : "No");
         setTxt(_loc1_,"last_purchase_txt",var_24.lastPurchaseDate,"No purchases");
         setTxt(_loc1_,"email_address_txt",var_24.primaryEmailAddress,"No email found");
         setTxt(_loc1_,"id_bans_txt","" + var_24.identityRelatedBanCount);
         setTxt(_loc1_,"user_class_txt",var_24.userClassification,"-");
         setTxt(_loc1_,"last_sanction_time_txt",var_24.lastSanctionTime);
         if(var_24.sanctionAgeHours <= 48)
         {
            (_loc1_.findChildByName("last_sanction_time_txt") as ITextWindow).textColor = 255 * (48 - var_24.sanctionAgeHours) / 48 << 16;
         }
         if(var_24.primaryEmailAddress == "No identity")
         {
            _loc1_.findChildByName("modaction_but").disable();
         }
         class_21.log("USER: " + var_24.userName + ", " + var_24.banCount + ", " + var_24.cautionCount);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeUserInfoListener(this);
         _callerFrame = null;
         _main = null;
         var_24 = null;
         var_1884 = null;
      }
      
      private function prepare() : class_1812
      {
         var _loc1_:class_1812 = class_1812(var_1884.findChildByName("user_info"));
         if(_loc1_ == null)
         {
            _loc1_ = class_1812(_main.getXmlWindow("user_info"));
            var_1884.addChild(_loc1_);
         }
         _loc1_.findChildByName("chatlog_but").procedure = onChatlogButton;
         _loc1_.findChildByName("roomvisits_but").procedure = onRoomVisitsButton;
         _loc1_.findChildByName("habboinfotool_but").procedure = onHabboInfoToolButton;
         _loc1_.findChildByName("message_but").procedure = onMessageButton;
         _loc1_.findChildByName("modaction_but").procedure = onModActionButton;
         _loc1_.findChildByName("view_caution_count_txt").procedure = onViewCautions;
         _loc1_.findChildByName("view_ban_count_txt").procedure = onViewBans;
         _loc1_.findChildByName("view_trading_lock_count_txt").procedure = onViewTradingLocks;
         _loc1_.findChildByName("view_id_bans_txt").procedure = onViewIDBans;
         return _loc1_;
      }
      
      private function setAlertTxt(param1:class_1812, param2:String, param3:int) : void
      {
         var _loc5_:class_1741 = param1.findChildByName(param2);
         var _loc4_:class_1741 = param1.findChildByName("view_" + param2);
         if(_loc4_ != null)
         {
            _loc4_.visible = param3 > 0;
         }
         _loc5_.caption = "" + param3;
      }
      
      private function setTxt(param1:class_1812, param2:String, param3:String, param4:String = "") : void
      {
         var _loc5_:class_1741 = ITextWindow(param1.findChildByName(param2));
         if(!param3 || param3.length == 0)
         {
            _loc5_.caption = param4;
         }
         else
         {
            _loc5_.caption = param3;
         }
      }
      
      private function onChatlogButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("chatLog");
         _main.windowTracker.show(new ChatlogCtrl(new class_3212(var_24.userId),_main,5,var_24.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onRoomVisitsButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomVisitsCtrl(_main,var_24.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onHabboInfoToolButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openInfoTool");
         _main.openHkPage("habboinfotool.url",var_24.userName);
      }
      
      private function onMessageButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openSendMessage");
         _main.windowTracker.show(new SendMsgsCtrl(_main,var_24.userId,var_24.userName,var_2726),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onModActionButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openModAction");
         _main.windowTracker.show(new ModActionCtrl(_main,var_24.userId,var_24.userName,var_2726,this),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onViewCautions(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewCautions");
         showModeratorLog();
      }
      
      private function onViewBans(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewBans");
         showModeratorLog();
      }
      
      private function onViewTradingLocks(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewTradingLocks");
         showModeratorLog();
      }
      
      private function onViewIDBans(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewIdentityInfo");
         showIdentityInformation();
      }
      
      private function showModeratorLog() : void
      {
         _main.openHkPage("moderatoractionlog.url",var_24.userName);
      }
      
      private function showIdentityInformation() : void
      {
         _main.openHkPage("identityinformationtool.url","" + var_24.identityId);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_main != null)
         {
            _main.logEvent(param1,param2);
         }
      }
      
      internal function trackAction(param1:String) : void
      {
         if(var_1286 == null || var_1286.disposed)
         {
            _main.trackGoogle("userInfo_" + param1);
         }
         else if(this == var_1286.callerUserInfo)
         {
            var_1286.trackAction("callerUserInfo_" + param1);
         }
         else if(this == var_1286.reportedUserInfo)
         {
            var_1286.trackAction("reportedUserInfo_" + param1);
         }
         else
         {
            var_1286.trackAction("userInfo_" + param1);
         }
      }
   }
}

