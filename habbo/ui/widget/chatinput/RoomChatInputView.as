package com.sulake.habbo.ui.widget.chatinput
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2483;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.freeflowchat.style.class_2133;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.chatinput.styleselector.ChatStyleSelector;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class RoomChatInputView
   {
      
      private static const MARGIN_H:int = 12;
      
      private static const CHAT_HELP_INTERNAL_CLIENT_LINK:String = "habbopages/chat/commands";
      
      private var var_16:RoomChatInputWidget;
      
      private var _window:class_1812;
      
      private var var_33:ITextFieldWindow;
      
      private var var_3397:class_1741;
      
      private var var_2117:class_1741;
      
      private var var_447:class_2483;
      
      private var var_1361:IRegionWindow;
      
      private var var_2355:Boolean = false;
      
      private var var_113:class_1812;
      
      private var var_5024:class_1812;
      
      private var _chatModeIdShout:String;
      
      private var var_2382:String;
      
      private var var_4206:String;
      
      private var var_2250:Boolean = false;
      
      private var var_4036:TextFormat;
      
      private var var_874:Boolean = false;
      
      private var var_1887:Boolean = false;
      
      private var var_715:Timer;
      
      private var var_804:Timer;
      
      private var var_349:Timer;
      
      private var var_526:String = "";
      
      private var var_731:Timer;
      
      private var var_3469:Boolean = false;
      
      private var var_533:Timer;
      
      private var var_2688:int = 0;
      
      private var var_1123:Timer;
      
      private var var_949:ChatStyleSelector;
      
      public function RoomChatInputView(param1:RoomChatInputWidget)
      {
         super();
         var_16 = param1;
         var_2382 = param1.localizations.getLocalization("widgets.chatinput.mode.whisper",":tell");
         _chatModeIdShout = param1.localizations.getLocalization("widgets.chatinput.mode.shout",":shout");
         var_4206 = param1.localizations.getLocalization("widgets.chatinput.mode.speak",":speak");
         var_715 = new Timer(1000,1);
         var_715.addEventListener("timerComplete",onTypingTimerComplete);
         var_804 = new Timer(10000,1);
         var_804.addEventListener("timerComplete",onIdleTimerComplete);
         var_3469 = sessionDataManager.isNoob || sessionDataManager.isRealNoob;
         if(var_3469)
         {
            var _loc3_:class_16 = param1.handler.container.config;
            if(null.getProperty("nux.chat.reminder.shown") != "1")
            {
               var _loc2_:int = int(null.getInteger("nux.noob.chat.reminder.delay",240));
               var_349 = new Timer(0 * 1000,1);
               var_349.addEventListener("timerComplete",onNuxIdleTimerComplete);
               var_349.start();
            }
         }
         var_4036 = new TextFormat(null,null,10066329,null,true,false);
         createWindow();
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(var_3469)
         {
            widget.windowManager.hideHint();
            widget.windowManager.unregisterHintWindow("nux_chat_reminder");
         }
         var_16 = null;
         if(var_33)
         {
            var_33.removeEventListener("WME_DOWN",windowMouseEventProcessor);
            var_33.removeEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
            var_33.removeEventListener("WKE_KEY_UP",keyUpHandler);
            var_33.removeEventListener("WE_CHANGE",onInputChanged);
            var_33.removeEventListener("WME_OVER",onInputHoverRegionMouseEvent);
            var_33.removeEventListener("WME_OUT",onInputHoverRegionMouseEvent);
            var_33 = null;
         }
         var_3397 = null;
         var_2117 = null;
         if(var_447)
         {
            var_447.removeEventListener("WME_CLICK",onHelpButtonMouseEvent);
            var_447.removeEventListener("WME_OVER",onHelpButtonMouseEvent);
            var_447.removeEventListener("WME_OUT",onHelpButtonMouseEvent);
            var_447 = null;
         }
         if(var_1361)
         {
            var_1361.removeEventListener("WME_OVER",onInputHoverRegionMouseEvent);
            var_1361.removeEventListener("WME_OUT",onInputHoverRegionMouseEvent);
            var_1361 = null;
         }
         if(var_113 != null)
         {
            var_113.dispose();
            var_113 = null;
         }
         if(var_715 != null)
         {
            var_715.reset();
            var_715.removeEventListener("timerComplete",onTypingTimerComplete);
            var_715 = null;
         }
         if(var_804 != null)
         {
            var_804.reset();
            var_804.removeEventListener("timerComplete",onIdleTimerComplete);
            var_804 = null;
         }
         if(var_349 != null)
         {
            var_349.reset();
            var_349.removeEventListener("timerComplete",onNuxIdleTimerComplete);
            var_349 = null;
         }
         if(var_533 != null)
         {
            var_533.reset();
            var_533.removeEventListener("timerComplete",onChatReminderTimer);
            var_533 = null;
         }
         if(var_731)
         {
            var_731.reset();
            var_731.removeEventListener("timerComplete",onRemoveDimmer);
            var_731 = null;
         }
         if(_window && _window.desktop)
         {
            _window.desktop.removeChild(_window);
         }
      }
      
      private function createWindow() : void
      {
         if(var_113 != null)
         {
            return;
         }
         var _loc1_:XmlAsset = var_16.assets.getAssetByName("chatinput_window_new") as XmlAsset;
         if(_loc1_ == null || _loc1_.content == null)
         {
            return;
         }
         _window = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
         _window.width = _window.desktop.width;
         _window.height = _window.desktop.height;
         _window.invalidate();
         var_5024 = class_1812(_window.findChildByName("chatstyles_menu"));
         var_113 = _window.findChildByName("bubblecont") as class_1812;
         var_113.tags.push("room_widget_chatinput");
         var_33 = var_113.findChildByName("chat_input") as ITextFieldWindow;
         var_3397 = var_113.findChildByName("input_border");
         var_2117 = var_113.findChildByName("block_text");
         var_1361 = IRegionWindow(var_113.findChildByName("helpbutton_show_hover_region"));
         var_1361.addEventListener("WME_OVER",onInputHoverRegionMouseEvent);
         var_1361.addEventListener("WME_OUT",onInputHoverRegionMouseEvent);
         updatePosition();
         var_33.setParamFlag(1,true);
         var_33.addEventListener("WME_DOWN",windowMouseEventProcessor);
         var_33.addEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
         var_33.addEventListener("WKE_KEY_UP",keyUpHandler);
         var_33.addEventListener("WE_CHANGE",onInputChanged);
         var_33.addEventListener("WME_OVER",onInputHoverRegionMouseEvent);
         var_33.addEventListener("WME_OUT",onInputHoverRegionMouseEvent);
         var_33.toolTipDelay = 0;
         var_33.toolTipIsDynamic = true;
         var_2250 = true;
         var_33.setTextFormat(var_4036);
         var_526 = "";
         _window.addEventListener("WE_PARENT_RESIZED",updatePosition);
         _window.addEventListener("WE_PARENT_ADDED",updatePosition);
         createOrUpdateChatStylesView();
         createAndAttachDimmerWindow();
         var_447 = class_2483(_window.findChildByName("helpbutton"));
         var_447.addEventListener("WME_CLICK",onHelpButtonMouseEvent);
         var_447.addEventListener("WME_OVER",onHelpButtonMouseEvent);
         var_447.addEventListener("WME_OUT",onHelpButtonMouseEvent);
         var_447.visible = false;
      }
      
      public function createOrUpdateChatStylesView() : void
      {
         var _loc5_:ISessionDataManager = null;
         var _loc6_:class_51 = null;
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc7_:class_2133 = null;
         if(customChatStylesEnabled() && !var_16.handler.container.roomSession.isGameSession && var_16.handler.container.freeFlowChat != null && var_16.handler.container.freeFlowChat.chatStyleLibrary != null)
         {
            _loc5_ = var_16.handler.container.sessionDataManager;
            _loc6_ = var_16.handler.container.freeFlowChat;
            _loc1_ = [];
            _loc2_ = var_16.roomUi.getProperty("disabled.custom.chat.styles").split(",");
            _loc3_ = _loc5_.hasSecurity(4);
            for each(var _loc4_ in _loc6_.chatStyleLibrary.getStyleIds())
            {
               _loc7_ = _loc6_.chatStyleLibrary.getStyle(_loc4_);
               if(!_loc7_.isSystemStyle)
               {
                  if(isNftChatStyle(_loc4_))
                  {
                     if(_loc5_.hasNftChatStyle(_loc4_))
                     {
                        _loc1_.push(_loc4_);
                     }
                  }
                  else
                  {
                     if(isStaticStyle(_loc4_) && !_loc7_.purchasable)
                     {
                        if(_loc7_.isStaffOverrideable && _loc3_)
                        {
                           _loc1_.push(_loc4_);
                           continue;
                        }
                        if(_loc7_.isAmbassadorOnly && (_loc3_ || _loc5_.isAmbassador))
                        {
                           _loc1_.push(_loc4_);
                           continue;
                        }
                        if(_loc2_.indexOf(_loc4_.toString()) != -1)
                        {
                           continue;
                        }
                        if(_loc7_.isHcOnly && _loc5_.hasClub)
                        {
                           _loc1_.push(_loc4_);
                           continue;
                        }
                        if(!_loc7_.isHcOnly && !_loc7_.isAmbassadorOnly)
                        {
                           _loc1_.push(_loc4_);
                           continue;
                        }
                     }
                     if(_loc5_.hasPurchasableChatStyle(_loc4_))
                     {
                        _loc1_.push(_loc4_);
                     }
                  }
               }
            }
            createChatStyleSelectorMenuItems(_loc1_);
         }
         else if(var_113.findChildByName("chat_input_container") is IItemListWindow)
         {
            IItemListWindow(var_113.findChildByName("chat_input_container")).removeListItemAt(0);
         }
      }
      
      private function isNftChatStyle(param1:int) : Boolean
      {
         return param1 >= 1000 && param1 <= 9999;
      }
      
      private function isPurchasableStyle(param1:int) : Boolean
      {
         return param1 >= 10000 && param1 <= 99999;
      }
      
      private function isStaticStyle(param1:int) : Boolean
      {
         return param1 < 1000;
      }
      
      private function customChatStylesEnabled() : Boolean
      {
         return var_16.roomUi.getBoolean("custom.chat.styles.enabled");
      }
      
      private function createAndAttachDimmerWindow() : void
      {
         var _loc1_:class_1741 = null;
         if(RoomEnterEffect.isRunning())
         {
            _loc1_ = var_16.windowManager.createWindow("chat_dimmer","",30,1,0x80 | 0x0800 | 1,new Rectangle(0,0,var_113.width,var_113.height),null,0);
            _loc1_.color = 0;
            _loc1_.blend = 0.3;
            var_113.addChild(_loc1_);
            var_113.invalidate();
            if(var_731 == null)
            {
               var_731 = new Timer(RoomEnterEffect.totalRunningTime,1);
               var_731.addEventListener("timerComplete",onRemoveDimmer);
               var_731.start();
            }
         }
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         var_731.removeEventListener("timerComplete",onRemoveDimmer);
         var_731 = null;
         var _loc2_:class_1741 = var_113.findChildByName("chat_dimmer");
         if(_loc2_ != null)
         {
            var_113.removeChild(_loc2_);
            var_16.windowManager.destroy(_loc2_);
         }
      }
      
      public function updatePosition(param1:class_1758 = null, param2:int = 10000, param3:int = 10000) : void
      {
         _window.width = _window.desktop.width;
         _window.height = _window.desktop.height;
         var _loc9_:Point = new Point();
         if(!var_113)
         {
            return;
         }
         var _loc4_:int = widget.getToolBarWidth();
         var _loc6_:int = widget.getFriendBarWidth();
         var _loc5_:int = _window.desktop.width / 2 - var_113.width / 2;
         var _loc7_:int = 0;
         var _loc8_:int = var_113.width + 12;
         if(_window.desktop.width - _loc4_ - _loc6_ > _loc8_)
         {
            _loc7_ = _loc4_ + 12;
            var_113.y = _window.desktop.height - 104;
            if(_loc5_ + var_113.width > _window.desktop.width - _loc6_)
            {
               _loc5_ = 0;
            }
         }
         else
         {
            _loc7_ = widget.getRoomToolsWidth() + 12;
            var_113.y = _window.desktop.height - 160;
         }
         var_113.x = Math.max(_loc5_,_loc7_);
         if(var_949)
         {
            var_949.alignMenuToSelector();
         }
      }
      
      private function onSend(param1:WindowMouseEvent) : void
      {
         if(!var_2250)
         {
            sendChatFromInputField();
         }
      }
      
      public function hideFloodBlocking() : void
      {
         var_33.visible = true;
         var_2117.visible = false;
      }
      
      public function showFloodBlocking() : void
      {
         var_33.visible = false;
         var_2117.visible = true;
      }
      
      public function updateBlockText(param1:int) : void
      {
         var_2117.caption = var_16.localizations.registerParameter("chat.input.alert.flood","time",param1.toString());
      }
      
      public function displaySpecialChatMessage(param1:String, param2:String = "") : void
      {
         if(var_113 == null || var_33 == null)
         {
            return;
         }
         var_33.enable();
         var_33.selectable = true;
         var_33.text = "";
         setInputFieldFocus();
         var_33.text += param1 + " ";
         if(param2.length > 0)
         {
            var_33.text += param2 + " ";
         }
         var_33.setSelection(var_33.text.length,var_33.text.length);
         var_526 = var_33.text;
      }
      
      private function windowMouseEventProcessor(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         setInputFieldFocus();
      }
      
      private function windowKeyEventProcessor(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         var _loc7_:* = 0;
         var _loc3_:Boolean = false;
         var _loc6_:WindowKeyboardEvent = null;
         var _loc4_:KeyboardEvent = null;
         var _loc8_:String = null;
         var _loc5_:Array = null;
         if(var_113 == null || var_16 == null || var_16.floodBlocked)
         {
            return;
         }
         if(anotherFieldHasFocus())
         {
            return;
         }
         setInputFieldFocus();
         if(param1 is WindowKeyboardEvent)
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc7_ = _loc6_.charCode;
            _loc3_ = _loc6_.shiftKey;
         }
         if(param1 is KeyboardEvent)
         {
            _loc4_ = param1 as KeyboardEvent;
            _loc7_ = _loc4_.charCode;
            _loc3_ = _loc4_.shiftKey;
         }
         if(_loc4_ == null && _loc6_ == null)
         {
            return;
         }
         if(_loc7_ == 32)
         {
            checkSpecialKeywordForInput();
         }
         if(_loc7_ == 13)
         {
            sendChatFromInputField(_loc3_);
            setButtonPressedState(true);
         }
         if(_loc7_ == 8)
         {
            if(var_33 != null)
            {
               _loc8_ = var_33.text;
               _loc5_ = _loc8_.split(" ");
               if(_loc5_[0] == var_2382 && _loc5_.length == 3 && _loc5_[2] == "")
               {
                  var_33.text = "";
                  var_526 = "";
               }
            }
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            setButtonPressedState(false);
         }
      }
      
      private function setButtonPressedState(param1:Boolean) : void
      {
      }
      
      private function onInputChanged(param1:class_1758) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_804.reset();
         var _loc3_:* = _loc2_.text.length == 0;
         if(_loc3_)
         {
            var_874 = false;
            var_715.start();
         }
         else
         {
            if(_loc2_.text.length > var_526.length + 1)
            {
               if(var_16.allowPaste)
               {
                  var_16.setLastPasteTime();
               }
               else
               {
                  _loc2_.text = "";
               }
            }
            var_526 = _loc2_.text;
            if(!var_874)
            {
               var_874 = true;
               var_715.reset();
               var_715.start();
            }
            var_804.start();
            if(var_349 != null)
            {
               var_349.reset();
               var_349 = null;
            }
         }
      }
      
      private function checkSpecialKeywordForInput() : void
      {
         if(var_33 == null || var_33.text == "")
         {
            return;
         }
         var _loc2_:String = var_33.text;
         var _loc1_:String = var_16.selectedUserName;
         if(_loc2_ == var_2382)
         {
            if(_loc1_.length > 0)
            {
               var_33.text += " " + var_16.selectedUserName;
               var_33.setSelection(var_33.text.length,var_33.text.length);
               var_526 = var_33.text;
            }
         }
      }
      
      private function onIdleTimerComplete(param1:TimerEvent) : void
      {
         if(var_874)
         {
            var_1887 = false;
         }
         var_874 = false;
         sendTypingMessage();
      }
      
      private function onNuxIdleTimerComplete(param1:TimerEvent) : void
      {
         if(var_349 != null)
         {
            var_349.reset();
            var_349.removeEventListener("timerComplete",onNuxIdleTimerComplete);
            var_349 = null;
         }
         highlightChatInput();
      }
      
      private function onTypingTimerComplete(param1:TimerEvent) : void
      {
         if(var_874)
         {
            var_1887 = true;
         }
         sendTypingMessage();
      }
      
      private function sendTypingMessage() : void
      {
         if(var_16 == null)
         {
            return;
         }
         if(var_16.floodBlocked)
         {
            return;
         }
         var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(var_874);
         var_16.messageListener.processWidgetMessage(_loc1_);
      }
      
      private function highlightChatInput() : void
      {
         var_33.text = widget.localizations.getLocalization("widgets.chatinput.mode.remind.noobie");
         var_533 = new Timer(500);
         var_533.addEventListener("timer",onChatReminderTimer);
         var_533.start();
         widget.windowManager.registerHintWindow("nux_chat_reminder",var_33);
         widget.windowManager.showHint("nux_chat_reminder");
      }
      
      private function onChatReminderTimer(param1:TimerEvent) : void
      {
         var_2688 = var_2688 + 1;
         if(var_2688 % 2 != 0)
         {
            var_16.mainWindow.y -= 1;
         }
         else
         {
            var_16.mainWindow.y += 1;
         }
         if(var_2688 >= 10)
         {
            var_533.reset();
            var_533 = null;
            var_16.mainWindow.y = 0;
            chatBarReminderShown();
         }
      }
      
      private function chatBarReminderShown() : void
      {
         widget.handler.container.config.setProperty("nux.chat.reminder.shown","1");
         if(var_533 != null)
         {
            var_533.reset();
         }
         widget.windowManager.hideHint();
         widget.windowManager.unregisterHintWindow("nux_chat_reminder");
      }
      
      private function setInputFieldFocus() : void
      {
         if(var_33 == null)
         {
            return;
         }
         if(var_533 != null)
         {
            chatBarReminderShown();
         }
         if(var_2250)
         {
            var_33.text = "";
            var_33.textColor = 0;
            var_33.italic = false;
            var_2250 = false;
            var_526 = "";
         }
         var_33.focus();
      }
      
      public function setInputFieldColor(param1:uint) : void
      {
         if(var_33 == null)
         {
            return;
         }
         var_33.textColor = param1;
         var_33.defaultTextFormat.color = param1;
      }
      
      private function sendChatFromInputField(param1:Boolean = false) : void
      {
         if(var_33 == null || var_33.text == "")
         {
            return;
         }
         var _loc7_:int = param1 ? 2 : 0;
         var _loc6_:String = var_33.text;
         var _loc4_:Array = _loc6_.split(" ");
         var _loc2_:String = "";
         var _loc5_:String = "";
         switch(_loc4_[0])
         {
            case var_2382:
               _loc7_ = 1;
               _loc2_ = _loc4_[1];
               _loc5_ = var_2382 + " " + _loc2_ + " ";
               _loc4_.shift();
               _loc4_.shift();
               break;
            case _chatModeIdShout:
               _loc7_ = 2;
               _loc4_.shift();
               break;
            case var_4206:
               _loc7_ = 0;
               _loc4_.shift();
         }
         _loc6_ = _loc4_.join(" ");
         var _loc3_:int = 0;
         if(customChatStylesEnabled() && var_949 != null)
         {
            _loc3_ = var_949.selectedStyleId;
         }
         if(var_16 != null)
         {
            if(var_715.running)
            {
               var_715.reset();
            }
            if(var_804.running)
            {
               var_804.reset();
            }
            var_16.sendChat(_loc6_,_loc7_,_loc2_,_loc3_);
            var_874 = false;
            if(var_1887)
            {
               sendTypingMessage();
            }
            var_1887 = false;
         }
         if(var_33 != null)
         {
            var_33.text = _loc5_;
         }
         var_526 = _loc5_;
      }
      
      private function anotherFieldHasFocus() : Boolean
      {
         var _loc3_:Stage = null;
         var _loc2_:InteractiveObject = null;
         if(var_33 != null)
         {
            if(var_33.focused)
            {
               return false;
            }
         }
         var _loc1_:DisplayObject = var_113.context.getDesktopWindow().getDisplayObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.stage;
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.focus;
               if(_loc2_ == null)
               {
                  return false;
               }
               if(_loc2_ is TextField)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return var_16.handler.container.sessionDataManager;
      }
      
      private function createChatStyleSelectorMenuItems(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!var_949)
         {
            var_949 = new ChatStyleSelector(this,class_1812(var_113.findChildByName("styles")),sessionDataManager);
            var_949.gridColumns = param1.length / 6 + 1;
         }
         else
         {
            var_949.clear();
         }
         _loc3_ = param1.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = int(param1[_loc3_]);
            var_949.addItem(_loc2_,var_16.handler.container.freeFlowChat.chatStyleLibrary.getStyle(_loc2_).selectorPreview);
            _loc3_--;
         }
         var_949.initSelection();
      }
      
      public function get widget() : RoomChatInputWidget
      {
         return var_16;
      }
      
      public function get chatStyleMenuContainer() : class_1812
      {
         return var_5024;
      }
      
      public function getChatInputY() : int
      {
         if(!_window || !_window.findChildByName("chat_input_container"))
         {
            return 0;
         }
         var _loc1_:Point = new Point();
         _window.findChildByName("chat_input_container").getGlobalPosition(_loc1_);
         return _loc1_.y;
      }
      
      public function getChatWindowElements() : Array
      {
         return [var_113,var_33];
      }
      
      private function onHelpButtonMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_16.roomUi.context.createLinkEvent("habbopages/chat/commands");
         }
         if(param1.type == "WME_OVER")
         {
            var_447.visible = true;
            var_2355 = true;
            stopHelpButtonHideTimer();
         }
         else if(param1.type == "WME_OUT")
         {
            var_2355 = false;
            startHelpButtonHideTimer();
         }
      }
      
      private function onInputHoverRegionMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OVER")
         {
            var_447.visible = true;
            stopHelpButtonHideTimer();
         }
         else if(param1.type == "WME_OUT" && !var_2355)
         {
            startHelpButtonHideTimer();
         }
      }
      
      private function startHelpButtonHideTimer() : void
      {
         if(var_1123 != null)
         {
            stopHelpButtonHideTimer();
         }
         var_1123 = new Timer(400);
         var_1123.addEventListener("timer",onHelpButtonHideTimer);
         var_1123.start();
      }
      
      private function onHelpButtonHideTimer(param1:TimerEvent) : void
      {
         if(!var_2355 && var_447)
         {
            var_447.visible = false;
         }
         stopHelpButtonHideTimer();
      }
      
      private function stopHelpButtonHideTimer() : void
      {
         if(!var_1123)
         {
            return;
         }
         var_1123.stop();
         var_1123.removeEventListener("timer",onHelpButtonHideTimer);
         var_1123 = null;
      }
   }
}

