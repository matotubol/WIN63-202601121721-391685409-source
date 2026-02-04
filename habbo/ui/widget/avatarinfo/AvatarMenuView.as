package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   
   public class AvatarMenuView extends AvatarContextInfoButtonView
   {
      
      protected static const MODE_ACTIONS:uint = 1;
      
      protected static const MODE_MODERATE:uint = 2;
      
      protected static const MODE_BAN:uint = 4;
      
      protected static const MODE_MUTE:uint = 5;
      
      protected static const MODE_RELATIONSHIP:uint = 6;
      
      protected static const MODE_AMBASSADOR:uint = 7;
      
      protected static var lastViewMode:uint = 1;
      
      protected var var_24:class_3270;
      
      protected var var_261:uint = 1;
      
      protected var var_565:Boolean;
      
      public function AvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_236 = false;
      }
      
      public static function setup(param1:AvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:class_3270) : void
      {
         param1.var_24 = param6;
         param1.var_261 = 1;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         var_24 = null;
         super.dispose();
      }
      
      protected function updateButtons() : void
      {
         var _loc10_:int = 0;
         if(!_window || !var_24)
         {
            return;
         }
         var _loc4_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc4_)
         {
            return;
         }
         _loc4_.procedure = buttonEventProc;
         _loc4_.autoArrangeItems = false;
         var _loc8_:int = _loc4_.numListItems;
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc4_.getListItemAt(_loc10_).visible = false;
            _loc10_++;
         }
         var _loc9_:Boolean = var_24.isBlocked;
         if(var_261 == 1)
         {
            showButton("open_profile",_loc9_);
            showButton("moderate",moderateMenuHasContent());
            showButton("friend",var_24.canBeAskedAsFriend && !_loc9_);
            showButton("ignore",!var_24.isIgnored && !_loc9_);
            showButton("unignore",var_24.isIgnored && !_loc9_);
            showButton("report",widget.configuration && widget.configuration.getBoolean("infostand.report.show") && !_loc9_);
            var _loc5_:int = var_24.respectLeft;
            var _loc1_:int = var_24.respectReplenishesLeft;
            widget.localizations.registerParameter("infostand.button.respect","count",(0).toString());
            showButton("respect",0 > 0);
            showButton("replenish_respect",0 > 0);
            var _loc2_:AvatarInfoWidgetHandler = widget.handler;
            var _loc11_:Boolean = Boolean(null.container.sessionDataManager.isAccountSafetyLocked());
            showButton("trade",citizenshipTalentTrackEnabled || var_24.canTrade && !_loc9_);
            switch(var_24.canTradeReason - 2)
            {
               case 0:
                  var _loc6_:String = "${infostand.button.trade.tooltip.shutdown}";
                  break;
               case 1:
                  _loc6_ = "${infostand.button.trade.tooltip.tradingroom}";
                  break;
               default:
                  _loc6_ = "";
            }
            IInteractiveWindow(class_1812(_loc4_.getListItemByName("trade")).getChildByName("button")).toolTipCaption = null;
            showButton("whisper",!_loc9_);
            if(widget.configuration.getBoolean("handitem.give.enabled") && !null.container.roomEngine.activeRoomHasHanditemControlBlocked)
            {
               var _loc3_:int = int(null.container.roomSession.ownUserRoomId);
               while(true)
               {
                  var _loc12_:IRoomObject = null.container.roomEngine.getRoomObject(null.roomSession.roomId,0,100);
                  if(_loc12_ != null)
                  {
                     var _loc7_:int = int(null.getModel().getNumber("figure_carry_object"));
                     if(_loc7_ > 0 && 0 < 999999)
                     {
                        showButton("pass_handitem");
                     }
                  }
               }
               §§goto(addr02d2);
            }
            showButton("relationship",widget.configuration.getBoolean("relationship.status.enabled") && var_24.isFriend && !_loc9_);
            showButton("ambassador",ambassadorMenuHasContent());
            showButton("wired_inspect",null.container.userDefinedRoomEvents.showInspectButton());
         }
         addr02d2:
         if(var_261 == 2)
         {
            showButton("kick",var_24.canBeKicked);
            showButton("ban_with_duration",var_24.canBeBanned);
            showButton("mute",var_24.canBeMuted);
            showButton("give_rights",isShowGiveRights());
            showButton("remove_rights",isShowRemoveRights());
            showButton("actions");
         }
         if(var_261 == 4)
         {
            showButton("ban_hour");
            showButton("ban_day");
            showButton("perm_ban");
            showButton("actions");
         }
         if(var_261 == 5)
         {
            showButton("mute_2min");
            showButton("mute_5min");
            showButton("mute_10min");
            showButton("actions");
         }
         if(var_261 == 6)
         {
            showButtonGrid("relationship_grid");
            showButton("no_relationship");
            showButton("actions");
         }
         if(var_261 == 7)
         {
            showButton("ambassador_kick");
            showButton("ambassador_alert");
            showButton("ambassador_mute_15min");
            showButton("ambassador_mute_60min");
            showButton("ambassador_mute_18hour");
            showButton("ambassador_mute_36hour");
            showButton("ambassador_mute_72hour");
            showButton("ambassador_unmute");
            showButton("actions");
         }
         _loc4_.autoArrangeItems = true;
         _loc4_.visible = true;
         lastViewMode = var_261;
         var_565 = false;
      }
      
      private function ambassadorMenuHasContent() : Boolean
      {
         return var_24.isAmbassador;
      }
      
      private function moderateMenuHasContent() : Boolean
      {
         return var_24.canBeKicked || var_24.canBeBanned || var_24.canBeMuted || isShowGiveRights() || isShowRemoveRights();
      }
      
      private function isShowGiveRights() : Boolean
      {
         return var_24.amIOwner && var_24.targetRoomControllerLevel < 1;
      }
      
      private function isShowRemoveRights() : Boolean
      {
         return var_24.amIOwner && var_24.targetRoomControllerLevel == 1;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("avatar_menu_widget")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = buttonEventProc;
            _window.findChildByName("profile_link").procedure = buttonEventProc;
            var _loc7_:ITextWindow = _window.findChildByName("name") as ITextWindow;
            if(var_24.isBlocked)
            {
               null.italic = true;
               null.caption = "${infostand.blocked_user}";
            }
            else
            {
               null.italic = false;
               _window.findChildByName("name").caption = _userName;
            }
            _window.visible = false;
            activeView = _window;
            updateButtons();
            updateRelationshipStatus();
            var _loc4_:IItemGridWindow = _window.findChildByName("relationship_grid") as IItemGridWindow;
            var _loc3_:IIterator = _loc4_.iterator;
            var _loc5_:int = int(null.length);
            var _loc6_:int = 0;
         }
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc6_:String = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc5_:RoomWidgetMessage = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "whisper":
                     _loc6_ = "RWUAM_WHISPER_USER";
                     break;
                  case "friend":
                     param2.disable();
                     var_24.canBeAskedAsFriend = false;
                     _loc6_ = "RWUAM_SEND_FRIEND_REQUEST";
                     break;
                  case "respect":
                     var_24.respectLeft -= 1;
                     var _loc4_:int = var_24.respectLeft;
                     widget.localizations.registerParameter("infostand.button.respect","count",(0).toString());
                     showButton("respect",var_24.respectLeft > 0);
                     _loc6_ = "RWUAM_RESPECT_USER";
                     break;
                  case "replenish_respect":
                     _loc6_ = "RWUAM_REPLENISH_RESPECT_USER";
                     break;
                  case "wired_inspect":
                     _loc6_ = "RWUAM_WIRED_INSPECT";
                     break;
                  case "open_profile":
                     _loc6_ = "RWUAM_OPEN_PROFILE";
                     break;
                  case "ignore":
                     param2.parent.visible = false;
                     _window.findChildByName("unignore").visible = true;
                     var_24.isIgnored = true;
                     _loc6_ = "RWUAM_IGNORE_USER";
                     break;
                  case "unignore":
                     param2.parent.visible = false;
                     _window.findChildByName("ignore").visible = true;
                     var_24.isIgnored = false;
                     _loc6_ = "RWUAM_UNIGNORE_USER";
                     break;
                  case "kick":
                     _loc6_ = "RWUAM_KICK_USER";
                     break;
                  case "ban_hour":
                     _loc6_ = "RWUAM_BAN_USER_HOUR";
                     break;
                  case "ban_day":
                     _loc6_ = "RWUAM_BAN_USER_DAY";
                     break;
                  case "perm_ban":
                     _loc6_ = "RWUAM_BAN_USER_PERM";
                     break;
                  case "mute_2min":
                     _loc6_ = "RWUAM_MUTE_USER_2MIN";
                     break;
                  case "mute_5min":
                     _loc6_ = "RWUAM_MUTE_USER_5MIN";
                     break;
                  case "mute_10min":
                     _loc6_ = "RWUAM_MUTE_USER_10MIN";
                     break;
                  case "ban_with_duration":
                     var_261 = 4;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "mute":
                     var_261 = 5;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "give_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("remove_rights").visible = true;
                     var_24.myRoomControllerLevel = 1;
                     _loc6_ = "RWUAM_GIVE_RIGHTS";
                     break;
                  case "remove_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("give_rights").visible = true;
                     var_24.myRoomControllerLevel = 0;
                     _loc6_ = "RWUAM_TAKE_RIGHTS";
                     break;
                  case "trade":
                     _loc6_ = "RWUAM_START_TRADING";
                     break;
                  case "moderate":
                     var_261 = 2;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "report":
                     _loc6_ = "RWUAM_REPORT_CFH_OTHER";
                     break;
                  case "actions":
                     var_261 = 1;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "relationship":
                     var_261 = 6;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "pass_handitem":
                     _loc6_ = "RWUAM_PASS_CARRY_ITEM";
                     break;
                  case "relationship_heart":
                     setRelationship(1);
                     break;
                  case "relationship_smile":
                     setRelationship(2);
                     break;
                  case "relationship_bobba":
                     setRelationship(3);
                     break;
                  case "no_relationship":
                     setRelationship(0);
                     break;
                  case "ambassador":
                     var_261 = 7;
                     var_565 = true;
                     _loc3_ = false;
                     break;
                  case "ambassador_alert":
                     _loc6_ = "RWUAM_AMBASSADOR_ALERT_USER";
                     break;
                  case "ambassador_kick":
                     _loc6_ = "RWUAM_AMBASSADOR_KICK_USER";
                     break;
                  case "ambassador_mute_2min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_2MIN";
                     break;
                  case "ambassador_mute_10min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_10MIN";
                     break;
                  case "ambassador_mute_15min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_15MIN";
                     break;
                  case "ambassador_mute_60min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_60MIN";
                     break;
                  case "ambassador_mute_18hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_18HOUR";
                     break;
                  case "ambassador_mute_36hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_36HOUR";
                     break;
                  case "ambassador_mute_72hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_72HOUR";
                     break;
                  case "ambassador_unmute":
                     _loc6_ = "RWUAM_AMBASSADOR_UNMUTE";
               }
            }
            if(param2.name == "profile_link")
            {
               _loc3_ = true;
               _loc5_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_1270,"avatarContextMenu");
            }
            if(_loc6_ != null)
            {
               _loc5_ = new RoomWidgetUserActionMessage(_loc6_,var_1270);
               HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc6_);
            }
            if(_loc5_ != null)
            {
               var_16.messageListener.processWidgetMessage(_loc5_);
            }
            updateButtons();
         }
         else if(param1.type == "WME_OVER")
         {
            if(param2.name == "button")
            {
               switch(param2.parent.name)
               {
                  case "kick":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.kick.hover");
                     break;
                  case "perm_ban":
                  case "ban_hour":
                  case "ban_day":
                  case "ban_with_duration":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.ban.hover");
                     break;
                  case "mute":
                  case "mute_2min":
                  case "mute_5min":
                  case "mute_10min":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.mute.hover");
                     break;
                  case "unignore":
                  case "ignore":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.ignore.hover");
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            var_16.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
      
      private function get citizenshipTalentTrackEnabled() : Boolean
      {
         return AvatarInfoWidget(var_16).configuration.getBoolean("talent.track.citizenship.enabled");
      }
      
      private function setRelationship(param1:int) : void
      {
         var_16.friendList.setRelationshipStatus(var_1270,param1);
      }
   }
}

