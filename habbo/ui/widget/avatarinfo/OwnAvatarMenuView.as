package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   
   public class OwnAvatarMenuView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_CLUB_DANCES:int = 1;
      
      private static const MODE_NAME_CHANGE:int = 2;
      
      private static const MODE_EXPRESSIONS:int = 3;
      
      private static const MODE_SIGNS:int = 4;
      
      private static const MODE_CHANGE_LOOKS:int = 5;
      
      private static var var_5220:Boolean = false;
      
      private var var_24:class_3270;
      
      private var var_261:int;
      
      public function OwnAvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1 as class_1853);
         var_236 = false;
      }
      
      public static function setup(param1:OwnAvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:class_3270) : void
      {
         if(param1 == null || param1.widget == null)
         {
            return;
         }
         param1.var_24 = param6;
         if(!var_5220 && param1.widget.configuration.getInteger("new.identity",0) > 0 && param1.widget.configuration.getBoolean("new.user.reception.enabled"))
         {
            param1.var_261 = 0;
            OwnAvatarMenuView.var_5220 = true;
         }
         else if(param1.widget.isDancing && param1.widget.hasClub && !param1.widget.hasEffectOn)
         {
            param1.var_261 = 1;
         }
         else if(param6.allowNameChange && param1.widget.useMinimizedOwnAvatarMenu)
         {
            param1.var_261 = 2;
         }
         else
         {
            param1.var_261 = 0;
         }
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         var_24 = null;
         super.dispose();
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
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("own_avatar_menu")).content as XML;
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
            var _loc4_:IItemGridWindow = _window.findChildByName("signs_grid") as IItemGridWindow;
            var _loc3_:IIterator = _loc4_.iterator;
            var _loc5_:int = int(null.length);
            var _loc6_:int = 0;
            var _loc7_:IRegionWindow = _window.findChildByName("profile_link") as IRegionWindow;
            if(_loc7_)
            {
               null.procedure = buttonEventProc;
               null.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip","Click to view profile");
               null.toolTipDelay = 100;
            }
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc4_:int = 0;
         if(!_window || !var_24 || !var_34)
         {
            return;
         }
         var_34.autoArrangeItems = false;
         var _loc3_:int = var_34.numListItems;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var_34.getListItemAt(_loc4_).visible = false;
            _loc4_++;
         }
         var _loc5_:Boolean = widget.isCurrentUserRiding;
         switch(var_261)
         {
            case 0:
               showButton("change_name",var_24.allowNameChange);
               showButton("decorate",decorateModeSupported() && (var_24.myRoomControllerLevel >= 1 || var_24.amIOwner));
               showButton("change_looks");
               showButton("dance_menu",widget.hasClub && !_loc5_,!widget.hasEffectOn);
               showButton("dance",!widget.hasClub && !widget.isDancing && !_loc5_,!widget.hasEffectOn);
               showButton("dance_stop",!widget.hasClub && widget.isDancing && !_loc5_);
               if(!(var_16.windowManager as class_17).getBoolean("memenu.effects.widget.disabled"))
               {
                  showButton("effects",!_loc5_);
               }
               showButton("handitem",var_24.carryItemType > 0 && var_24.carryItemType < 999999 && widget.configuration.getBoolean("handitem.drop.enabled") && !widget.handler.roomEngine.activeRoomHasHanditemControlBlocked);
               var _loc1_:Boolean = widget.configuration.getBoolean("avatar.expressions_menu.enabled");
               showButton("wave");
               var _loc2_:Boolean = widget.configuration.getBoolean("avatar.signs.enabled");
               showButton("signs",false);
               showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
               break;
            case 1:
               showButton("dance_stop",true,widget.isDancing);
               showButton("dance_1");
               showButton("dance_2");
               showButton("dance_3");
               showButton("dance_4");
               showButton("back");
               break;
            case 2:
               showButton("change_name");
               showButton("more");
               break;
            case 3:
               showButton("wave",true,!widget.isSwimming);
               showButton("laugh",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("blow",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("idle",true);
               if(widget.configuration.getBoolean("avatar.sitting.enabled") && !widget.isSwimming && !_loc5_)
               {
                  showButton("sit",widget.ownAvatarPosture == "std");
                  showButton("stand",widget.canStandUp);
               }
               showButton("back");
               break;
            case 4:
               showButtonGrid("signs_grid");
               showButton("back");
               break;
            case 5:
               showButton("change_looks");
               showButton("more");
         }
         var_34.autoArrangeItems = true;
         var_34.visible = true;
      }
      
      private function gridEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc4_ = true;
               _loc7_ = "_";
               _loc3_ = param2.parent.name ? param2.parent.name : "";
               _loc6_ = _loc3_.substr(0,_loc3_.lastIndexOf(_loc7_));
               _loc5_ = parseInt(_loc3_.substr(_loc3_.lastIndexOf(_loc7_) + 1));
               var _loc8_:String = _loc6_;
               if("sign" === _loc8_)
               {
                  widget.sendSignRequest(_loc5_);
                  HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sign",null,_loc5_);
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc4_)
         {
            var_16.removeView(this,false);
         }
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:RoomWidgetMessage = null;
         var _loc5_:class_1741 = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc5_ = (param2 as class_1812).getChildByName("icon_vip");
               if(_loc5_ != null && _loc5_.visible && !widget.hasVip)
               {
                  var_16.catalog.openClubCenter();
                  return;
               }
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "change_name":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE");
                     break;
                  case "decorate":
                     if(decorateModeSupported())
                     {
                        widget.isUserDecorating = true;
                     }
                     break;
                  case "change_looks":
                     widget.openAvatarEditor();
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","clothes");
                     break;
                  case "expressions":
                     _loc3_ = false;
                     changeMode(3);
                     break;
                  case "sit":
                     _loc4_ = new RoomWidgetChangePostureMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sit");
                     break;
                  case "stand":
                     _loc4_ = new RoomWidgetChangePostureMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","stand");
                     break;
                  case "wave":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.WAVE);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","wave");
                     break;
                  case "blow":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.BLOW);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","blow");
                     break;
                  case "laugh":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.LAUGH);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","laugh");
                     break;
                  case "idle":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.const_19);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","idle");
                     break;
                  case "dance_menu":
                     _loc3_ = false;
                     changeMode(1);
                     break;
                  case "dance":
                     _loc4_ = new RoomWidgetDanceMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "dance_stop":
                     _loc4_ = new RoomWidgetDanceMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_stop");
                     break;
                  case "dance_1":
                  case "dance_2":
                  case "dance_3":
                  case "dance_4":
                     _loc4_ = new RoomWidgetDanceMessage(parseInt(param2.parent.name.charAt(param2.parent.name.length - 1)));
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "effects":
                     _loc4_ = new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS");
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","effects");
                     break;
                  case "signs":
                     _loc3_ = false;
                     changeMode(4);
                     break;
                  case "back":
                     _loc3_ = false;
                     changeMode(0);
                     break;
                  case "more":
                     _loc3_ = false;
                     widget.useMinimizedOwnAvatarMenu = false;
                     changeMode(0);
                     break;
                  case "handitem":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_DROP_CARRY_ITEM",var_1270);
                     break;
                  case "wired_inspect":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT",var_1270);
                     break;
                  case "jump":
               }
            }
            if(param2.name == "profile_link")
            {
               _loc3_ = true;
               _loc4_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",userId,"ownAvatarContextMenu");
            }
            if(_loc4_)
            {
               var_16.messageListener.processWidgetMessage(_loc4_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_ && !_disposed)
         {
            var_16.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
      
      private function changeMode(param1:int) : void
      {
         var_261 = param1;
         updateButtons();
      }
      
      private function decorateModeSupported() : Boolean
      {
         return widget.hasClub;
      }
   }
}

