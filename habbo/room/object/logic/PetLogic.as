package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.events.RoomObjectMoveEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.class_2119;
   import flash.utils.getTimer;
   
   public class PetLogic extends MovingObjectLogic
   {
      
      private var var_2431:int = 0;
      
      private var var_2224:int = 0;
      
      private var var_3392:int = 0;
      
      private var _selected:Boolean = false;
      
      private var var_774:Vector3d = null;
      
      private var var_4841:Boolean = false;
      
      private var var_3667:int = 0;
      
      private var var_3741:int = 0;
      
      private var _headDirectionDelta:int = 0;
      
      private var var_1878:int = 0;
      
      private var _directions:Array = [];
      
      public function PetLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROE_MOUSE_CLICK","ROME_POSITION_CHANGED"];
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
         _directions = null;
         super.dispose();
         var_774 = null;
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         _directions = [];
         var _loc2_:XMLList = param1.model.directions.direction;
         var _loc3_:Array = ["id"];
         var _loc4_:int = 0;
         while(0 < _loc2_.length())
         {
            var _loc6_:XML = _loc2_[0];
            if(class_2119.checkRequiredAttributes(null,_loc3_))
            {
               var _loc5_:int = parseInt(null.@id);
               _directions.push(0);
            }
            _loc4_++;
         }
         _directions.sort(16);
         object.getModelController().setNumberArray("pet_allowed_directions",_directions,true);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:RoomObjectAvatarSelectedMessage = null;
         var _loc5_:RoomObjectAvatarExperienceUpdateMessage = null;
         var _loc11_:RoomObjectAvatarFigureUpdateMessage = null;
         var _loc12_:String = null;
         var _loc6_:PetFigureData = null;
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc9_:IRoomObjectModelController = object.getModelController();
         if(!var_4841)
         {
            super.processUpdateMessage(param1);
            if(param1 is RoomObjectAvatarPostureUpdateMessage)
            {
               var _loc7_:RoomObjectAvatarPostureUpdateMessage = param1 as RoomObjectAvatarPostureUpdateMessage;
               _loc9_.setString("figure_posture",null.postureType);
               return;
            }
            if(param1 is RoomObjectAvatarUpdateMessage)
            {
               var _loc2_:RoomObjectAvatarUpdateMessage = param1 as RoomObjectAvatarUpdateMessage;
               _loc9_.setNumber("head_direction",null.dirHead);
               return;
            }
            if(param1 is RoomObjectAvatarDirectionUpdateMessage)
            {
               var _loc10_:RoomObjectAvatarDirectionUpdateMessage = param1 as RoomObjectAvatarDirectionUpdateMessage;
               _loc9_.setNumber("head_direction",null.dirHead);
               return;
            }
            if(param1 is RoomObjectAvatarChatUpdateMessage)
            {
               var _loc4_:RoomObjectAvatarChatUpdateMessage = param1 as RoomObjectAvatarChatUpdateMessage;
               _loc9_.setNumber("figure_talk",1);
               var_2431 = getTimer() + null.numberOfWords * 1000;
               return;
            }
            if(param1 is RoomObjectAvatarPetGestureUpdateMessage)
            {
               var _loc13_:RoomObjectAvatarPetGestureUpdateMessage = param1 as RoomObjectAvatarPetGestureUpdateMessage;
               _loc9_.setString("figure_gesture",null.gesture);
               var_2224 = getTimer() + 3000;
               return;
            }
            if(param1 is RoomObjectAvatarSleepUpdateMessage)
            {
               var _loc8_:RoomObjectAvatarSleepUpdateMessage = param1 as RoomObjectAvatarSleepUpdateMessage;
               _loc9_.setNumber("figure_sleep",Number(null.isSleeping));
               return;
            }
         }
         if(param1 is RoomObjectAvatarSelectedMessage)
         {
            _loc3_ = param1 as RoomObjectAvatarSelectedMessage;
            _selected = _loc3_.selected;
            var_774 = null;
            return;
         }
         if(param1 is RoomObjectAvatarExperienceUpdateMessage)
         {
            _loc5_ = param1 as RoomObjectAvatarExperienceUpdateMessage;
            _loc9_.setNumber("figure_experience_timestamp",getTimer());
            _loc9_.setNumber("figure_gained_experience",_loc5_.gainedExperience);
            return;
         }
         if(param1 is RoomObjectAvatarFigureUpdateMessage)
         {
            _loc11_ = param1 as RoomObjectAvatarFigureUpdateMessage;
            _loc12_ = _loc9_.getString("figure");
            _loc6_ = new PetFigureData(_loc11_.figure);
            _loc9_.setString("figure",_loc11_.figure);
            _loc9_.setString("race",_loc11_.race);
            _loc9_.setNumber("pet_palette_index",_loc6_.paletteId);
            _loc9_.setNumber("pet_color",_loc6_.color);
            _loc9_.setNumber("pet_type",_loc6_.typeId);
            _loc9_.setNumberArray("pet_custom_layer_ids",_loc6_.customLayerIds);
            _loc9_.setNumberArray("pet_custom_part_ids",_loc6_.customPartIds);
            _loc9_.setNumberArray("pet_custom_palette_ids",_loc6_.customPaletteIds);
            _loc9_.setNumber("pet_is_riding",_loc11_.isRiding ? 1 : 0);
            return;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc6_:IRoomObjectModelController = object.getModelController();
         var _loc7_:String = null;
         switch(param1.type)
         {
            case "click":
               _loc7_ = "ROE_MOUSE_CLICK";
               if(var_4841)
               {
                  debugMouseEvent(param1);
               }
               break;
            case "mouseDown":
               if(!var_4841)
               {
                  var _loc5_:int = int(_loc6_.getNumber("pet_type"));
                  if(_loc5_ == 16)
                  {
                     if(eventDispatcher != null)
                     {
                        var _loc8_:RoomObjectEvent = new RoomObjectMouseEvent("ROE_MOUSE_DOWN",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                        eventDispatcher.dispatchEvent(null);
                     }
                  }
               }
               break;
            case "doubleClick":
         }
         if(_loc7_ != null)
         {
            if(eventDispatcher != null)
            {
               _loc8_ = new RoomObjectMouseEvent(_loc7_,object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
               eventDispatcher.dispatchEvent(null);
            }
         }
      }
      
      private function debugMouseEvent(param1:RoomSpriteMouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomObjectModelController = object.getModelController();
         if(!param1.altKey && !param1.ctrlKey)
         {
            _loc3_ = int(_directions[var_1878]);
            object.setDirection(new Vector3d(_loc3_));
            _loc2_.setNumber("head_direction",_loc3_ + _headDirectionDelta);
            var_1878 = var_1878 + 1;
            if(var_1878 == _directions.length)
            {
               var_1878 = 0;
            }
         }
         else if(param1.altKey && !param1.ctrlKey)
         {
            var_3667 = var_3667 + 1;
            _loc2_.setNumber("figure_posture",var_3667);
            _loc2_.setNumber("figure_gesture",NaN);
         }
         else if(param1.ctrlKey && !param1.altKey)
         {
            var_3741 = var_3741 + 1;
            _loc2_.setNumber("figure_gesture",var_3741);
         }
         else
         {
            _headDirectionDelta += 45;
            if(_headDirectionDelta > 45)
            {
               _headDirectionDelta = -45;
            }
            _loc3_ = int(object.getDirection().x);
            _loc2_.setNumber("head_direction",_loc3_ + _headDirectionDelta);
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:IVector3d = null;
         var _loc3_:RoomObjectEvent = null;
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
                  _loc3_ = new RoomObjectMoveEvent("ROME_POSITION_CHANGED",object);
                  eventDispatcher.dispatchEvent(_loc3_);
               }
            }
         }
         if(object != null && object.getModelController() != null)
         {
            updateActions(param1,object.getModelController());
         }
      }
      
      private function updateActions(param1:int, param2:IRoomObjectModelController) : void
      {
         if(var_2224 > 0 && param1 > var_2224)
         {
            param2.setString("figure_gesture",null);
            var_2224 = 0;
         }
         if(var_2431 > 0)
         {
            if(param1 > var_2431)
            {
               param2.setNumber("figure_talk",0);
               var_2431 = 0;
            }
         }
         if(var_3392 > 0 && param1 > var_3392)
         {
            param2.setNumber("figure_expression",0);
            var_3392 = 0;
         }
      }
   }
}

