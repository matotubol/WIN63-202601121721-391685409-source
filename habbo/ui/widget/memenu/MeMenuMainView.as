package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import package_173.class_3213;
   import package_53.class_3520;
   import package_64.class_2121;
   
   public class MeMenuMainView implements IMeMenuView
   {
      
      public static const VIEW_ELEMENT_TYPE_MINI_MAIL:String = "minimail";
      
      private var var_16:MeMenuWidget;
      
      private var _window:class_1812;
      
      private var _icons:Dictionary;
      
      private var _perkAllowancesMessageEvent:class_2121;
      
      private var _config:class_16;
      
      public function MeMenuMainView(param1:class_16)
      {
         super();
         _config = param1;
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         _icons = new Dictionary();
         _icons["rooms_icon"] = ["gohome_white","gohome_color"];
         _icons["dance_icon"] = ["dance_white","dance_color"];
         _icons["clothes_icon"] = ["clothes_white","clothes_color"];
         _icons["effects_icon"] = ["effects_white","effects_color"];
         _icons["badges_icon"] = ["badges_white","badges_color"];
         _icons["wave_icon"] = ["wave_white","wave_color"];
         _icons["hc_icon"] = ["_white","_color"];
         _icons["settings_icon"] = ["settings_white","settings_color"];
         _icons["credits_icon"] = ["credits_white","credits_color"];
         _icons["minimail_icon"] = ["minimail_white","minimail_color"];
         _icons["profile_icon"] = ["profile_white","profile_color"];
         _icons["achievements_icon"] = ["achievements_white","achievements_color"];
         _icons["talents_icon"] = ["compass_white","compass_color"];
         _icons["guide_icon"] = ["lighthouse_white","lighthouse_color"];
         var_16 = param1;
         _perkAllowancesMessageEvent = new class_2121(onPerkAllowances);
         var_16.handler.container.connection.addMessageEvent(_perkAllowancesMessageEvent);
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         if(_perkAllowancesMessageEvent)
         {
            var_16.handler.container.connection.removeMessageEvent(_perkAllowancesMessageEvent);
            _perkAllowancesMessageEvent = null;
         }
         var_16 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function setIconAssets(param1:String, param2:String, param3:String = null, param4:String = null) : void
      {
         if(_icons[param1] == null)
         {
            return;
         }
         if(param3 != null)
         {
            _icons[param1][0] = param3;
         }
         if(param4 != null)
         {
            _icons[param1][1] = param4;
         }
         setElementImage(param1,param3);
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc3_:Number = NaN;
         if(var_16 == null)
         {
            return;
         }
         var _loc5_:String = "memenu_main";
         var _loc6_:Boolean = false;
         if(var_16.config.getBoolean("simple.memenu.enabled"))
         {
            _loc5_ += "_simple";
            _loc6_ = true;
         }
         var _loc4_:XmlAsset = var_16.assets.getAssetByName(_loc5_) as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc4_.content as XML) as class_1812;
         if(_window == null)
         {
            throw new Error("Failed to construct me menu main window from XML!");
         }
         _window.name = param1;
         if(!var_16.config.getBoolean("talent.track.enabled") && _loc6_)
         {
            _window.findChildByName("guide").rectangle = _window.findChildByName("talents").rectangle;
            _window.findChildByName("talents").visible = false;
         }
         if(var_16.config.getBoolean("guides.enabled"))
         {
            setGuideToolVisibility(var_16.handler.container.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL"));
         }
         for(var _loc11_ in _icons)
         {
            var _loc12_:Array = _icons[_loc11_];
            if(!(_loc12_ == null || null.length == 0))
            {
               var _loc7_:String = null[0];
               _loc3_ = 1;
               switch(_loc11_)
               {
                  case "dance_icon":
                  case "wave_icon":
                     if(var_16.hasEffectOn)
                     {
                        _loc3_ = 0.5;
                     }
                     break;
                  case "effects_icon":
                     if(var_16.isDancing)
                     {
                        _loc3_ = 0.5;
                     }
                     break;
                  case "hc_icon":
                     _loc7_ = getClubAssetNameBase() + null;
                     if(!var_16.isHabboClubActive)
                     {
                        setElementText("hc_text",var_16.localizations.getLocalization("widget.memenu.hc.join"));
                        break;
                     }
                     if(var_16.habboClubLevel == 2)
                     {
                        var _loc9_:String = "widget.memenu.vip";
                     }
                     else
                     {
                        _loc9_ = "widget.memenu.hc";
                     }
                     if(var_16.habboClubPeriods > 0)
                     {
                        _loc9_ = null + ".long";
                     }
                     var_16.localizations.registerParameter(null,"days",String(var_16.habboClubDays));
                     var_16.localizations.registerParameter(null,"months",String(var_16.habboClubPeriods));
                     setElementText("hc_text",var_16.localizations.getLocalization(null));
                     break;
                  case "minimail_icon":
                     if(!var_16.isMinimailEnabled)
                     {
                        _loc3_ = 0.5;
                        break;
                     }
                     var _loc8_:int = var_16.unreadMiniMailMessageCount;
                     if(_loc8_ == -1 || 0 > 0)
                     {
                        updateUnseenCounter("minimail",0);
                     }
               }
               setElementImage(_loc11_,null,_loc3_);
            }
         }
         var _loc10_:int = 0;
         while(0 < _window.numChildren)
         {
            var _loc2_:class_1741 = _window.getChildAt(0);
            null.addEventListener("WME_CLICK",onButtonClicked);
            null.addEventListener("WME_OVER",onMouseOverOrOut);
            null.addEventListener("WME_OUT",onMouseOverOrOut);
            _loc10_++;
         }
      }
      
      private function updateUnseenCounter(param1:String, param2:int) : void
      {
         var _loc3_:class_1812 = _window.findChildByName(param1) as class_1812;
         var _loc4_:class_1812 = _loc3_.findChildByName("unseen_counter") as class_1812;
         if(param2 == 0)
         {
            if(_loc4_)
            {
               _loc3_.removeChild(_loc4_);
               _loc3_.invalidate();
            }
            return;
         }
         if(!_loc4_)
         {
            _loc4_ = var_16.windowManager.createUnseenItemCounter();
            _loc4_.name = "unseen_counter";
            _loc3_.addChild(_loc4_);
         }
         (_loc4_.findChildByName("count") as ITextWindow).text = param2 > 0 ? param2.toString() : " ";
         _loc4_.x = _loc3_.width - _loc4_.width - 5;
         _loc4_.y = 5;
      }
      
      private function getClubAssetNameBase() : String
      {
         switch(var_16.habboClubLevel)
         {
            case 0:
            case 1:
               return "club";
            case 2:
               return "vip";
            default:
               return null;
         }
      }
      
      private function setElementImage(param1:String, param2:String, param3:Number = 1) : void
      {
         var _loc8_:class_2251 = _window.findChildByName(param1) as class_2251;
         var _loc7_:BitmapDataAsset = var_16.assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc8_ == null)
         {
            class_21.log("Could not find element: " + param1);
            return;
         }
         if(_loc7_ == null || _loc7_.content == null)
         {
            class_21.log("Could not find asset: " + param2);
            return;
         }
         var _loc5_:BitmapData = _loc7_.content as BitmapData;
         _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
         var _loc4_:int = (_loc8_.width - _loc5_.width) / 2;
         var _loc6_:int = (_loc8_.height - _loc5_.height) / 2;
         _loc8_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(_loc4_,_loc6_));
         _loc8_.blend = param3;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param2;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "dance":
               if(var_16.hasEffectOn)
               {
                  return;
               }
               var_16.changeView("me_menu_dance_moves_view");
               break;
            case "wave":
            case "blow":
               if(var_16.hasEffectOn)
               {
                  return;
               }
               if(var_16.isDancing)
               {
                  var_16.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(0));
                  var_16.isDancing = false;
               }
               var _loc4_:AvatarExpressionEnum = AvatarExpressionEnum.WAVE;
               if(_loc3_ == "blow")
               {
                  _loc4_ = AvatarExpressionEnum.BLOW;
               }
               var_16.messageListener.processWidgetMessage(new RoomWidgetAvatarExpressionMessage(null));
               var_16.hide();
               break;
            case "effects":
               if(var_16.isDancing)
               {
                  return;
               }
               var_16.messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS"));
               var_16.hide();
               break;
            case "rooms":
               var_16.messageListener.processWidgetMessage(new RoomWidgetShowOwnRoomsMessage());
               var_16.hide();
               break;
            case "badges":
               var_16.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage("inventory_badges"));
               var_16.hide();
               break;
            case "clothes":
               var_16.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage("RWCM_OPEN_AVATAR_EDITOR"));
               var_16.hide();
               break;
            case "hc":
               var_16.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage("RWOCM_CLUB_MAIN"));
               var_16.hide();
               break;
            case "settings":
               var_16.changeView("me_menu_settings_view");
               break;
            case "minimail":
               if(var_16.isMinimailEnabled)
               {
                  HabboWebTools.openMinimail("#mail/inbox/");
                  var_16.hide();
               }
               break;
            case "credits":
               HabboWebTools.openWebPageAndMinimizeClient(_config.getProperty("web.shop.relativeUrl"));
               var_16.hide();
               break;
            case "profile":
               var_16.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_16.userId,"me_menu"));
               var_16.hide();
               break;
            case "achievements":
               var_16.handler.container.questEngine.showAchievements();
               var_16.hide();
               break;
            case "guide":
               var_16.handler.container.toolbar.toggleWindowVisibility("GUIDE");
               var_16.hide();
               break;
            case "talents":
               var _loc5_:String = var_16.handler.container.sessionDataManager.currentTalentTrack;
               var_16.handler.container.habboTracking.trackTalentTrackOpen(null,"memenu");
               var_16.handler.container.connection.send(new class_3520(null));
               break;
            default:
               class_21.log("Me Menu Main View: unknown button: " + _loc3_);
         }
         HabboTracking.getInstance().trackEventLog("MeMenu","click",_loc3_);
      }
      
      private function onAlertClicked(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function onMouseOverOrOut(param1:WindowMouseEvent) : void
      {
         var _loc8_:Array = null;
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc4_:String = _loc2_.name;
         var _loc7_:String = _loc4_ + "_icon";
         var _loc3_:int = param1.type == "WME_OVER" ? 1 : 0;
         switch(_loc4_)
         {
            case "dance":
               if(var_16.hasEffectOn)
               {
                  return;
               }
               break;
            case "minimail":
               if(!var_16.isMinimailEnabled)
               {
                  return;
               }
               break;
            case "wave":
               if(var_16.hasEffectOn)
               {
                  return;
               }
               break;
            case "effects":
               if(var_16.isDancing)
               {
                  return;
               }
               break;
            case "hc":
               var _loc6_:String = getClubAssetNameBase();
         }
         _loc7_ = _loc4_ + "_icon";
         _loc8_ = _icons[_loc7_];
         if(_loc8_ != null)
         {
            var _loc5_:String = "" + _loc8_[_loc3_];
            setElementImage(_loc7_,null);
         }
      }
      
      private function onPerkAllowances(param1:class_2121) : void
      {
         var _loc2_:class_3213 = param1.getParser();
         setGuideToolVisibility(_loc2_.isPerkAllowed("USE_GUIDE_TOOL"));
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         var _loc3_:class_1741 = null;
         var _loc2_:class_1741 = null;
         if(_window && var_16)
         {
            _loc3_ = _window.findChildByName("guide");
            _loc2_ = _window.findChildByName("achievements");
            if(_loc3_)
            {
               _loc3_.visible = param1;
               _window.height = param1 ? _loc3_.bottom : _loc2_.bottom;
               var_16.updateSize();
            }
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = param1;
         if("minimail" === _loc4_)
         {
            _loc3_ = var_16.unreadMiniMailMessageCount;
            updateUnseenCounter("minimail",_loc3_);
         }
      }
   }
}

