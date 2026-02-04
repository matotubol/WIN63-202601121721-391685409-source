package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.freeflowchat.data.ChatEventHandler;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.data.RoomSessionEventHandler;
   import com.sulake.habbo.freeflowchat.history.ChatHistoryBuffer;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryScrollView;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
   import com.sulake.habbo.freeflowchat.style.class_2244;
   import com.sulake.habbo.freeflowchat.viewer.ChatBubbleFactory;
   import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatMarkup;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboModeration;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import package_12.class_1767;
   import package_12.class_1802;
   import package_27.class_1809;
   import package_32.class_2164;
   import package_39.class_1980;
   import package_42.class_2168;
   import package_61.class_2091;
   import package_64.class_2121;
   
   public class HabboFreeFlowChat extends class_17 implements class_51
   {
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _avatarRenderManager:class_48;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _navigator:class_41;
      
      private var _moderation:IHabboModeration;
      
      private var _roomUI:IRoomUI;
      
      private var _gameManager:class_45;
      
      private var _localizationManager:class_27;
      
      private var _toolbar:IHabboToolbar;
      
      private var _communication:class_57;
      
      private var _windowManager:class_38;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_1973:ChatEventHandler;
      
      private var var_2136:RoomSessionEventHandler;
      
      private var var_990:ChatHistoryBuffer;
      
      private var var_549:ChatFlowStage;
      
      private var var_2277:ChatHistoryScrollView;
      
      private var _chatHistoryPulldown:ChatHistoryTray;
      
      private var var_700:ChatFlowViewer;
      
      private var var_1606:ChatViewController;
      
      private var var_884:ChatBubbleFactory;
      
      private var var_1579:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var var_2178:class_2164;
      
      private var var_3771:Boolean = false;
      
      private var var_2641:int = 1;
      
      private var var_3072:Boolean = false;
      
      private var var_4592:Boolean = false;
      
      public function HabboFreeFlowChat(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      public static function getTimeStampNow() : String
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = Number(_loc1_.getHours());
         var _loc4_:Number = Number(_loc1_.getMinutes());
         var _loc3_:Number = Number(_loc1_.getSeconds());
         var _loc5_:String = _loc2_ < 10 ? "0" + _loc2_ : _loc2_.toString();
         _loc5_ = _loc5_ + ":" + (_loc4_ < 10 ? "0" + _loc4_ : _loc4_.toString());
         return _loc5_ + ":" + (_loc3_ < 10 ? "0" + _loc3_ : _loc3_.toString());
      }
      
      public static function create9SliceSprite(param1:Rectangle, param2:BitmapData) : Sprite
      {
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc9_:int = 0;
         var _loc7_:Sprite = new Sprite();
         var _loc3_:Array = [param1.left,param1.right,param2.width];
         var _loc4_:Array = [param1.top,param1.bottom,param2.height];
         _loc7_.graphics.clear();
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc5_ = 0;
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc7_.graphics.beginBitmapFill(param2);
               _loc7_.graphics.drawRect(0,_loc5_,_loc3_[_loc8_] - 0,_loc4_[_loc9_] - _loc5_);
               _loc7_.graphics.endFill();
               _loc5_ = Number(_loc4_[_loc9_]);
               _loc9_++;
            }
            var _loc6_:Number = Number(_loc3_[_loc8_]);
            _loc8_++;
         }
         _loc7_.scale9Grid = param1;
         return _loc7_;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_45):void
         {
            _gameManager = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         },false),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _communication.addHabboConnectionMessageEvent(new class_2168(onGuestRoomData));
         _communication.addHabboConnectionMessageEvent(new class_2121(onPerkAllowances));
         _communication.addHabboConnectionMessageEvent(new class_1980(onRoomEnter));
         _communication.addHabboConnectionMessageEvent(new class_1809(onAccountPreferences));
         _communication.addHabboConnectionMessageEvent(new class_2091(onRoomChatSettings));
      }
      
      private function onPerkAllowances(param1:class_2121) : void
      {
         var _loc2_:Boolean = var_1579;
         var_1579 = true;
         if(!_loc2_ && var_1579)
         {
            var_884 = new ChatBubbleFactory(this);
            if(!isDisabledInPreferences)
            {
               var_1973 = new ChatEventHandler(this);
               var_2136 = new RoomSessionEventHandler(this);
               var_990 = new ChatHistoryBuffer(this);
            }
            if(_isInRoom)
            {
               roomEntered();
            }
         }
         else if(_loc2_ && !var_1579)
         {
            if(var_884)
            {
               var_884.dispose();
               var_884 = null;
            }
            if(var_1973)
            {
               var_1973.dispose();
               var_1973 = null;
            }
            if(var_2136)
            {
               var_2136.dispose();
               var_2136 = null;
            }
            if(var_990)
            {
               var_990.dispose();
               var_990 = null;
            }
            roomLeft();
         }
      }
      
      private function onGuestRoomData(param1:class_2168) : void
      {
         if(var_990 && !var_3072)
         {
            var_990.insertRoomChange(param1.getParser().data);
         }
         var_3072 = true;
         var_2178 = param1.getParser().chatSettings;
         if(var_549)
         {
            var_549.refreshSettings();
         }
      }
      
      private function onRoomEnter(param1:class_1980) : void
      {
         var_3072 = false;
         clear();
      }
      
      private function onRoomChatSettings(param1:class_2091) : void
      {
         var_2178 = param1.getParser().chatSettings;
         if(_isInRoom && var_549)
         {
            var_549.refreshSettings();
         }
      }
      
      private function onAccountPreferences(param1:class_1809) : void
      {
         setIsDisabledInPreferences(param1.getParser().freeFlowChatDisabled,true);
         var_2641 = param1.getParser().preferedChatStyle;
      }
      
      public function getRoomChangeBitmap() : BitmapData
      {
         return BitmapData(assets.getAssetByName("room_change").content);
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get gameManager() : class_45
      {
         return _gameManager;
      }
      
      public function get localizations() : class_27
      {
         return _localizationManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function roomEntered() : void
      {
         _isInRoom = true;
         if(var_1579 && var_884 && var_1973 && var_2136)
         {
            var_549 = new ChatFlowStage(this);
            var_700 = new ChatFlowViewer(this,var_549);
            var_2277 = new ChatHistoryScrollView(this,var_990);
            _chatHistoryPulldown = new ChatHistoryTray(this,var_2277);
            var_1606 = new ChatViewController(this,var_700,_chatHistoryPulldown);
         }
      }
      
      public function roomLeft() : void
      {
         if(_chatHistoryPulldown)
         {
            _chatHistoryPulldown.dispose();
            _chatHistoryPulldown = null;
         }
         if(var_2277)
         {
            var_2277.dispose();
            _chatHistoryPulldown = null;
         }
         if(var_700)
         {
            var_700.dispose();
            var_700 = null;
         }
         if(var_549)
         {
            var_549.dispose();
            var_549 = null;
         }
         if(var_1606)
         {
            var_1606.dispose();
            var_1606 = null;
         }
         _isInRoom = false;
      }
      
      private function fixHtml(param1:ChatItem, param2:ChatStyle) : void
      {
         if(!param2.allowHTML)
         {
            param1.text = param1.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            param1.text = param1.text.replace(/&#[0-9]+;/g,"");
            param1.text = param1.text.replace(/&#x[0-9]+;/g,"");
         }
         if(param2.isNotification)
         {
            param1.text = ChatMarkup.applyToElements(param1.text);
         }
         param1.text = ChatMarkup.applyColourToChat(param1.text);
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:PooledChatBubble = null;
         var _loc4_:Point = null;
         if(!var_1579 || !var_990 || !var_549 || isDisabledInPreferences)
         {
            return;
         }
         var _loc3_:ChatStyle = ChatStyle(chatStyleLibrary.getStyle(param1.style));
         fixHtml(param1,_loc3_);
         var_990.insertChat(param1);
         try
         {
            _loc2_ = var_884.getNewChatBubble(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         _loc4_ = var_549.insertBubble(_loc2_);
         var_700.insertBubble(_loc2_,_loc4_);
      }
      
      public function getScreenPointFromRoomLocation(param1:int, param2:IVector3d) : Point
      {
         var _loc9_:Point = null;
         var _loc5_:Point = null;
         if(_roomEngine == null || var_700 == null || var_700.rootDisplayObject.stage == null)
         {
            return ZERO_POINT;
         }
         var _loc3_:int = HabboComponentFlags.isRoomViewerMode(flags) ? 1 : -1;
         var _loc8_:IRoomGeometry = roomEngine.getRoomCanvasGeometry(param1,_loc3_);
         var _loc7_:Number = roomEngine.getRoomCanvasScale(param1);
         var _loc6_:Number = var_700.rootDisplayObject.stage.stageWidth * _loc7_ / 2;
         var _loc4_:Number = var_700.rootDisplayObject.stage.stageHeight * _loc7_ / 2;
         if(_loc8_ != null && param2 != null)
         {
            _loc9_ = _loc8_.getScreenPoint(param2);
            if(_loc9_ != null)
            {
               _loc6_ += _loc9_.x * _loc7_;
               _loc4_ += _loc9_.y * _loc7_;
               _loc5_ = roomEngine.getRoomCanvasScreenOffset(param1);
               if(_loc5_ != null)
               {
                  _loc6_ += _loc5_.x;
                  _loc4_ += _loc5_.y;
               }
            }
         }
         return new Point(_loc6_,_loc4_);
      }
      
      public function get chatFlowViewer() : ChatFlowViewer
      {
         return var_700;
      }
      
      public function get chatBubbleFactory() : ChatBubbleFactory
      {
         return var_884;
      }
      
      public function get chatHistoryScrollView() : ChatHistoryScrollView
      {
         return var_2277;
      }
      
      public function get displayObject() : DisplayObject
      {
         if(var_1606)
         {
            return var_1606.rootDisplayObject;
         }
         return null;
      }
      
      public function disableRoomMouseEventsLeftOfX(param1:int) : void
      {
         _roomEngine.mouseEventsDisabledLeftToX = param1;
      }
      
      public function selectAvatarWithChatItem(param1:ChatItem) : void
      {
         selectAvatar(param1.roomId,param1.userId);
      }
      
      public function selectAvatar(param1:int, param2:int) : void
      {
         if(_roomUI == null)
         {
            return;
         }
         var _loc3_:IRoomDesktop = _roomUI.desktop;
         _loc3_.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param2,100));
         roomEngine.selectAvatar(param1,param2);
         var _loc6_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc6_)
         {
            var _loc5_:class_2146 = _loc6_.userDataManager.getUserDataByIndex(param2);
            if(_loc5_ != null)
            {
               var _loc4_:class_2146 = _roomSessionManager.getSession(param1).userDataManager.getUserDataByIndex(param2);
               if(_loc4_ && _moderation)
               {
                  _moderation.userSelected(null.webID,null.name);
               }
            }
         }
      }
      
      public function get roomChatSettings() : class_2164
      {
         return var_2178;
      }
      
      public function get roomChatBorderLimited() : Boolean
      {
         if(var_2178)
         {
            return var_2178.mode == 1;
         }
         return false;
      }
      
      public function clickHasToPropagate(param1:MouseEvent) : Boolean
      {
         return _roomUI ? _roomUI.mouseEventPositionHasContextMenu(param1) : false;
      }
      
      public function get chatStyleLibrary() : class_2244
      {
         return var_884 ? var_884.chatStyleLibrary : null;
      }
      
      public function get isDisabledInPreferences() : Boolean
      {
         return var_3771 && !getBoolean("chat.disable_old_chat");
      }
      
      public function set isDisabledInPreferences(param1:Boolean) : void
      {
         setIsDisabledInPreferences(param1,false);
      }
      
      public function setIsDisabledInPreferences(param1:Boolean, param2:Boolean) : void
      {
         if(getBoolean("chat.disable_old_chat"))
         {
            return;
         }
         if(param1 && !var_4592)
         {
            var_4592 = true;
            _windowManager.confirm("${chat.old_chat_discontinuation.title}","${chat.old_chat_discontinuation.message}",0,onDiscontinuationConfirmed);
         }
         var_3771 = param1;
         if(!param2)
         {
            _communication.connection.send(new class_1802(var_3771));
         }
      }
      
      private function onDiscontinuationConfirmed(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            isDisabledInPreferences = false;
         }
      }
      
      public function get preferedChatStyle() : int
      {
         return var_2641;
      }
      
      public function set preferedChatStyle(param1:int) : void
      {
         var_2641 = param1;
         _communication.connection.send(new class_1767(var_2641));
      }
      
      public function clear() : void
      {
         if(var_549)
         {
            var_549.clear();
         }
      }
      
      public function toggleVisibility() : void
      {
         if(isDisabledInPreferences || !var_1579 || !_chatHistoryPulldown)
         {
            return;
         }
         _chatHistoryPulldown.toggleHistoryVisibility();
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_chatHistoryPulldown != null)
         {
            _chatHistoryPulldown.visible = param1;
         }
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function createPreviewBitmap(param1:String, param2:int) : BitmapData
      {
         var _loc6_:ChatStyle = chatStyleLibrary.getStyle(param2) as ChatStyle;
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc3_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",0);
         var _loc4_:ChatItem = new ChatItem(_loc3_,getTimer(),null,0,null,null,null,param1);
         var _loc5_:PooledChatBubble = new PooledChatBubble(this);
         _loc5_.chatItem = _loc4_;
         _loc5_.face = null;
         _loc5_.style = _loc6_;
         _loc5_.recreate(param1,0,false);
         var _loc7_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc7_.draw(_loc5_);
         return _loc7_;
      }
   }
}

