package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.avatar.enum.class_2814;
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectMoveEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarBlockedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.utils.getTimer;
   
   public class AvatarLogic extends MovingObjectLogic
   {
      
      private static const const_719:Number = 1.5;
      
      private static const EFFECT_TYPE_SPLASH:int = 28;
      
      private static const EFFECT_TYPE_SWIM:int = 29;
      
      private static const const_265:int = 184;
      
      private static const const_298:int = 185;
      
      private static const EFFECT_SPLASH_LENGTH:int = 500;
      
      private static const CARRY_ITEM_NULL:int = 0;
      
      private static const CARRY_ITEM_LAST_CONSUMABLE:int = 999;
      
      private static const CARRY_ITEM_EMPTY_HAND:int = 999999999;
      
      private static const CARRY_ITEM_DELAY_BEFORE_USE:int = 5000;
      
      private static const CARRY_ITEM_EMPTY_HAND_ANIMATION_LENGTH:int = 1500;
      
      private var _selected:Boolean = false;
      
      private var var_774:Vector3d = null;
      
      private var var_455:int = 0;
      
      private var var_1020:int = 0;
      
      private var var_2431:int = 0;
      
      private var var_1429:int = 0;
      
      private var var_1209:int = 0;
      
      private var var_1206:int = 0;
      
      private var var_2224:int = 0;
      
      private var var_2445:int = 0;
      
      private var var_2127:int = 0;
      
      private var var_1675:int = 0;
      
      private var _allowUseCarryObject:Boolean = false;
      
      private var var_2644:int = 0;
      
      private var var_3046:int = 0;
      
      private var var_2420:int = 0;
      
      public function AvatarLogic()
      {
         super();
         var_3046 = getTimer() + getBlinkInterval();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROE_MOUSE_CLICK","ROME_POSITION_CHANGED","ROE_MOUSE_ENTER","ROE_MOUSE_LEAVE","ROFCAE_MOUSE_BUTTON","ROFCAE_MOUSE_ARROW"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(_selected && object != null)
         {
            if(eventDispatcher != null)
            {
               _loc1_ = new RoomObjectMoveEvent("ROME_OBJECT_REMOVED",object);
               eventDispatcher.dispatchEvent(_loc1_);
            }
         }
         super.dispose();
         var_774 = null;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc12_:RoomObjectAvatarPostureUpdateMessage = null;
         var _loc24_:RoomObjectAvatarChatUpdateMessage = null;
         var _loc28_:RoomObjectAvatarTypingUpdateMessage = null;
         var _loc13_:RoomObjectAvatarMutedUpdateMessage = null;
         var _loc2_:RoomObjectAvatarPlayingGameMessage = null;
         var _loc20_:RoomObjectAvatarUpdateMessage = null;
         var _loc29_:RoomObjectAvatarDirectionUpdateMessage = null;
         var _loc19_:RoomObjectAvatarGestureUpdateMessage = null;
         var _loc14_:RoomObjectAvatarDanceUpdateMessage = null;
         var _loc15_:RoomObjectAvatarSleepUpdateMessage = null;
         var _loc25_:RoomObjectAvatarPlayerValueUpdateMessage = null;
         var _loc4_:RoomObjectAvatarEffectUpdateMessage = null;
         var _loc27_:int = 0;
         var _loc11_:int = 0;
         var _loc26_:RoomObjectAvatarCarryObjectUpdateMessage = null;
         var _loc8_:RoomObjectAvatarUseObjectUpdateMessage = null;
         var _loc5_:RoomObjectAvatarSignUpdateMessage = null;
         var _loc22_:RoomObjectAvatarFlatControlUpdateMessage = null;
         var _loc23_:Number = NaN;
         var _loc17_:RoomObjectAvatarFigureUpdateMessage = null;
         var _loc18_:String = null;
         var _loc9_:String = null;
         var _loc6_:String = null;
         var _loc10_:RoomObjectAvatarBlockedUpdateMessage = null;
         var _loc7_:Boolean = false;
         var _loc21_:RoomObjectAvatarSelectedMessage = null;
         var _loc3_:RoomObjectAvatarGuideStatusUpdateMessage = null;
         if(param1 == null || object == null)
         {
            return;
         }
         super.processUpdateMessage(param1);
         var _loc16_:IRoomObjectModelController = object.getModelController();
         if(param1 is RoomObjectAvatarPostureUpdateMessage)
         {
            _loc12_ = param1 as RoomObjectAvatarPostureUpdateMessage;
            _loc16_.setString("figure_posture",_loc12_.postureType);
            _loc16_.setString("figure_posture_parameter",_loc12_.parameter);
            return;
         }
         if(param1 is RoomObjectAvatarChatUpdateMessage)
         {
            _loc24_ = param1 as RoomObjectAvatarChatUpdateMessage;
            _loc16_.setNumber("figure_talk",1);
            var_2431 = getTimer() + _loc24_.numberOfWords * 1000;
            return;
         }
         if(param1 is RoomObjectAvatarTypingUpdateMessage)
         {
            _loc28_ = param1 as RoomObjectAvatarTypingUpdateMessage;
            _loc16_.setNumber("figure_is_typing",Number(_loc28_.isTyping));
            return;
         }
         if(param1 is RoomObjectAvatarMutedUpdateMessage)
         {
            _loc13_ = param1 as RoomObjectAvatarMutedUpdateMessage;
            _loc16_.setNumber("figure_is_muted",Number(_loc13_.isMuted));
            return;
         }
         if(param1 is RoomObjectAvatarPlayingGameMessage)
         {
            _loc2_ = param1 as RoomObjectAvatarPlayingGameMessage;
            _loc16_.setNumber("figure_is_playing_game",Number(_loc2_.isPlayingGame));
            return;
         }
         if(param1 is RoomObjectAvatarUpdateMessage)
         {
            _loc20_ = param1 as RoomObjectAvatarUpdateMessage;
            _loc16_.setNumber("head_direction",_loc20_.dirHead);
            _loc16_.setNumber("figure_can_stand_up",Number(_loc20_.canStandUp));
            _loc16_.setNumber("figure_vertical_offset",_loc20_.baseY);
            return;
         }
         if(param1 is RoomObjectAvatarDirectionUpdateMessage)
         {
            _loc29_ = param1 as RoomObjectAvatarDirectionUpdateMessage;
            _loc16_.setNumber("head_direction",_loc29_.dirHead);
            return;
         }
         if(param1 is RoomObjectAvatarGestureUpdateMessage)
         {
            _loc19_ = param1 as RoomObjectAvatarGestureUpdateMessage;
            _loc16_.setNumber("figure_gesture",_loc19_.gesture);
            var_2224 = getTimer() + 3000;
            return;
         }
         if(param1 is RoomObjectAvatarExpressionUpdateMessage)
         {
            _loc16_.setNumber("figure_expression",RoomObjectAvatarExpressionUpdateMessage(param1).expressionType);
            var_1206 = class_2814.getExpressionTime(_loc16_.getNumber("figure_expression"));
            if(var_1206 > -1)
            {
               var_1206 += getTimer();
            }
            return;
         }
         if(param1 is RoomObjectAvatarDanceUpdateMessage)
         {
            _loc14_ = param1 as RoomObjectAvatarDanceUpdateMessage;
            _loc16_.setNumber("figure_dance",_loc14_.danceStyle);
            return;
         }
         if(param1 is RoomObjectAvatarSleepUpdateMessage)
         {
            _loc15_ = param1 as RoomObjectAvatarSleepUpdateMessage;
            _loc16_.setNumber("figure_sleep",Number(_loc15_.isSleeping));
            return;
         }
         if(param1 is RoomObjectAvatarPlayerValueUpdateMessage)
         {
            _loc25_ = param1 as RoomObjectAvatarPlayerValueUpdateMessage;
            _loc16_.setNumber("figure_number_value",_loc25_.value);
            var_2420 = getTimer() + 3000;
            return;
         }
         if(param1 is RoomObjectAvatarEffectUpdateMessage)
         {
            _loc4_ = param1 as RoomObjectAvatarEffectUpdateMessage;
            _loc27_ = _loc4_.effect;
            _loc11_ = _loc4_.delayMilliSeconds;
            updateEffect(_loc27_,_loc11_,_loc16_);
            return;
         }
         if(param1 is RoomObjectAvatarCarryObjectUpdateMessage)
         {
            _loc26_ = param1 as RoomObjectAvatarCarryObjectUpdateMessage;
            _loc16_.setNumber("figure_carry_object",_loc26_.itemType);
            _loc16_.setNumber("figure_use_object",0);
            var_2127 = getTimer();
            if(_loc26_.itemType < 999999999)
            {
               var_1675 = 0;
               _allowUseCarryObject = _loc26_.itemType <= 999;
            }
            else
            {
               var_1675 = var_2127 + 1500;
               _allowUseCarryObject = false;
            }
            return;
         }
         if(param1 is RoomObjectAvatarUseObjectUpdateMessage)
         {
            _loc8_ = param1 as RoomObjectAvatarUseObjectUpdateMessage;
            _loc16_.setNumber("figure_use_object",_loc8_.itemType);
            return;
         }
         if(param1 is RoomObjectAvatarSignUpdateMessage)
         {
            _loc5_ = param1 as RoomObjectAvatarSignUpdateMessage;
            _loc16_.setNumber("figure_sign",_loc5_.signType);
            var_2445 = getTimer() + 5000;
            return;
         }
         if(param1 is RoomObjectAvatarFlatControlUpdateMessage)
         {
            _loc22_ = param1 as RoomObjectAvatarFlatControlUpdateMessage;
            _loc23_ = parseInt(_loc22_.rawData);
            if(_loc23_ == _loc23_ && _loc23_ >= 0 && _loc23_ <= 5)
            {
               _loc16_.setNumber("figure_flat_control",_loc23_);
            }
            else
            {
               _loc16_.setNumber("figure_flat_control",0);
            }
            return;
         }
         if(param1 is RoomObjectAvatarFigureUpdateMessage)
         {
            _loc17_ = param1 as RoomObjectAvatarFigureUpdateMessage;
            _loc18_ = _loc16_.getString("figure");
            _loc9_ = _loc17_.figure;
            _loc6_ = _loc17_.gender;
            if(_loc18_ != null && _loc18_.indexOf(".bds-") != -1)
            {
               _loc9_ += _loc18_.substr(_loc18_.indexOf(".bds-"));
            }
            _loc16_.setString("figure",_loc9_);
            _loc16_.setString("gender",_loc6_);
            return;
         }
         if(param1 is RoomObjectAvatarBlockedUpdateMessage)
         {
            _loc10_ = param1 as RoomObjectAvatarBlockedUpdateMessage;
            _loc7_ = _loc10_.isBlocked;
            _loc16_.setNumber("blocked",_loc7_ ? 1 : 0);
            return;
         }
         if(param1 is RoomObjectAvatarSelectedMessage)
         {
            _loc21_ = param1 as RoomObjectAvatarSelectedMessage;
            _selected = _loc21_.selected;
            var_774 = null;
            return;
         }
         if(param1 is RoomObjectAvatarGuideStatusUpdateMessage)
         {
            _loc3_ = param1 as RoomObjectAvatarGuideStatusUpdateMessage;
            _loc16_.setNumber("figure_guide_status",_loc3_.guideStatus);
            return;
         }
         if(param1 is RoomObjectAvatarOwnMessage)
         {
            _loc16_.setNumber("own_user",1);
            return;
         }
      }
      
      private function updateEffect(param1:int, param2:int, param3:IRoomObjectModelController) : void
      {
         if(param1 == 28)
         {
            var_455 = getTimer() + 500;
            var_1020 = 29;
         }
         else if(param1 == 184)
         {
            var_455 = getTimer() + 500;
            var_1020 = 185;
         }
         else if(param3.getNumber("figure_effect") == 29)
         {
            var_455 = getTimer() + 500;
            var_1020 = param1;
            param1 = 28;
         }
         else if(param3.getNumber("figure_effect") == 185)
         {
            var_455 = getTimer() + 500;
            var_1020 = param1;
            param1 = 184;
         }
         else
         {
            if(param2 != 0)
            {
               var_455 = getTimer() + param2;
               var_1020 = param1;
               return;
            }
            var_455 = 0;
         }
         param3.setNumber("figure_effect",param1);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModelController = object.getModelController();
         var _loc4_:String = null;
         switch(param1.type)
         {
            case "click":
               _loc4_ = "ROE_MOUSE_CLICK";
               break;
            case "rollOver":
               _loc4_ = "ROE_MOUSE_ENTER";
               if(_loc3_ != null)
               {
                  _loc3_.setNumber("figure_highlight",1);
               }
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_BUTTON",object));
               break;
            case "rollOut":
               if(_loc3_ != null)
               {
                  _loc3_.setNumber("figure_highlight",0);
               }
               _loc4_ = "ROE_MOUSE_LEAVE";
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW",object));
         }
         if(_loc4_ != null)
         {
            if(eventDispatcher != null)
            {
               var _loc5_:RoomObjectEvent = new RoomObjectMouseEvent(_loc4_,object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
               eventDispatcher.dispatchEvent(null);
            }
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:IVector3d = null;
         var _loc4_:RoomObjectEvent = null;
         var _loc3_:IRoomObjectModelController = null;
         super.update(param1);
         if(_selected && object != null)
         {
            if(eventDispatcher != null)
            {
               _loc2_ = object.getLocation();
               if(var_774 == null || var_774.x != _loc2_.x || var_774.y != _loc2_.y || var_774.z != _loc2_.z)
               {
                  if(var_774 == null)
                  {
                     var_774 = new Vector3d();
                  }
                  var_774.assign(_loc2_);
                  _loc4_ = new RoomObjectMoveEvent("ROME_POSITION_CHANGED",object);
                  eventDispatcher.dispatchEvent(_loc4_);
               }
            }
         }
         if(object != null)
         {
            _loc3_ = object.getModelController();
            if(_loc3_ != null)
            {
               updateActions(param1,_loc3_);
            }
         }
      }
      
      private function updateActions(param1:int, param2:IRoomObjectModelController) : void
      {
         if(var_2431 > 0)
         {
            if(param1 > var_2431)
            {
               param2.setNumber("figure_talk",0);
               var_2431 = 0;
               var_1209 = 0;
               var_1429 = 0;
            }
            else if(var_1429 == 0 && var_1209 == 0)
            {
               var_1209 = param1 + getTalkingPauseInterval();
               var_1429 = var_1209 + getTalkingPauseLength();
            }
            else if(var_1209 > 0 && param1 > var_1209)
            {
               param2.setNumber("figure_talk",0);
               var_1209 = 0;
            }
            else if(var_1429 > 0 && param1 > var_1429)
            {
               param2.setNumber("figure_talk",1);
               var_1429 = 0;
            }
         }
         if(var_1206 > 0 && param1 > var_1206)
         {
            param2.setNumber("figure_expression",0);
            var_1206 = 0;
         }
         if(var_2224 > 0 && param1 > var_2224)
         {
            param2.setNumber("figure_gesture",0);
            var_2224 = 0;
         }
         if(var_2445 > 0 && param1 > var_2445)
         {
            param2.setNumber("figure_sign",-1);
            var_2445 = 0;
         }
         if(var_1675 > 0)
         {
            if(param1 > var_1675)
            {
               param2.setNumber("figure_carry_object",0);
               param2.setNumber("figure_use_object",0);
               var_2127 = var_1675 = 0;
               _allowUseCarryObject = false;
            }
         }
         if(_allowUseCarryObject)
         {
            if(param1 - var_2127 > 5000)
            {
               if((param1 - var_2127) % 10000 < 1000)
               {
                  param2.setNumber("figure_use_object",1);
               }
               else
               {
                  param2.setNumber("figure_use_object",0);
               }
            }
         }
         if(param1 > var_3046)
         {
            param2.setNumber("figure_blink",1);
            var_3046 = param1 + getBlinkInterval();
            var_2644 = param1 + getBlinkLength();
         }
         if(var_2644 > 0 && param1 > var_2644)
         {
            param2.setNumber("figure_blink",0);
            var_2644 = 0;
         }
         if(var_455 > 0 && param1 > var_455)
         {
            param2.setNumber("figure_effect",var_1020);
            var_455 = 0;
         }
         if(var_2420 > 0 && param1 > var_2420)
         {
            param2.setNumber("figure_number_value",0);
            var_2420 = 0;
         }
      }
      
      private function getTalkingPauseInterval() : int
      {
         return 100 + Math.random() * 200;
      }
      
      private function getTalkingPauseLength() : int
      {
         return 75 + Math.random() * 75;
      }
      
      private function getBlinkInterval() : int
      {
         return 4500 + Math.random() * 1000;
      }
      
      private function getBlinkLength() : int
      {
         return 50 + Math.random() * 200;
      }
      
      private function targetIsWarping(param1:IVector3d) : Boolean
      {
         var _loc2_:IVector3d = object.getLocation();
         if(param1 == null)
         {
            return false;
         }
         if(_loc2_.x == 0 && _loc2_.y == 0)
         {
            return false;
         }
         if(Math.abs(_loc2_.x - param1.x) > 1.5 || Math.abs(_loc2_.y - param1.y) > 1.5)
         {
            return true;
         }
         return false;
      }
   }
}

