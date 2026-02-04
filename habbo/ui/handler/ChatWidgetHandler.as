package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.PointMath;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ChatWidgetHandler implements IRoomWidgetHandler, class_259, class_1829
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _avatarImageCache:class_55 = null;
      
      private var _petImageCache:class_55 = null;
      
      private var _avatarColorCache:class_55 = null;
      
      private var _petImageIdToFigureString:class_55 = null;
      
      private var var_1432:Array = [];
      
      private var var_37:IConnection = null;
      
      private var var_1881:Number = 0;
      
      private var var_1055:Point = null;
      
      private var var_1208:Vector3d = new Vector3d();
      
      private var var_16:RoomChatWidget;
      
      public function ChatWidgetHandler()
      {
         super();
         _avatarImageCache = new class_55();
         _petImageCache = new class_55();
         _avatarColorCache = new class_55();
         _petImageIdToFigureString = new class_55();
      }
      
      public function set widget(param1:RoomChatWidget) : void
      {
         var_16 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_37 = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
         var_1055 = null;
         if(_avatarImageCache != null)
         {
            var _loc3_:int = 0;
            while(0 < _avatarImageCache.length)
            {
               var _loc1_:BitmapData = _avatarImageCache.getWithIndex(0) as BitmapData;
               _loc3_++;
            }
            _avatarImageCache.dispose();
            _avatarImageCache = null;
         }
         if(_petImageCache != null)
         {
            _loc3_ = 0;
            while(0 < _petImageCache.length)
            {
               _loc1_ = _petImageCache.getWithIndex(0) as BitmapData;
               _loc3_++;
            }
            _petImageCache.dispose();
            _petImageCache = null;
         }
         for each(var _loc2_ in var_1432)
         {
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
         var_1432 = [];
         if(_avatarColorCache != null)
         {
            _avatarColorCache.dispose();
            _avatarColorCache = null;
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return new Array(0);
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         param1.type;
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSCE_CHAT_EVENT","gce_game_chat"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomSessionChatEvent = null;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         if(_container.freeFlowChat && !_container.freeFlowChat.isDisabledInPreferences)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSCE_CHAT_EVENT":
               _loc2_ = param1 as RoomSessionChatEvent;
               if(_loc2_ != null)
               {
                  var _loc20_:IRoomObject = _container.roomEngine.getRoomObject(_loc2_.session.roomId,_loc2_.userId,100);
                  if(_loc20_ != null)
                  {
                     var _loc34_:IRoomGeometry = _container.roomEngine.getRoomCanvasGeometry(_loc2_.session.roomId,_container.getFirstCanvasId());
                     if(_loc34_ != null)
                     {
                        updateWidgetPosition();
                        _loc32_ = 0;
                        _loc33_ = 0;
                        var _loc3_:IVector3d = null.getLocation();
                        var _loc13_:Point = null.getScreenPoint(null);
                        if(_loc13_ != null)
                        {
                           _loc32_ = Number(null.x);
                           _loc33_ = Number(null.y);
                           var _loc6_:Point = _container.roomEngine.getRoomCanvasScreenOffset(_loc2_.session.roomId,_container.getFirstCanvasId());
                           if(_loc6_ != null)
                           {
                              _loc32_ += null.x;
                              _loc33_ += null.y;
                           }
                        }
                        var _loc5_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_.userId);
                        var _loc26_:String = "";
                        var _loc29_:uint = 0;
                        var _loc11_:BitmapData = null;
                        var _loc8_:int = 32;
                        var _loc17_:int = 2;
                        var _loc15_:Boolean = true;
                        var _loc21_:String = null;
                        var _loc18_:int = _loc2_.chatType;
                        var _loc16_:int = _loc2_.style;
                        var _loc36_:int = 0;
                        var _loc23_:int = -1;
                        var _loc14_:String = _loc2_.text;
                        var _loc9_:String = "RWCUE_EVENT_CHAT";
                        var _loc35_:Event = new RoomWidgetChatUpdateEvent(null,_loc2_.userId,null,null,100,0,0,_loc32_,_loc33_,null,0,_loc2_.session.roomId,0,0,_loc2_.links);
                     }
                  }
               }
               break;
            case "gce_game_chat":
               gameChatEventHandler(param1 as GameChatEvent);
         }
         if(_container != null && _container.events != null && null != null)
         {
            _container.events.dispatchEvent(null);
         }
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return container.roomEngine.getRoomObject(container.roomEngine.activeRoomId,param1,100);
      }
      
      public function getUserImage(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = _avatarImageCache.getValue(param1) as BitmapData;
         if(_loc2_ == null)
         {
            var _loc4_:class_1827 = _container.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            if(_loc4_ != null)
            {
               _loc2_ = null.getCroppedImage("head",0.5);
               var _loc3_:IPartColor = null.getPartColor("ch");
               null.dispose();
            }
         }
         if(_loc2_ != null)
         {
            _avatarImageCache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function gameChatEventHandler(param1:GameChatEvent) : void
      {
         var_16.addChatMessage(param1.message,param1.name,param1.locX,getUserImage(param1.figure),param1.color,param1.notify);
      }
      
      public function update() : void
      {
         updateWidgetPosition();
      }
      
      private function updateWidgetPosition() : void
      {
         var _loc3_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:RoomWidgetRoomViewUpdateEvent = null;
         var _loc1_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         if(_container == null || _container.roomSession == null || _container.roomEngine == null || _container.events == null)
         {
            return;
         }
         var _loc2_:int = _container.getFirstCanvasId();
         var _loc9_:int = _container.roomSession.roomId;
         var _loc6_:RoomGeometry = _container.roomEngine.getRoomCanvasGeometry(_loc9_,_loc2_) as RoomGeometry;
         if(_loc6_ != null)
         {
            _loc3_ = 1;
            if(var_1881 > 0)
            {
               _loc3_ = _loc6_.scale / var_1881;
            }
            if(var_1055 == null)
            {
               var_1208.x = 0;
               var_1208.y = 0;
               var_1208.z = 0;
               var_1055 = _loc6_.getScreenPoint(var_1208);
               var_1881 = _loc6_.scale - 10;
            }
            _loc7_ = "";
            _loc8_ = null;
            var_1208.x = 0;
            var_1208.y = 0;
            var_1208.z = 0;
            _loc1_ = _loc6_.getScreenPoint(var_1208);
            if(_loc1_ != null)
            {
               _loc4_ = _container.roomEngine.getRoomCanvasScreenOffset(_loc9_,_loc2_);
               if(_loc4_ != null)
               {
                  _loc1_.offset(_loc4_.x,_loc4_.y);
               }
               if(_loc1_.x != var_1055.x || _loc1_.y != var_1055.y)
               {
                  _loc5_ = PointMath.sub(_loc1_,PointMath.mul(var_1055,_loc3_));
                  if(_loc5_.x != 0 || _loc5_.y != 0)
                  {
                     _loc7_ = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
                     _loc8_ = new RoomWidgetRoomViewUpdateEvent(_loc7_,null,_loc5_);
                     _container.events.dispatchEvent(_loc8_);
                  }
                  var_1055 = _loc1_;
               }
            }
            if(_loc6_.scale != var_1881)
            {
               _loc7_ = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
               _loc8_ = new RoomWidgetRoomViewUpdateEvent(_loc7_,null,null,_loc6_.scale);
               _container.events.dispatchEvent(_loc8_);
               var_1881 = _loc6_.scale;
            }
         }
      }
      
      public function petImageReady(param1:String) : void
      {
         if(_petImageCache)
         {
            var _loc2_:BitmapData = _petImageCache.remove(param1) as BitmapData;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_avatarImageCache)
         {
            var _loc2_:BitmapData = _avatarImageCache.remove(param1) as BitmapData;
         }
      }
      
      private function getPetImage(param1:String, param2:int, param3:Boolean, param4:int = 64, param5:String = null) : BitmapData
      {
         var _loc10_:BitmapData = _petImageCache.getValue(param1 + param5) as BitmapData;
         if(_loc10_ == null)
         {
            var _loc6_:PetFigureData = new PetFigureData(param1);
            var _loc8_:int = _loc6_.typeId;
            var _loc7_:uint = 0;
            var _loc11_:* = 0 != 15;
            var _loc9_:class_2198 = _container.roomEngine.getPetImage(0,null.paletteId,null.color,new Vector3d(param2 * 45),param4,this,false,0,null.customParts,param5);
            if(_loc9_ != null)
            {
               _loc10_ = null.data;
               if(null.id > 0)
               {
                  _petImageIdToFigureString.add(null.id,null.figureString);
               }
            }
         }
         if(_loc10_ != null)
         {
            _petImageCache.add(param1 + param5,_loc10_);
         }
         return _loc10_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = _petImageIdToFigureString.remove(param1);
         if(_loc3_ != null)
         {
            petImageReady(_loc3_);
            if(_petImageCache)
            {
               _petImageCache.add(_loc3_,param2);
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

