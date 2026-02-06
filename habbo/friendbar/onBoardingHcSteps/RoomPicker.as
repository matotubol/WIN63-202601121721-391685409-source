package com.sulake.habbo.friendbar.onBoardingHcSteps
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.friendbar.onBoardingHc.OnBoardingHcFlow;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.SelectInitialRoomComposer;
   import com.sulake.habbo.communication.messages.incoming.nux.SelectInitialRoomEvent;
   import com.sulake.habbo.communication.messages.parser.nux.SelectInitialRoomEventParser;
   
   public class RoomPicker implements class_13
   {
      
      private static const room_image_border_png:Class = room_image_border_new_png$6646f45ed281a765bd98eacf07da028a2060407454;
      
      private static const room_selected_icon_png:Class = icon_yes_png$967ba2d0e8e2155576d701fbafc3cf571583745942;
      
      private var var_2565:Array = [];
      
      private var _numOfRooms:int;
      
      private var _newUserFlow:OnBoardingHcFlow;
      
      private var _container:Sprite;
      
      private var var_1642:Sprite;
      
      private var var_2163:int = 1;
      
      private var var_1902:Array;
      
      private var var_1553:TextField;
      
      private var _roomName:TextField;
      
      private var var_3236:Button;
      
      private var _roomImageContainers:Array = [];
      
      private var var_1648:Bitmap;
      
      private var var_2181:int = 0;
      
      private var var_5256:int = 30;
      
      private var var_5162:IMessageEvent;
      
      public function RoomPicker(param1:OnBoardingHcFlow, param2:Sprite)
      {
         super();
         _newUserFlow = param1;
         _container = param2;
         var_5162 = param1.communicationManager.addHabboConnectionMessageEvent(new SelectInitialRoomEvent(onSelectInitialRoomResponse));
      }
      
      private static function get galleryUrl() : String
      {
         return "https://images.habbo.com/c_images/nux/";
      }
      
      private function onSelectInitialRoomResponse(param1:SelectInitialRoomEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:SelectInitialRoomEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.roomId > 0)
         {
            _newUserFlow.communicationManager.connection.send(new UpdateHomeRoomMessageComposer(_loc2_.roomId));
         }
         _newUserFlow.roomPickingCompleted();
      }
      
      public function fetchThumbnails() : void
      {
         var_1902 = _newUserFlow.getProperty("new.user.flow.roomTypes","10,11,12").split(",");
         _numOfRooms = var_1902.length;
         var _loc3_:int = 0;
         while(0 < _numOfRooms)
         {
            var _loc1_:Loader = new Loader();
            var _loc2_:URLRequest = new URLRequest(galleryUrl + "nux_room_" + var_1902[0] + "_round.png");
            null.load(null);
            null.contentLoaderInfo.addEventListener("complete",roomImageLoadCompleteHandler);
            var_2565.push(null);
            _loc3_++;
         }
      }
      
      public function init() : void
      {
         if(var_1902 == null)
         {
            fetchThumbnails();
         }
      }
      
      public function initView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Sprite = null;
         var _loc1_:Loader = null;
         var _loc2_:int = 0;
         var _loc5_:TextField = LoaderUI.createTextField("headerText",24,8309486,false,true,false,false);
         _loc5_.width = 500;
         _loc5_.thickness = 50;
         _container.addChild(_loc5_);
         _loc5_.htmlText = _newUserFlow.getLocalization("onboarding.room.information","Choose your first room. This room gets you started. You can create more free rooms later, if you like.");
         _loc5_.multiline = true;
         _loc5_.x = 25;
         _loc5_.y = -70;
         _loc6_ = 0;
         while(_loc6_ < _numOfRooms)
         {
            _loc3_ = new Sprite();
            _loc1_ = var_2565[_loc6_] as Loader;
            if(_loc1_ != null)
            {
               _loc3_.addChild(_loc1_);
            }
            _container.addChild(_loc3_);
            _roomImageContainers.push(_loc3_);
            _loc3_.name = String(_loc6_ + 1);
            _loc3_.addEventListener("click",onRoomClick);
            _loc2_ = (_loc6_ + 1) * var_5256 + _loc6_ * 280;
            _loc3_.x = _loc2_;
            _loc3_.y = 10;
            _loc6_++;
         }
         var_1642 = new Sprite();
         _container.addChild(var_1642);
         var_3236 = new ColouredButton("gfreen",_newUserFlow.getLocalization("room.select","Select"),new Rectangle(0,0,0,40),true,onButtonSelect);
         var _loc7_:Bitmap = LoaderUI.createBalloon(640,100,0,false,995918,"none");
         var_1642.addChild(_loc7_);
         _loc7_.x = var_5256;
         LoaderUI.lineUpVertically(_loc3_,20,_loc7_);
         var _loc4_:Sprite = new Sprite();
         _loc4_.addChild(var_3236);
         _container.addChild(_loc4_);
         _loc4_.x = 725;
         _loc4_.y = 360;
         if(!var_1553)
         {
            var_1553 = LoaderUI.createTextField(_newUserFlow.getLocalization("receptionist.start.title","Hiya!"),18,8309486,false);
            _roomName = LoaderUI.createTextField(_newUserFlow.getLocalization("onboarding.hint.hc","Room name"),20,16777215,false,true,false,false);
            _roomName.width = 260;
            _roomName.x = 50;
            var_1553.x = 50;
            var_1553.width = 260;
            LoaderUI.lineUpVertically(_loc3_,30,_roomName);
            LoaderUI.lineUpVertically(_loc3_,55,var_1553);
            var_1642.addChild(var_1553);
            var_1642.addChild(_roomName);
         }
         var_2163 = 1;
         if(!var_1648)
         {
            var_1648 = Bitmap(new room_selected_icon_png());
            var_1642.addChild(var_1648);
         }
         var_1642.visible = var_2181 == _numOfRooms;
         var_3236.visible = var_2181 == _numOfRooms;
         chooseRoom();
      }
      
      private function getRoomDescription() : void
      {
         var _loc1_:String = var_1902[var_2163 - 1];
         _roomName.text = _newUserFlow.getLocalization("room.name." + _loc1_,"Room " + _loc1_);
         var_1553.text = _newUserFlow.getLocalization("room.description." + _loc1_,"\nTwo-line description");
      }
      
      private function onButtonSelect(param1:DisplayObject) : void
      {
         var _loc2_:String = var_1902[var_2163 - 1];
         _newUserFlow.communicationManager.connection.send(new SelectInitialRoomComposer(_loc2_));
      }
      
      private function onRoomClick(param1:Event) : void
      {
         var_2163 = int(param1.currentTarget.name);
         chooseRoom();
      }
      
      private function roomImageLoadCompleteHandler(param1:Event) : void
      {
         var_2181 = var_2181 + 1;
         if(var_2181 == _numOfRooms)
         {
            initView();
         }
      }
      
      private function chooseRoom() : void
      {
         var _loc1_:Sprite = _roomImageContainers[var_2163 - 1];
         if(_loc1_ == null)
         {
            return;
         }
         var_1648.x = _loc1_.x;
         var_1648.y = _loc1_.y + _loc1_.height - var_1648.height;
         var_1648.visible = true;
         var_3236.visible = var_2181 == _numOfRooms;
         getRoomDescription();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _newUserFlow.communicationManager.removeHabboConnectionMessageEvent(var_5162);
         if(_container)
         {
            while(_container.numChildren > 0)
            {
               _container.removeChildAt(0);
            }
         }
         _container = null;
         var_2565 = null;
         _newUserFlow = null;
      }
      
      public function get disposed() : Boolean
      {
         return _newUserFlow == null;
      }
   }
}

