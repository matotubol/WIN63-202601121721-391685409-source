package com.sulake.habbo.ui.handler
{
   import com.sulake.core.localization.class_26;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredUpdateRoomComposer;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.RoomShakingEffect;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.ui.Mouse;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   public class ChatInputWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var var_2944:Boolean = true;
      
      private var _demonicTriggers:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:RoomChatInputWidget;
      
      public function ChatInputWidgetHandler()
      {
         super();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:RoomChatInputWidget) : void
      {
         var_16 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_INPUT_WIDGET";
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
         var_16 = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWCTM_TYPING_STATUS");
         _loc1_.push("RWCM_MESSAGE_CHAT");
         _loc1_.push("RWCSAM_MESSAGE_SELECT_AVATAR");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc31_:RoomWidgetChatTypingMessage = null;
         switch(param1.type)
         {
            case "RWCTM_TYPING_STATUS":
               _loc31_ = param1 as RoomWidgetChatTypingMessage;
               if(_loc31_ != null)
               {
                  _container.roomSession.sendChatTypingMessage(_loc31_.isTyping);
               }
               break;
            case "RWCM_MESSAGE_CHAT":
               if(!(_container != null && _container.roomSession != null))
               {
                  break;
               }
               var _loc26_:RoomWidgetChatMessage = param1 as RoomWidgetChatMessage;
               if(_loc26_ == null)
               {
                  break;
               }
               if(null.text == "")
               {
                  return null;
               }
               var _loc7_:String = null.text;
               var _loc27_:RoomWidgetRequestWidgetMessage = null;
               var _loc32_:Array = null.text.split(" ");
               if(_loc32_.length > 0)
               {
                  var _loc18_:String = null[0];
                  var _loc33_:String = "";
                  if(null.length > 1)
                  {
                     _loc33_ = null[1];
                  }
                  if(null.charAt(0) == ":" && null == "x")
                  {
                     while(true)
                     {
                        var _loc34_:int = _container.roomEngine.getSelectedAvatarId();
                        if(_loc34_ > -1)
                        {
                           var _loc6_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(0);
                           if(_loc6_ != null)
                           {
                              _loc33_ = null.name;
                              _loc7_ = null.text.replace(" x"," " + null.name);
                           }
                        }
                     }
                     addr0c2e:
                     var _loc21_:int = int(null.styleId);
                     if(_container != null && _container.roomSession != null)
                     {
                        if(this._container.freeFlowChat != null)
                        {
                           if(this._container.freeFlowChat.preferedChatStyle != null.styleId && null.styleId != -1)
                           {
                              this._container.freeFlowChat.preferedChatStyle = null.styleId;
                           }
                           _loc21_ = this._container.freeFlowChat.preferedChatStyle;
                        }
                        switch(int(null.chatType))
                        {
                           case 0:
                              _container.roomSession.sendChatMessage(null,0);
                              break;
                           case 1:
                              _container.roomSession.sendWhisperMessage(null.recipientName,null,0);
                              break;
                           case 2:
                              _container.roomSession.sendShoutMessage(null,0);
                        }
                        HabboTracking.getInstance().trackEventLogOncePerSession("Tutorial","interaction","avatar.chat");
                     }
                     break;
                  }
                  switch(null.toLowerCase())
                  {
                     case ":shake":
                        RoomShakingEffect.init(250,5000);
                        RoomShakingEffect.turnVisualizationOn();
                        return null;
                     case ":d":
                     case ";d":
                        if(_container.sessionDataManager.hasVip)
                        {
                           _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.LAUGH.ordinal);
                           HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","laugh");
                        }
                        break;
                     case ":kiss":
                        if(_container.sessionDataManager.hasVip)
                        {
                           _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.BLOW.ordinal);
                           HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","blow");
                           return null;
                        }
                        break;
                     case ":jump":
                        if(_container.sessionDataManager.hasVip)
                        {
                           _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.JUMP.ordinal);
                           HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","jump");
                           return null;
                        }
                        break;
                     case ":news":
                        if(_container.config.getBoolean("client.news.embed.enabled"))
                        {
                           HabboWebTools.openNews();
                           return null;
                        }
                        break;
                     case ":mail":
                        if(_container.config.getBoolean("client.minimail.embed.enabled"))
                        {
                           HabboWebTools.openMinimail("#mail/inbox/");
                           return null;
                        }
                        break;
                     case ":csmm":
                        if(_container.sessionDataManager.hasSecurity(4))
                        {
                           _container.gameManager.generateChecksumMismatch();
                           return null;
                        }
                        break;
                     case ":kick":
                        if(!container.sessionDataManager.hasSecurity(4))
                        {
                           if(_container.roomSession.roomControllerLevel >= 1)
                           {
                              var _loc13_:class_2146 = _container.roomSession.userDataManager.getUserDataByName(null);
                              if(_loc13_)
                              {
                                 _container.roomSession.kickUser(null.webID);
                              }
                           }
                           return null;
                        }
                        break;
                     case ":shutup":
                     case ":mute":
                        if(!_container.sessionDataManager.hasSecurity(4))
                        {
                           if(_container.roomSession.roomControllerLevel >= 1)
                           {
                              var _loc20_:class_2146 = _container.roomSession.userDataManager.getUserDataByName(null);
                              if(_loc20_)
                              {
                                 _container.roomSession.muteUser(null.webID,2);
                              }
                           }
                           return null;
                        }
                        break;
                     case ":crashme":
                     case ":resethunt":
                     case ":wiredreset":
                     case ":ss":
                     case ":qss":
                     case ":gd":
                     case ":tgl":
                     case ":li":
                     case ":link":
                     case ":q":
                        break;
                     case "o/":
                     case "_o/":
                        _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.WAVE.ordinal);
                        return null;
                     case ":idle":
                        _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.const_19.ordinal);
                        HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","idle");
                        return null;
                     case "_b":
                        _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.RESPECT.ordinal);
                        HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","respect");
                        return null;
                     case ":showfps":
                        _container.roomEngine.setFpsCounterEnabled(true);
                        return null;
                     case ":fps":
                        (_container.roomEngine as class_17).context.displayObjectContainer.stage.frameRate = int(null);
                        return null;
                     case ":sign":
                        _container.roomSession.sendSignMessage(int(null));
                        HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","sign",null,int(null));
                        return null;
                     case ":drop":
                     case ":dropitem":
                        _loc27_ = new RoomWidgetRequestWidgetMessage("RWUAM_DROP_CARRY_ITEM");
                        _container.processWidgetMessage(null);
                        return null;
                     case ":chooser":
                        if(container.sessionDataManager.hasClub || _container.sessionDataManager.hasSecurity(2) || _container.sessionDataManager.isAmbassador)
                        {
                           _loc27_ = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
                           _container.processWidgetMessage(null);
                        }
                        return null;
                     case ":furni":
                        if(_container.sessionDataManager.hasClub && _container.roomSession.roomControllerLevel >= 1 || _container.sessionDataManager.hasSecurity(2) || _container.sessionDataManager.isAmbassador)
                        {
                           _loc27_ = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER");
                           _container.processWidgetMessage(null);
                        }
                        return null;
                     case ":pickall":
                        _container.sessionDataManager.pickAllFurniture(_container.roomSession.roomId);
                        return null;
                     case ":pickallbc":
                        _container.sessionDataManager.pickAllBuilderFurniture(_container.roomSession.roomId);
                        return null;
                     case ":resetscores":
                        _container.sessionDataManager.resetScores(_container.roomSession.roomId);
                        return null;
                     case ":ejectall":
                        _container.sessionDataManager.ejectAllFurniture(_container.roomSession.roomId,null);
                        return null;
                     case ":ejectpets":
                        _container.sessionDataManager.ejectPets(_container.roomSession.roomId);
                        return null;
                     case ":reload":
                        if(_container.roomSession.roomControllerLevel >= 4 || _container.sessionDataManager.hasSecurity(5))
                        {
                           _container.windowManager.confirm("${wiredmenu.settings.room_state.reload}","${wiredmenu.settings.room_state.reload.warning}",0,onReloadConfirmed);
                        }
                        return null;
                     case ":rollback":
                        if(_container.roomSession.roomControllerLevel >= 4 || _container.sessionDataManager.hasSecurity(5))
                        {
                           _container.windowManager.confirm("${wiredmenu.settings.room_state.roll_back}","${wiredmenu.settings.room_state.roll_back.warning}",0,onRollbackConfirmed).titleBarColor = 13909337;
                        }
                        return null;
                     case ":moonwalk":
                        _container.sessionDataManager.sendSpecialCommandMessage(":moonwalk");
                        return null;
                     case ":habnam":
                        _container.sessionDataManager.sendSpecialCommandMessage(":habnam");
                        return null;
                     case ":yyxxabxa":
                        _container.sessionDataManager.sendSpecialCommandMessage(":yyxxabxa");
                        return null;
                     case ":mutepets":
                        _container.sessionDataManager.sendSpecialCommandMessage(":mutepets");
                        return null;
                     case ":mpgame":
                        _container.sessionDataManager.sendSpecialCommandMessage(null);
                        return null;
                     case ":ignore":
                        return null;
                     case ":unignore":
                        return null;
                     case ":floor":
                     case ":bcfloor":
                        if(_container.roomSession.roomControllerLevel >= 3)
                        {
                           _container.windowManager.displayFloorPlanEditor();
                        }
                        return null;
                     case ":lang":
                        (_container.localization as class_26).activateLocalizationDefinition(null);
                        return null;
                     case ":uc":
                        if(_container.sessionDataManager.hasSecurity(4))
                        {
                           _container.roomSession.sendRoomUsersClassificationMessage(null);
                        }
                        return null;
                     case ":anew":
                        if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                        {
                           _container.roomSession.sendRoomUsersClassificationMessage("new");
                        }
                        return null;
                     case ":avisit":
                        if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                        {
                           (_container.roomEngine as class_17).context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                        }
                        return null;
                     case ":aalert":
                        if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                        {
                           var _loc30_:class_2146 = _container.roomSession.userDataManager.getUserDataByName(null);
                           if(_loc30_)
                           {
                              _container.roomSession.ambassadorAlert(null.webID);
                           }
                        }
                        return null;
                     case ":visit":
                        _container.roomSession.sendVisitUserMessage(null);
                        return null;
                     case ":roomid":
                        _container.roomSession.sendVisitFlatMessage(parseInt(null));
                        return null;
                     case ":zoom":
                        _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,Number(null)));
                        return null;
                     case ":cam":
                     case ":camera":
                        if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
                        {
                           var _loc16_:HabboToolbarEvent = new HabboToolbarEvent("HTE_ICON_CAMERA");
                           _loc16_.iconName = "chatCameraCommand";
                           _container.toolbar.events.dispatchEvent(null);
                        }
                        return null;
                     case ":fs":
                     case ":fullscreen":
                        _container.windowManager.toggleFullScreen();
                        return null;
                     case ":screenshot":
                        var _loc8_:class_1945 = _container.navigator.enteredGuestRoomData;
                        if(_loc8_)
                        {
                           var _loc4_:String = null.roomName;
                        }
                        var _loc2_:Date = new Date();
                        var _loc28_:String = [null.getFullYear(),null.getMonth(),null.getDate()].join("-") + " " + [null.getHours(),null.getMinutes(),null.getSeconds()].join(".");
                        _loc4_ = "Habbo " + null;
                        _container.roomEngine.createScreenShot(_container.roomSession.roomId,_container.getFirstCanvasId(),null + ".png");
                        return null;
                     case ":iddqd":
                        _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,-1,true));
                        return null;
                     case ":hidemouse":
                        if(var_2944)
                        {
                           Mouse.hide();
                           _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,0);
                        }
                        else
                        {
                           Mouse.show();
                           _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,1);
                        }
                        _container.roomEngine.toggleTileCursorVisibility(_container.roomEngine.activeRoomId,!var_2944);
                        var_2944 = !var_2944;
                        return null;
                     case ":wf":
                     case ":wired":
                        (_container.roomEngine as class_17).context.createLinkEvent("wiredmenu/open");
                        return null;
                     case ":var":
                     case ":variables":
                        (_container.roomEngine as class_17).context.createLinkEvent("wiredmenu/open/variable_overview");
                        return null;
                     case ":inspect":
                     case ":inspection":
                        (_container.roomEngine as class_17).context.createLinkEvent("wiredmenu/open/inspection");
                        return null;
                     case ":playtest":
                        _container.userDefinedRoomEvents.switchPlayTestMode();
                        return null;
                     case ":demonictriggers":
                        var _loc11_:Array = _container.roomEngine.getObjectsByCategory(10);
                        _demonicTriggers = !_demonicTriggers;
                        var _loc29_:Array = [];
                        if(_demonicTriggers)
                        {
                           var _loc19_:Array = [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];
                           _loc29_ = [new ColorMatrixFilter(null)];
                        }
                        for each(var _loc35_ in null)
                        {
                           var _loc17_:int = _loc35_.getModel().getNumber("furniture_type_id");
                           var _loc15_:class_1800 = _container.sessionDataManager.getFloorItemData(0);
                           if(_loc15_.className.indexOf("wf_trg_") == 0)
                           {
                              var _loc5_:IRoomObjectSpriteVisualization = _loc35_.getVisualization() as IRoomObjectSpriteVisualization;
                              var _loc24_:int = 0;
                              while(0 < null.spriteCount)
                              {
                                 var _loc14_:IRoomObjectSprite = null.getSprite(0);
                                 if(_loc14_.blendMode != "add")
                                 {
                                    null.filters = null;
                                 }
                                 _loc24_++;
                              }
                           }
                        }
                        return null;
                  }
               }
               §§goto(addr0c2e);
               break;
            case "RWCSAM_MESSAGE_SELECT_AVATAR":
               var _loc9_:RoomWidgetChatSelectAvatarMessage = param1 as RoomWidgetChatSelectAvatarMessage;
               if(_loc9_ != null)
               {
                  _container.roomEngine.selectAvatar(null.roomId,null.objectId);
                  var _loc10_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(null.objectId);
                  if(_loc10_ != null)
                  {
                     _container.moderation.userSelected(null.webID,null.userName);
                  }
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSCE_FLOOD_EVENT","hrwe_hide_room_widget","FBE_BAR_RESIZE_EVENT","SDTWE_PURCHASABLE_STYLES_UPDATED"];
      }
      
      public function update() : void
      {
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:RoomSessionChatEvent = null;
         var _loc2_:int = 0;
         var _loc5_:Event = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSCE_FLOOD_EVENT":
               _loc3_ = param1 as RoomSessionChatEvent;
               _loc2_ = parseInt(_loc3_.text);
               _loc5_ = new RoomWidgetFloodControlEvent(_loc2_);
               break;
            case "FBE_BAR_RESIZE_EVENT":
               var _loc4_:FriendBarResizeEvent = param1 as FriendBarResizeEvent;
               var_16.checkChatInputPosition();
               break;
            case "SDTWE_PURCHASABLE_STYLES_UPDATED":
               var_16.refreshChatStyles();
               break;
            case "hrwe_hide_room_widget":
               handleHideWidgetEvent(param1 as HideRoomWidgetEvent);
               return;
         }
         if(_container != null && _container.events != null && _loc5_ != null)
         {
            _container.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onRollbackConfirmed(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            _container.connection.send(new WiredUpdateRoomComposer(true));
         }
         param1.dispose();
      }
      
      private function onReloadConfirmed(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            _container.connection.send(new WiredUpdateRoomComposer(false));
         }
         param1.dispose();
      }
      
      private function handleHideWidgetEvent(param1:HideRoomWidgetEvent) : void
      {
         if(param1 && param1.widgetType == this.type)
         {
            var_16.hide();
         }
      }
   }
}

