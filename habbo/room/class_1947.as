package com.sulake.habbo.room
{
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.communication.messages.outgoing.room.class_3165;
   import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlaySoundEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectSamplePlaybackEvent;
   import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
   import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;
   import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
   import com.sulake.habbo.room.events.RoomObjectHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomObjectPlaySoundIdEvent;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.events.RoomObjectSamplePlaybackEvent;
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
   import com.sulake.habbo.room.utils.RoomAreaSelectionManager;
   import com.sulake.habbo.room.utils.class_1821;
   import com.sulake.habbo.room.utils.class_1925;
   import com.sulake.habbo.room.utils.class_1934;
   import com.sulake.habbo.room.utils.class_2247;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.renderer.IRoomRenderingCanvasMouseListener;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomEnterEffect;
   import com.sulake.room.utils.Vector3d;
   import flash.events.IEventDispatcher;
   import package_103.class_3070;
   import package_107.class_3037;
   import package_55.ClickFurniMessageComposer;
   import package_55.class_2048;
   import package_55.class_2364;
   import package_55.class_2426;
   import package_55.class_2430;
   import package_55.class_2449;
   import package_55.class_2536;
   import package_55.class_2766;
   import package_55.class_2945;
   import package_55.class_2986;
   import package_55.class_3044;
   import package_55.class_3179;
   import package_55.class_3221;
   import package_55.class_3295;
   import package_55.class_3530;
   import package_55.class_3639;
   import package_70.class_2618;
   import package_94.class_2415;
   import package_94.class_2698;
   import package_94.class_2726;
   import package_94.class_3097;
   import package_94.class_3139;
   import package_94.class_3454;
   import package_94.class_3588;
   
   [SecureSWF(rename="true")]
   public class class_1947 implements IRoomRenderingCanvasMouseListener
   {
      
      private var _roomEngine:class_32 = null;
      
      private var var_1471:class_55 = null;
      
      private var var_2203:int = -1;
      
      private var var_1791:int = -1;
      
      private var var_3175:int = -2;
      
      private var var_3789:String;
      
      private var _moveMouseEventCache:RoomObjectMouseEvent = null;
      
      public function class_1947(param1:class_32)
      {
         super();
         var_1471 = new class_55();
         _roomEngine = param1;
      }
      
      protected function get roomEngine() : class_32
      {
         return _roomEngine;
      }
      
      public function dispose() : void
      {
         if(var_1471 != null)
         {
            var_1471.dispose();
            var_1471 = null;
         }
         _roomEngine = null;
      }
      
      public function initializeRoomObjectInsert(param1:String, param2:int, param3:int, param4:int, param5:int, param6:String = null, param7:IStuffData = null, param8:int = -1, param9:int = -1, param10:String = null, param11:Boolean = false) : Boolean
      {
         var_3789 = param1;
         var _loc12_:IVector3d = new Vector3d(-100,-100);
         var _loc13_:IVector3d = new Vector3d(0);
         setSelectedObjectData(param2,param3,param4,_loc12_,_loc13_,"OBJECT_PLACE",param5,param6,param7,param8,param9,param10);
         if(_roomEngine != null)
         {
            _roomEngine.setObjectMoverIconSprite(param5,param4,false,param6,param7,param8,param9,param10);
            _roomEngine.setObjectMoverIconSpriteVisible(false);
         }
         if(param11)
         {
            recalibrateMovements(param2,false);
         }
         return true;
      }
      
      public function cancelRoomObjectInsert(param1:int) : Boolean
      {
         resetSelectedObjectData(param1);
         return true;
      }
      
      private function getSelectedObjectData(param1:int) : class_1925
      {
         if(_roomEngine == null)
         {
            return null;
         }
         var _loc2_:ISelectedRoomObjectData = _roomEngine.getSelectedObjectData(param1);
         return _loc2_ as class_1925;
      }
      
      private function setSelectedObjectData(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:String, param7:int = 0, param8:String = null, param9:IStuffData = null, param10:int = -1, param11:int = -1, param12:String = null) : void
      {
         resetSelectedObjectData(param1);
         if(_roomEngine == null)
         {
            return;
         }
         var _loc13_:class_1925 = new class_1925(param2,param3,param6,param4,param5,param7,param8,param9,param10,param11,param12);
         _roomEngine.setSelectedObjectData(param1,_loc13_);
      }
      
      private function updateSelectedObjectData(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:String, param7:int = 0, param8:String = null, param9:IStuffData = null, param10:int = -1, param11:int = -1, param12:String = null) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc13_:class_1925 = new class_1925(param2,param3,param6,param4,param5,param7,param8,param9,param10,param11,param12);
         _roomEngine.setSelectedObjectData(param1,_loc13_);
      }
      
      private function resetSelectedObjectData(param1:int) : void
      {
         var _loc5_:IRoomObjectController = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_roomEngine == null)
         {
            return;
         }
         if(_roomEngine != null)
         {
            _roomEngine.removeObjectMoverIconSprite();
         }
         var _loc2_:class_1925 = getSelectedObjectData(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.operation == "OBJECT_MOVE" || _loc2_.operation == "OBJECT_MOVE_TO")
            {
               _loc5_ = _roomEngine.getRoomObject(param1,_loc2_.id,_loc2_.category) as IRoomObjectController;
               if(_loc5_ != null && _loc2_.operation != "OBJECT_MOVE_TO")
               {
                  _loc5_.setLocation(_loc2_.loc);
                  _loc5_.setDirection(_loc2_.dir);
               }
               setObjectAlphaMultiplier(_loc5_,1);
               if(_loc2_.category == 20)
               {
                  _roomEngine.updateObjectRoomWindow(param1,_loc2_.id,true);
               }
               updateSelectedObjectData(param1,_loc2_.id,_loc2_.category,_loc2_.loc,_loc2_.dir,"OBJECT_MOVE",_loc2_.typeId,_loc2_.instanceData,_loc2_.stuffData,_loc2_.state,_loc2_.animFrame,_loc2_.posture);
            }
            if(_loc2_.operation == "OBJECT_PLACE")
            {
               _loc3_ = _loc2_.id;
               switch(_loc4_ = _loc2_.category)
               {
                  case 10:
                     _roomEngine.disposeObjectFurniture(param1,_loc3_);
                     break;
                  case 20:
                     _roomEngine.disposeObjectWallItem(param1,_loc3_);
                     break;
                  case 100:
                     _roomEngine.disposeObjectUser(param1,_loc3_);
               }
            }
            _roomEngine.setSelectedObjectData(param1,null);
         }
      }
      
      public function setSelectedObject(param1:int, param2:int, param3:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc4_:IEventDispatcher = _roomEngine.events;
         if(_loc4_ == null)
         {
            return;
         }
         switch(param3)
         {
            case 100:
            case 10:
            case 20:
               if(param3 == 100)
               {
                  deselectObject(param1);
                  setSelectedAvatar(param1,param2,true);
               }
               else
               {
                  setSelectedAvatar(param1,0,false);
                  if(param2 != var_1791)
                  {
                     deselectObject(param1);
                     var _loc5_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,param3) as IRoomObjectController;
                     if(_loc5_ != null && null.getEventHandler() != null)
                     {
                        null.getEventHandler().processUpdateMessage(new RoomObjectSelectedMessage(true));
                        var_1791 = param2;
                        var_3175 = param3;
                     }
                  }
               }
               _loc4_.dispatchEvent(new RoomEngineObjectEvent("REOE_SELECTED",param1,param2,param3));
         }
      }
      
      private function deselectObject(param1:int) : void
      {
         if(var_1791 != -1)
         {
            var _loc2_:IRoomObjectController = _roomEngine.getRoomObject(param1,var_1791,var_3175) as IRoomObjectController;
         }
      }
      
      public function processRoomCanvasMouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomObject, param3:IRoomGeometry) : void
      {
         if(RoomEnterEffect.isRunning())
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc6_:String = param2.getType();
         var _loc5_:int = _roomEngine.getRoomObjectCategory(_loc6_);
         if(_loc5_ != 0)
         {
            if(!_roomEngine.getActiveRoomIsPlayingGame())
            {
               _loc5_ = -2;
            }
            else if(_loc5_ != 100)
            {
               _loc5_ = -2;
            }
         }
         var _loc4_:String = getMouseEventId(_loc5_,param1.type);
         if(_loc4_ == param1.eventId)
         {
            if(param1.type == "click" || param1.type == "doubleClick" || param1.type == "mouseDown" || param1.type == "mouseUp" || param1.type == "mouseMove")
            {
               return;
            }
         }
         else if(param1.eventId != null)
         {
            setMouseEventId(_loc5_,param1.type,param1.eventId);
         }
         if(param2.getMouseHandler() != null)
         {
            param2.getMouseHandler().mouseEvent(param1,param3);
         }
      }
      
      public function handleRoomObjectEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is RoomObjectMouseEvent)
         {
            handleRoomObjectMouseEvent(param1 as RoomObjectMouseEvent,param2);
            return;
         }
         switch(param1.type)
         {
            case "ROSCE_STATE_CHANGE":
               handleObjectStateChange(param1 as RoomObjectStateChangeEvent,param2);
               break;
            case "ROSCE_STATE_RANDOM":
               handleObjectRandomStateChange(param1 as RoomObjectStateChangeEvent,param2);
               break;
            case "RODSUE_DIMMER_STATE":
               handleObjectDimmerStateEvent(param1,param2);
               break;
            case "ROME_POSITION_CHANGED":
               handleSelectedObjectMove(param1,param2);
               break;
            case "ROME_OBJECT_REMOVED":
               handleSelectedObjectRemove(param1,param2);
               break;
            case "ROME_SLIDE_ANIMATION":
               handleObjectSlide(param1,param2);
               break;
            case "ROWRE_OPEN_WIDGET":
            case "ROWRE_CLOSE_WIDGET":
            case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
            case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
            case "ROWRE_PLACEHOLDER":
            case "ROWRE__CREDITFURNI":
            case "ROWRE__STICKIE":
            case "ROWRE_PRESENT":
            case "ROWRE_TROPHY":
            case "ROWRE_TEASER":
            case "ROWRE_ECOTRONBOX":
            case "ROWRE_DIMMER":
            case "ROWRE_WIDGET_REMOVE_DIMMER":
            case "ROWRE_CLOTHING_CHANGE":
            case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
            case "ROWRE_MANNEQUIN":
            case "ROWRE_PET_PRODUCT_MENU":
            case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
            case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
            case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
            case "ROWRE_BACKGROUND_COLOR":
            case "ROWRE_HIDE_AREA":
            case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
            case "ROWRE_EFFECTBOX_OPEN_DIALOG":
            case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
            case "ROWRE_FRIEND_FURNITURE_CONFIRM":
            case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
            case "ROWRE_BADGE_DISPLAY_ENGRAVING":
            case "ROWRE_HIGH_SCORE_DISPLAY":
            case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
            case "ROWRE_INTERNAL_LINK":
            case "ROWRE_ROOM_LINK":
               handleObjectWidgetRequestEvent(param1,param2);
               break;
            case "ROFCAE_DICE_ACTIVATE":
            case "ROFCAE_DICE_OFF":
            case "ROFCAE_USE_HABBOWHEEL":
            case "ROFCAE_STICKIE":
            case "ROFCAE_ENTER_ONEWAYDOOR":
            case "ROFCAE_NFT_REWARD_BOX":
               handleObjectActionEvent(param1,param2);
               break;
            case "ROFCAE_SOUND_MACHINE_INIT":
            case "ROFCAE_SOUND_MACHINE_START":
            case "ROFCAE_SOUND_MACHINE_STOP":
            case "ROFCAE_SOUND_MACHINE_DISPOSE":
               handleObjectSoundMachineEvent(param1,param2);
               break;
            case "ROFCAE_JUKEBOX_INIT":
            case "ROFCAE_JUKEBOX_START":
            case "ROFCAE_JUKEBOX_MACHINE_STOP":
            case "ROFCAE_JUKEBOX_DISPOSE":
               handleObjectJukeboxEvent(param1,param2);
               break;
            case "ROFHO_ADD_HOLE":
            case "ROFHO_REMOVE_HOLE":
               handleObjectFloorHoleEvent(param1,param2);
               break;
            case "RORAE_ROOM_AD_FURNI_CLICK":
            case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
            case "RORAE_ROOM_AD_TOOLTIP_SHOW":
            case "RORAE_ROOM_AD_TOOLTIP_HIDE":
            case "RORAE_ROOM_AD_LOAD_IMAGE":
               handleObjectRoomAdEvent(param1,param2);
               break;
            case "ROGBE_LOAD_BADGE":
               handleObjectGroupBadgeEvent(param1,param2);
               break;
            case "ROFCAE_MOUSE_ARROW":
            case "ROFCAE_MOUSE_BUTTON":
               handleRoomActionMouseRequestEvent(param1,param2);
               break;
            case "ROPSIE_PLAY_SOUND":
            case "ROPSIE_PLAY_SOUND_AT_PITCH":
               handleRoomObjectPlaySoundEvent(RoomObjectPlaySoundIdEvent(param1),param2);
               break;
            case "ROPSPE_ROOM_OBJECT_INITIALIZED":
            case "ROPSPE_ROOM_OBJECT_DISPOSED":
            case "ROPSPE_PLAY_SAMPLE":
               handleRoomObjectSamplePlaybackEvent(RoomObjectSamplePlaybackEvent(param1),param2);
               break;
            case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
               handleRoomObjectHSLColorEnableEvent(RoomObjectHSLColorEnableEvent(param1),param2);
               break;
            case "RODRE_CURRENT_USER_ID":
            case "RODRE_URL_PREFIX":
               handleRoomObjectDataRequestEvent(param1,param2);
               break;
            default:
               class_21.log("*** Unhandled room object event in RoomObjectEventHandler::handleRoomObjectEvent !!! ***");
         }
      }
      
      private function setMouseEventId(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:class_55 = var_1471.getValue(String(param1)) as class_55;
         if(_loc4_ == null)
         {
            _loc4_ = new class_55();
            var_1471.add(param1,_loc4_);
         }
         _loc4_.remove(param2);
         _loc4_.add(param2,param3);
      }
      
      private function getMouseEventId(param1:int, param2:String) : String
      {
         var _loc4_:class_55 = var_1471.getValue(String(param1)) as class_55;
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.getValue(param2) as String;
      }
      
      private function handleRoomObjectMouseEvent(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc4_:RoomObjectTileMouseEvent = null;
         var _loc3_:RoomAreaSelectionManager = null;
         if(param1 is RoomObjectTileMouseEvent)
         {
            _loc4_ = param1 as RoomObjectTileMouseEvent;
            _loc3_ = roomEngine.areaSelectionManager as RoomAreaSelectionManager;
            _loc3_.handleTileMouseEvent(_loc4_);
         }
         switch(param1.type)
         {
            case "ROE_MOUSE_CLICK":
               handleRoomObjectMouseClick(param1,param2);
               break;
            case "ROE_MOUSE_MOVE":
               handleRoomObjectMouseMove(param1,param2);
               break;
            case "ROE_MOUSE_DOWN":
               handleRoomObjectMouseDown(param1,param2);
               break;
            case "ROE_MOUSE_ENTER":
               handleRoomObjectMouseEnter(param1,param2);
               break;
            case "ROE_MOUSE_LEAVE":
               handleRoomObjectMouseLeave(param1,param2);
         }
      }
      
      private function clickRoomObject(param1:RoomObjectMouseEvent, param2:int) : void
      {
         if(param1 == null || param1.altKey || param1.ctrlKey || param1.shiftKey)
         {
            return;
         }
         var _loc4_:int = param1.objectId;
         var _loc5_:String = param1.objectType;
         var _loc3_:int = _roomEngine.getRoomObjectCategory(_loc5_);
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            if(_loc3_ == 10)
            {
               _roomEngine.connection.send(new ClickFurniMessageComposer(_loc4_));
            }
            else if(_loc3_ == 20)
            {
               _roomEngine.connection.send(new ClickFurniMessageComposer(-_loc4_));
            }
            else if(_loc3_ == 100)
            {
               _roomEngine.connection.send(new class_3165(_loc4_));
            }
         }
      }
      
      private function handleRoomObjectMouseClick(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc6_:String = null;
         if(param1 == null)
         {
            return;
         }
         clickRoomObject(param1,param2);
         var _loc9_:Boolean = false;
         var _loc5_:String = "OBJECT_UNDEFINED";
         var _loc8_:class_1925 = getSelectedObjectData(param2);
         if(_loc8_ != null)
         {
            _loc5_ = _loc8_.operation;
         }
         if(isWhereYouClickWhereYouGo())
         {
            if(_loc5_ == null || _loc5_ == "OBJECT_UNDEFINED")
            {
               _loc9_ = handleMoveTargetFurni(param2,param1);
            }
         }
         var _loc15_:int = param1.objectId;
         var _loc12_:String = param1.objectType;
         var _loc14_:int = _roomEngine.getRoomObjectCategory(_loc12_);
         var _loc3_:String = param1.eventId;
         var _loc13_:RoomObjectTileMouseEvent = param1 as RoomObjectTileMouseEvent;
         var _loc4_:RoomObjectWallMouseEvent = param1 as RoomObjectWallMouseEvent;
         var _loc16_:Boolean = false;
         var _loc7_:IEventDispatcher = _roomEngine.events;
         switch(_loc5_)
         {
            case "OBJECT_MOVE":
               if(_loc14_ == 0)
               {
                  if(_loc8_ != null)
                  {
                     modifyRoomObject(param2,_loc8_.id,_loc8_.category,"OBJECT_MOVE_TO");
                  }
               }
               else if(_loc14_ == 100)
               {
                  if(_loc8_ != null && _loc12_ == "monsterplant")
                  {
                     modifyRoomObject(param2,_loc8_.id,_loc8_.category,"OBJECT_MOVE_TO");
                  }
                  if(_loc3_ != null)
                  {
                     setMouseEventId(0,"click",_loc3_);
                  }
                  placeObjectOnUser(param2,_loc15_,_loc14_);
               }
               _loc16_ = true;
               if(_loc15_ != -1)
               {
                  setSelectedObject(param2,_loc15_,_loc14_);
               }
               break;
            case "OBJECT_PLACE":
               if(_loc14_ == 0)
               {
                  placeObject(param2,_loc13_ != null,_loc4_ != null);
                  break;
               }
               if(_loc14_ != 100)
               {
                  break;
               }
               switch(_loc12_)
               {
                  case "monsterplant":
                  case "rentable_bot":
                     placeObject(param2,_loc13_ != null,_loc4_ != null);
                     break;
                  default:
                     if(_loc3_ != null)
                     {
                        setMouseEventId(0,"click",_loc3_);
                     }
                     placeObjectOnUser(param2,_loc15_,_loc14_);
               }
               break;
            case "OBJECT_UNDEFINED":
               if(_loc14_ == 0)
               {
                  if(_loc13_ != null && !_loc9_)
                  {
                     handleClickOnTile(param2,_loc13_);
                  }
                  break;
               }
               if(!roomEngine.isAreaSelectionMode() || _loc14_ == 100)
               {
                  setSelectedObject(param2,_loc15_,_loc14_);
               }
               else
               {
                  deselectObject(param2);
                  if(_loc7_ != null)
                  {
                     _loc7_.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED",param2,-1,-2));
                  }
               }
               _loc10_ = false;
               if(_loc14_ == 100)
               {
                  if(!(param1.ctrlKey && !param1.altKey && !param1.shiftKey && _loc12_ == "rentable_bot"))
                  {
                     while(true)
                     {
                        if(param1.ctrlKey && !param1.altKey && !param1.shiftKey && _loc12_ == "monsterplant")
                        {
                           modifyRoomObject(param2,_loc15_,_loc14_,"OBJECT_PICKUP_PET");
                        }
                        else if(!param1.ctrlKey && !param1.altKey && param1.shiftKey && _loc12_ == "monsterplant")
                        {
                           modifyRoomObject(param2,_loc15_,_loc14_,"OBJECT_ROTATE_POSITIVE");
                        }
                        else
                        {
                           handleClickOnAvatar(_loc15_,param1);
                        }
                     }
                     addr0407:
                     if(_loc3_ != null)
                     {
                        if(_loc9_)
                        {
                           setMouseEventId(0,"click",_loc3_);
                        }
                        if(_loc10_)
                        {
                           setMouseEventId(-2,"click",_loc3_);
                        }
                     }
                     break;
                  }
                  modifyRoomObject(param2,_loc15_,_loc14_,"OBJECT_PICKUP_BOT");
                  if(!_roomEngine.getActiveRoomIsPlayingGame())
                  {
                     _loc9_ = true;
                  }
                  else
                  {
                     _loc10_ = true;
                  }
               }
               else if(_loc14_ == 10 || _loc14_ == 20)
               {
                  if((param1.altKey || param1.ctrlKey || param1.shiftKey) && !_roomEngine.isGameMode)
                  {
                     if(!param1.ctrlKey && !param1.altKey && param1.shiftKey)
                     {
                        while(true)
                        {
                           if(_loc14_ == 10)
                           {
                              if(_loc7_ != null)
                              {
                                 _loc7_.dispatchEvent(new RoomEngineObjectEvent("REOE_REQUEST_ROTATE",param2,_loc15_,_loc14_));
                              }
                           }
                        }
                     }
                     else
                     {
                        while(true)
                        {
                           if(param1.ctrlKey && !param1.altKey && !param1.shiftKey)
                           {
                              if(_loc7_ != null)
                              {
                                 _loc7_.dispatchEvent(new RoomEngineObjectEvent("REOE_REQUEST_PICKUP",param2,_loc15_,_loc14_));
                              }
                           }
                        }
                     }
                     §§goto(addr0407);
                  }
               }
               §§goto(addr0407);
         }
         if(_loc14_ == 0)
         {
            _loc11_ = getMouseEventId(-2,"click");
            _loc6_ = getMouseEventId(100,"click");
            if(_loc11_ != _loc3_ && _loc6_ != _loc3_ && !_loc16_)
            {
               deselectObject(param2);
               if(_loc7_ != null)
               {
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED",param2,-1,-2));
               }
               setSelectedAvatar(param2,0,false);
            }
         }
      }
      
      public function recalibrateMovements(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:String = null;
         var _loc4_:class_1925 = null;
         if(param2)
         {
            _loc3_ = "OBJECT_UNDEFINED";
            _loc4_ = getSelectedObjectData(param1);
            if(_loc4_ == null)
            {
               return;
            }
            _loc3_ = _loc4_.operation;
            if(_loc3_ != "OBJECT_MOVE" && _loc3_ != "OBJECT_PLACE")
            {
               return;
            }
         }
         handleRoomObjectMouseMove(_moveMouseEventCache,param1);
      }
      
      private function handleRoomObjectMouseMove(param1:RoomObjectMouseEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         _moveMouseEventCache = param1;
         var _loc3_:String = "OBJECT_UNDEFINED";
         var _loc4_:class_1925 = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.operation;
         }
         var _loc8_:String = param1.objectType;
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc8_);
         if(_roomEngine != null)
         {
            var _loc7_:IRoomObjectController = _roomEngine.getTileCursor(param2);
            if(_loc7_ != null && null.getEventHandler() != null)
            {
               if(param1 is RoomObjectTileMouseEvent)
               {
                  var _loc5_:RoomObjectTileCursorUpdateMessage = handleMouseOverTile(param1 as RoomObjectTileMouseEvent,param2);
               }
               else
               {
                  while(true)
                  {
                     if(param1.object != null && param1.object.getId() != -1)
                     {
                        if(isWhereYouClickWhereYouGo())
                        {
                           _loc5_ = handleMouseOverObject(_loc6_,param2,param1);
                        }
                     }
                     else
                     {
                        _loc5_ = new RoomObjectTileCursorUpdateMessage(null,0,false,param1.eventId);
                     }
                  }
                  switch(_loc3_)
                  {
                     case "OBJECT_MOVE":
                        if(_loc6_ == 0)
                        {
                           handleObjectMove(param1,param2);
                        }
                        break;
                     case "OBJECT_PLACE":
                        if(_loc6_ == 0)
                        {
                           handleObjectPlace(param1,param2);
                        }
                  }
                  return;
                  addr00ec:
               }
               null.getEventHandler().processUpdateMessage(null);
            }
         }
         §§goto(addr00ec);
      }
      
      private function handleMouseOverTile(param1:RoomObjectTileMouseEvent, param2:int) : RoomObjectTileCursorUpdateMessage
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:IRoomInstance = null;
         var _loc3_:class_2247 = null;
         var _loc8_:IRoomObject = null;
         var _loc4_:class_1934 = null;
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         if(isWhereYouClickWhereYouGo())
         {
            return new RoomObjectTileCursorUpdateMessage(new Vector3d(param1.tileXAsInt,param1.tileYAsInt,param1.tileZAsInt),0,true,param1.eventId);
         }
         var _loc9_:IRoomObjectController = _roomEngine.getTileCursor(param2);
         if(_loc9_ != null && _loc9_.getEventHandler() != null)
         {
            _loc5_ = param1.tileXAsInt;
            _loc6_ = param1.tileYAsInt;
            _loc7_ = param1.tileZAsInt;
            _loc11_ = _roomEngine.getRoom(param2);
            if(_loc11_ != null)
            {
               _loc3_ = _roomEngine.getTileObjectMap(param2);
               if(_loc3_)
               {
                  _loc8_ = _loc3_.getObjectIntTile(_loc5_,_loc6_);
                  _loc4_ = _roomEngine.getFurniStackingHeightMap(param2);
                  if(_loc4_)
                  {
                     if(_loc8_ && _loc8_.getModel() && _loc8_.getModel().getNumber("furniture_is_variable_height") > 0)
                     {
                        _loc12_ = _loc4_.getTileHeight(_loc5_,_loc6_);
                        _loc10_ = _roomEngine.getLegacyGeometry(param2).getTileHeight(_loc5_,_loc6_);
                        return new RoomObjectTileCursorUpdateMessage(new Vector3d(_loc5_,_loc6_,_loc7_),_loc12_ - _loc10_,true,param1.eventId);
                     }
                     return new RoomObjectTileCursorUpdateMessage(new Vector3d(_loc5_,_loc6_,_loc7_),0,true,param1.eventId);
                  }
               }
            }
         }
         return null;
      }
      
      private function handleMouseOverObject(param1:int, param2:int, param3:RoomObjectMouseEvent) : RoomObjectTileCursorUpdateMessage
      {
         var _loc9_:Number = NaN;
         if(param1 == 10)
         {
            var _loc4_:IRoomObject = _roomEngine.getRoomObject(param2,param3.objectId,10);
            if(_loc4_)
            {
               var _loc5_:Vector3d = getActiveSurfaceLocation(null,param3);
               if(_loc5_)
               {
                  var _loc6_:class_1934 = _roomEngine.getFurniStackingHeightMap(param2);
                  if(_loc6_)
                  {
                     var _loc7_:int = int(null.x);
                     var _loc8_:int = int(null.y);
                     _loc9_ = Number(null.z);
                     return new RoomObjectTileCursorUpdateMessage(new Vector3d(0,0,null.getLocation().z),_loc9_,true,param3.eventId);
                  }
               }
            }
         }
         return null;
      }
      
      private function handleRoomObjectMouseEnter(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc6_:String = param1.objectType;
         var _loc4_:int = param1.objectId;
         var _loc3_:int = _roomEngine.getRoomObjectCategory(_loc6_);
         if(_loc3_ != 0)
         {
            if(_loc3_ == 100)
            {
               handleMouseEnterAvatar(_loc4_,param1,param2);
            }
         }
         var _loc5_:IEventDispatcher = _roomEngine.events;
         if(_loc5_ != null)
         {
            _loc5_.dispatchEvent(new RoomEngineObjectEvent("REOE_MOUSE_ENTER",param2,param1.objectId,_roomEngine.getRoomObjectCategory(param1.objectType)));
         }
      }
      
      private function handleRoomObjectMouseLeave(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc7_:String = param1.objectType;
         var _loc3_:int = _roomEngine.getRoomObjectCategory(_loc7_);
         if(_loc3_ != 0)
         {
            if(_loc3_ == 100)
            {
               var _loc4_:IRoomObjectController = _roomEngine.getTileCursor(param2);
               if(_loc4_)
               {
                  var _loc5_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(0,null);
                  null.getEventHandler().processUpdateMessage(null);
               }
            }
         }
         var _loc6_:IEventDispatcher = _roomEngine.events;
         if(_loc6_ != null)
         {
            _loc6_.dispatchEvent(new RoomEngineObjectEvent("REOE_MOUSE_LEAVE",param2,param1.objectId,_roomEngine.getRoomObjectCategory(param1.objectType)));
         }
      }
      
      private function handleRoomObjectMouseDown(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc7_:IEventDispatcher = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is RoomObjectTileMouseEvent)
         {
            return;
         }
         var _loc3_:String = "OBJECT_UNDEFINED";
         var _loc4_:class_1925 = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.operation;
         }
         var _loc6_:int = param1.objectId;
         var _loc8_:String = param1.objectType;
         var _loc5_:int = _roomEngine.getRoomObjectCategory(_loc8_);
         var _loc9_:String = _loc3_;
         if("OBJECT_UNDEFINED" === _loc9_)
         {
            if(_loc5_ == 10 || _loc5_ == 20 || _loc8_ == "monsterplant")
            {
               if((param1.altKey && !param1.ctrlKey && !param1.shiftKey || decorateModeMove(param1)) && !_roomEngine.isGameMode)
               {
                  _loc7_ = _roomEngine.events;
                  if(_loc7_ != null)
                  {
                     _loc7_.dispatchEvent(new RoomEngineObjectEvent("REOE_REQUEST_MOVE",param2,_loc6_,_loc5_));
                  }
               }
            }
         }
      }
      
      private function decorateModeMove(param1:RoomObjectMouseEvent) : Boolean
      {
         return _roomEngine.isDecorateMode && !(param1.ctrlKey || param1.shiftKey);
      }
      
      private function handleObjectMove(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc14_:Boolean = false;
         var _loc9_:class_1934 = null;
         var _loc10_:RoomObjectTileMouseEvent = null;
         var _loc3_:RoomObjectWallMouseEvent = null;
         var _loc12_:IVector3d = null;
         var _loc8_:IVector3d = null;
         var _loc6_:IVector3d = null;
         var _loc11_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc15_:IEventDispatcher = _roomEngine.events;
         if(_loc15_ == null)
         {
            return;
         }
         var _loc4_:class_1925 = getSelectedObjectData(param2);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IRoomObjectController = _roomEngine.getRoomObject(param2,_loc4_.id,_loc4_.category) as IRoomObjectController;
         if(_loc5_ != null)
         {
            _loc14_ = true;
            if(_loc4_.category == 10 || _loc4_.category == 100)
            {
               _loc9_ = _roomEngine.getFurniStackingHeightMap(param2);
               _loc10_ = param1 as RoomObjectTileMouseEvent;
               if(!(_loc10_ != null && handleFurnitureMove(_loc5_,_loc4_,_loc10_.tileX + 0.5,_loc10_.tileY + 0.5,_loc9_)))
               {
                  handleFurnitureMove(_loc5_,_loc4_,_loc4_.loc.x,_loc4_.loc.y,_loc9_);
                  _loc14_ = false;
               }
            }
            else if(_loc4_.category == 20)
            {
               _loc14_ = false;
               _loc3_ = param1 as RoomObjectWallMouseEvent;
               if(_loc3_ != null)
               {
                  _loc12_ = _loc3_.wallLocation;
                  _loc8_ = _loc3_.wallWidth;
                  _loc6_ = _loc3_.wallHeight;
                  _loc11_ = _loc3_.x;
                  _loc13_ = _loc3_.y;
                  _loc7_ = _loc3_.direction;
                  if(handleWallItemMove(_loc5_,_loc4_,_loc12_,_loc8_,_loc6_,_loc11_,_loc13_,_loc7_))
                  {
                     _loc14_ = true;
                  }
               }
               if(!_loc14_)
               {
                  _loc5_.setLocation(_loc4_.loc);
                  _loc5_.setDirection(_loc4_.dir);
               }
               _roomEngine.updateObjectRoomWindow(param2,_loc4_.id,_loc14_);
            }
            if(_loc14_)
            {
               setObjectAlphaMultiplier(_loc5_,0.5);
               _roomEngine.setObjectMoverIconSpriteVisible(false);
            }
            else
            {
               setObjectAlphaMultiplier(_loc5_,0);
               _roomEngine.setObjectMoverIconSpriteVisible(true);
            }
         }
      }
      
      private function handleObjectPlace(param1:RoomObjectMouseEvent, param2:int) : void
      {
         var _loc13_:IRoomObject = null;
         var _loc4_:IRoomObjectModelController = null;
         var _loc12_:Array = null;
         var _loc5_:IVector3d = null;
         var _loc7_:Boolean = false;
         var _loc15_:class_1934 = null;
         var _loc17_:IVector3d = null;
         var _loc11_:IVector3d = null;
         var _loc9_:IVector3d = null;
         var _loc16_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc19_:IEventDispatcher = _roomEngine.events;
         if(_loc19_ == null)
         {
            return;
         }
         var _loc6_:class_1925 = getSelectedObjectData(param2);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc8_:IRoomObjectController = _roomEngine.getRoomObject(param2,_loc6_.id,_loc6_.category) as IRoomObjectController;
         var _loc14_:RoomObjectTileMouseEvent = param1 as RoomObjectTileMouseEvent;
         var _loc3_:RoomObjectWallMouseEvent = param1 as RoomObjectWallMouseEvent;
         if(_loc8_ == null)
         {
            if(_loc6_.category == 10 && _loc14_ != null)
            {
               _roomEngine.addObjectFurniture(param2,_loc6_.id,_loc6_.typeId,_loc6_.loc,_loc6_.dir,0,_loc6_.stuffData,Number(_loc6_.instanceData),-1,0,0,"",false);
            }
            else if(_loc6_.category == 20 && _loc3_ != null)
            {
               _roomEngine.addObjectWallItem(param2,_loc6_.id,_loc6_.typeId,_loc6_.loc,_loc6_.dir,0,_loc6_.instanceData,0);
            }
            else if(_loc6_.category == 100 && _loc14_ != null)
            {
               _roomEngine.addObjectUser(param2,_loc6_.id,new Vector3d(),new Vector3d(180),180,_loc6_.typeId,_loc6_.instanceData);
               _loc13_ = _roomEngine.getRoomObject(param2,_loc6_.id,_loc6_.category);
               if(_loc13_)
               {
                  _loc4_ = _loc13_.getModel() as IRoomObjectModelController;
                  if(_loc4_ != null && _loc6_.posture != null)
                  {
                     _loc4_.setString("figure_posture",_loc6_.posture);
                  }
               }
            }
            _loc8_ = _roomEngine.getRoomObject(param2,_loc6_.id,_loc6_.category) as IRoomObjectController;
            if(_loc8_ != null)
            {
               if(_loc6_.category == 10)
               {
                  if(_loc8_.getModel() != null)
                  {
                     _loc12_ = _loc8_.getModel().getNumberArray("furniture_allowed_directions");
                     if(_loc12_ != null && _loc12_.length > 0)
                     {
                        _loc5_ = new Vector3d(_loc12_[0]);
                        _loc8_.setDirection(_loc5_);
                        updateSelectedObjectData(param2,_loc6_.id,_loc6_.category,_loc6_.loc,_loc5_,_loc6_.operation,_loc6_.typeId,_loc6_.instanceData,_loc6_.stuffData,_loc6_.state,_loc6_.animFrame,_loc6_.posture);
                        _loc6_ = getSelectedObjectData(param2);
                        if(_loc6_ == null)
                        {
                           return;
                        }
                     }
                  }
               }
            }
            setObjectAlphaMultiplier(_loc8_,0.5);
            _roomEngine.setObjectMoverIconSpriteVisible(true);
         }
         if(_loc8_ != null)
         {
            _loc7_ = true;
            _loc15_ = _roomEngine.getFurniStackingHeightMap(param2);
            if(_loc6_.category == 10)
            {
               if(!(_loc14_ != null && handleFurnitureMove(_loc8_,_loc6_,_loc14_.tileX + 0.5,_loc14_.tileY + 0.5,_loc15_)))
               {
                  _roomEngine.disposeObjectFurniture(param2,_loc6_.id);
                  _loc7_ = false;
               }
            }
            else if(_loc6_.category == 20)
            {
               _loc7_ = false;
               if(_loc3_ != null)
               {
                  _loc17_ = _loc3_.wallLocation;
                  _loc11_ = _loc3_.wallWidth;
                  _loc9_ = _loc3_.wallHeight;
                  _loc16_ = _loc3_.x;
                  _loc18_ = _loc3_.y;
                  _loc10_ = _loc3_.direction;
                  if(handleWallItemMove(_loc8_,_loc6_,_loc17_,_loc11_,_loc9_,_loc16_,_loc18_,_loc10_))
                  {
                     _loc7_ = true;
                  }
               }
               if(!_loc7_)
               {
                  _roomEngine.disposeObjectWallItem(param2,_loc6_.id);
               }
               _roomEngine.updateObjectRoomWindow(param2,_loc6_.id,_loc7_);
            }
            else if(_loc6_.category == 100)
            {
               if(!(_loc14_ != null && handleUserPlace(_loc8_,_loc14_.tileX + 0.5,_loc14_.tileY + 0.5,_roomEngine.getLegacyGeometry(param2))))
               {
                  _roomEngine.disposeObjectUser(param2,_loc6_.id);
                  _loc7_ = false;
               }
            }
            _roomEngine.setObjectMoverIconSpriteVisible(!_loc7_);
         }
      }
      
      private function handleMoveTargetFurni(param1:int, param2:RoomObjectEvent) : Boolean
      {
         var _loc4_:IRoomObject = _roomEngine.getRoomObject(param1,param2.objectId,10);
         var _loc3_:Vector3d = getActiveSurfaceLocation(_loc4_,param2 as RoomObjectMouseEvent);
         if(_loc3_ && !roomEngine.isMoveBlocked())
         {
            walkTo(_loc3_.x,_loc3_.y);
            return true;
         }
         return false;
      }
      
      private function getActiveSurfaceLocation(param1:IRoomObject, param2:RoomObjectMouseEvent) : Vector3d
      {
         var _loc20_:IRoomObjectModel = null;
         var _loc15_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:int = 0;
         var _loc11_:Number = NaN;
         var _loc9_:int = 0;
         var _loc16_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:Boolean = false;
         var _loc19_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc21_:Boolean = false;
         var _loc22_:Number = NaN;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc18_:class_1800 = _roomEngine.sessionDataManager.getFloorItemDataByName(param1.getType());
         if(_loc18_ == null)
         {
            return null;
         }
         if(_loc18_.canStandOn || _loc18_.canSitOn || _loc18_.canLayOn)
         {
            _loc20_ = param1.getModel();
            if(_loc20_ == null)
            {
               return null;
            }
            _loc15_ = param1.getLocation().x;
            _loc13_ = param1.getLocation().y;
            _loc14_ = _loc20_.getNumber("furniture_size_x");
            _loc12_ = _loc20_.getNumber("furniture_size_y");
            _loc11_ = _loc20_.getNumber("furniture_size_z");
            _loc9_ = param1.getDirection().x;
            if(_loc9_ == 90 || _loc9_ == 270)
            {
               _loc16_ = _loc14_;
               _loc14_ = _loc12_;
               _loc12_ = _loc16_;
            }
            if(_loc14_ < 1)
            {
               _loc14_ = 1;
            }
            if(_loc12_ < 1)
            {
               _loc12_ = 1;
            }
            if(_roomEngine.getActiveRoomActiveCanvas() == null)
            {
               return null;
            }
            _loc5_ = _roomEngine.getActiveRoomActiveCanvas().geometry.scale;
            _loc17_ = _loc18_.canSitOn;
            _loc19_ = _loc17_ ? 0.5 : 0;
            _loc6_ = (_loc5_ / 2 + param2.spriteOffsetX + param2.localX) / (_loc5_ / 4);
            _loc7_ = (param2.spriteOffsetY + param2.localY + (_loc11_ - _loc19_) * _loc5_ / 2) / (_loc5_ / 4);
            _loc3_ = (_loc6_ + 2 * _loc7_) / 4;
            _loc10_ = (_loc6_ - 2 * _loc7_) / 4;
            _loc8_ = Math.floor(_loc15_ + _loc3_);
            _loc4_ = Math.floor(_loc13_ - _loc10_ + 1);
            _loc21_ = false;
            if(_loc8_ < _loc15_ || _loc8_ >= _loc15_ + _loc14_)
            {
               _loc21_ = true;
            }
            else if(_loc4_ < _loc13_ || _loc4_ >= _loc13_ + _loc12_)
            {
               _loc21_ = true;
            }
            _loc22_ = _loc17_ ? _loc11_ - 0.5 : _loc11_;
            if(!_loc21_)
            {
               return new Vector3d(_loc8_,_loc4_,_loc22_);
            }
         }
         return null;
      }
      
      protected function handleObjectStateChange(param1:RoomObjectStateChangeEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         changeObjectState(param2,param1.objectId,param1.objectType,param1.param,false);
      }
      
      private function handleObjectRandomStateChange(param1:RoomObjectStateChangeEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         changeObjectState(param2,param1.objectId,param1.objectType,param1.param,true);
      }
      
      private function handleObjectWidgetRequestEvent(param1:RoomObjectEvent, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         if(_roomEngine == null || param1 == null)
         {
            return;
         }
         var _loc7_:int = param1.objectId;
         var _loc9_:String = param1.objectType;
         var _loc5_:int = _roomEngine.getRoomObjectCategory(_loc9_);
         var _loc8_:IEventDispatcher = _roomEngine.events;
         if(_loc8_ != null)
         {
            switch(param1.type)
            {
               case "ROWRE_OPEN_WIDGET":
                  _loc3_ = IRoomObjectController(param1.object).getEventHandler().widget;
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_OPEN_WIDGET",param2,_loc7_,_loc5_,_loc3_));
                  break;
               case "ROWRE_CLOSE_WIDGET":
                  _loc3_ = IRoomObjectController(param1.object).getEventHandler().widget;
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_CLOSE_WIDGET",param2,_loc7_,_loc5_,_loc3_));
                  break;
               case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
                  _loc4_ = IRoomObjectController(param1.object).getEventHandler().contextMenu;
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_OPEN_FURNI_CONTEXT_MENU",param2,_loc7_,_loc5_,_loc4_));
                  break;
               case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_CLOSE_FURNI_CONTEXT_MENU",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PLACEHOLDER":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PLACEHOLDER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE__CREDITFURNI":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_CREDITFURNI",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE__STICKIE":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_STICKIE",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PRESENT":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PRESENT",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_TROPHY":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_TROPHY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_TEASER":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_TEASER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ECOTRONBOX":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ECOTRONBOX",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_DIMMER":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_DIMMER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_WIDGET_REMOVE_DIMMER":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REMOVE_DIMMER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_CLOTHING_CHANGE":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_CLOTHING_CHANGE",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PLAYLIST_EDITOR",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MANNEQUIN":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MANNEQUIN",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PET_PRODUCT_MENU":
                  _loc8_.dispatchEvent(new RoomEngineUseProductEvent("ROSM_USE_PRODUCT_FROM_ROOM",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
                  _loc6_ = param1.object.getModel().getNumber("furniture_guild_customized_guild_id");
                  _roomEngine.connection.send(new class_3454(param1.objectId,_loc6_));
                  break;
               case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_BACKGROUND_COLOR":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_BACKGROUND_COLOR",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_HIDE_AREA":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_AREA_HIDE",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_EFFECTBOX_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
                  _roomEngine.connection.send(new class_3070(param1.objectId,0));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_FRIEND_FURNITURE_CONFIRM":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_FRIEND_FURNITURE_CONFIRM",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_BADGE_DISPLAY_ENGRAVING":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_HIGH_SCORE_DISPLAY":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_HIGH_SCORE_DISPLAY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_INTERNAL_LINK":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_INTERNAL_LINK",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ROOM_LINK":
                  _loc8_.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ROOM_LINK",param2,_loc7_,_loc5_));
            }
         }
      }
      
      private function handleObjectRoomAdEvent(param1:RoomObjectEvent, param2:int) : void
      {
         var _loc7_:String = null;
         if(_roomEngine == null || _roomEngine.events == null || param1 == null)
         {
            return;
         }
         var _loc9_:int = param1.objectId;
         var _loc10_:String = param1.objectType;
         var _loc8_:int = _roomEngine.getRoomObjectCategory(_loc10_);
         var _loc5_:RoomObjectRoomAdEvent = param1 as RoomObjectRoomAdEvent;
         switch(param1.type)
         {
            case "RORAE_ROOM_AD_FURNI_CLICK":
               _roomEngine.events.dispatchEvent(param1);
               if(_loc5_ != null && _roomEngine.toolbar != null)
               {
                  if(_loc5_.clickUrl == "NAVIGATOR_GAMES")
                  {
                     _roomEngine.toolbar.toggleWindowVisibility("GAMES");
                  }
                  else if(_loc5_.clickUrl != "")
                  {
                     (_roomEngine as class_17).context.createLinkEvent(_loc5_.clickUrl);
                  }
               }
               _loc7_ = "RERAE_FURNI_CLICK";
               break;
            case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
               if(_loc5_ != null && _roomEngine.catalog != null)
               {
                  var _loc3_:String = _loc5_.clickUrl;
                  var _loc6_:String = "CATALOG_PAGE:";
               }
               _loc7_ = "RERAE_FURNI_DOUBLE_CLICK";
               break;
            case "RORAE_ROOM_AD_TOOLTIP_SHOW":
               _loc7_ = "RERAE_TOOLTIP_SHOW";
               break;
            case "RORAE_ROOM_AD_TOOLTIP_HIDE":
               _loc7_ = "RERAE_TOOLTIP_HIDE";
               break;
            case "RORAE_ROOM_AD_LOAD_IMAGE":
               if(_loc5_ != null)
               {
                  _roomEngine.requestRoomAdImage(param2,_loc9_,_loc8_,_loc5_.imageUrl,_loc5_.clickUrl);
               }
         }
         if(_loc7_ == null)
         {
            return;
         }
         _roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(_loc7_,param2,_loc9_,_loc8_));
      }
      
      private function handleObjectActionEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         useObject(param2,param1.objectId,param1.objectType,param1.type);
      }
      
      private function handleObjectSoundMachineEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.getRoomObjectCategory(param1.objectType);
         var _loc4_:class_1925 = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            if(_loc4_.category == _loc3_ && _loc4_.id == param1.objectId)
            {
               if(_loc4_.operation == "OBJECT_PLACE")
               {
                  return;
               }
            }
         }
         switch(param1.type)
         {
            case "ROFCAE_SOUND_MACHINE_INIT":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_INIT",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_START":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_SWITCHED_ON",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_STOP":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_SWITCHED_OFF",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_DISPOSE":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_DISPOSE",param2,param1.objectId,_loc3_));
         }
      }
      
      private function handleObjectJukeboxEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.getRoomObjectCategory(param1.objectType);
         var _loc4_:class_1925 = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            if(_loc4_.category == _loc3_ && _loc4_.id == param1.objectId)
            {
               if(_loc4_.operation == "OBJECT_PLACE")
               {
                  return;
               }
            }
         }
         switch(param1.type)
         {
            case "ROFCAE_JUKEBOX_INIT":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_INIT",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_START":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_SWITCHED_ON",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_MACHINE_STOP":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_SWITCHED_OFF",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_DISPOSE":
               _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_DISPOSE",param2,param1.objectId,_loc3_));
         }
      }
      
      private function handleObjectGroupBadgeEvent(param1:RoomObjectEvent, param2:int) : void
      {
         var _loc3_:RoomObjectBadgeAssetEvent = null;
         if(_roomEngine == null || _roomEngine.events == null || param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.objectId;
         var _loc6_:String = param1.objectType;
         var _loc4_:int = _roomEngine.getRoomObjectCategory(_loc6_);
         if(param1.type == "ROGBE_LOAD_BADGE")
         {
            _loc3_ = param1 as RoomObjectBadgeAssetEvent;
            if(_loc3_ != null)
            {
               _roomEngine.requestBadgeImageAsset(param2,_loc5_,_loc4_,_loc3_.badgeId,_loc3_.groupBadge);
            }
         }
      }
      
      private function handleObjectFloorHoleEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "ROFHO_ADD_HOLE":
               _roomEngine.addFloorHole(param2,param1.objectId);
               break;
            case "ROFHO_REMOVE_HOLE":
               _roomEngine.removeFloorHole(param2,param1.objectId);
         }
      }
      
      private function handleRoomActionMouseRequestEvent(param1:RoomObjectEvent, param2:int) : void
      {
         _roomEngine.requestMouseCursor(param1.type,param1.objectId,param1.objectType);
      }
      
      private function handleObjectDimmerStateEvent(param1:RoomObjectEvent, param2:int) : void
      {
         var _loc4_:RoomObjectDimmerStateUpdateEvent = null;
         var _loc3_:RoomEngineDimmerStateEvent = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.objectId;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            var _loc6_:* = param1.type;
            if("RODSUE_DIMMER_STATE" === _loc6_)
            {
               _loc4_ = param1 as RoomObjectDimmerStateUpdateEvent;
               if(_loc4_ != null)
               {
                  _loc3_ = new RoomEngineDimmerStateEvent(param2,_loc5_,_loc4_.state,_loc4_.presetId,_loc4_.effectId,_loc4_.color,_loc4_.brightness);
                  _roomEngine.events.dispatchEvent(_loc3_);
               }
            }
         }
      }
      
      private function handleRoomObjectPlaySoundEvent(param1:RoomObjectPlaySoundIdEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.getRoomObjectCategory(param1.objectType);
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(param1.type)
            {
               case "ROPSIE_PLAY_SOUND":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectPlaySoundEvent("REPSE_PLAY_SOUND",param2,param1.objectId,_loc3_,param1.soundId,param1.pitch));
                  break;
               case "ROPSIE_PLAY_SOUND_AT_PITCH":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectPlaySoundEvent("REPSE_PLAY_SOUND_AT_PITCH",param2,param1.objectId,_loc3_,param1.soundId,param1.pitch));
            }
         }
      }
      
      private function handleRoomObjectSamplePlaybackEvent(param1:RoomObjectSamplePlaybackEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.getRoomObjectCategory(param1.objectType);
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(param1.type)
            {
               case "ROPSPE_ROOM_OBJECT_INITIALIZED":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_ROOM_OBJECT_INITIALIZED",param2,param1.objectId,_loc3_,param1.sampleId,param1.pitch));
                  break;
               case "ROPSPE_ROOM_OBJECT_DISPOSED":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_ROOM_OBJECT_DISPOSED",param2,param1.objectId,_loc3_,param1.sampleId,param1.pitch));
                  break;
               case "ROPSPE_PLAY_SAMPLE":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_PLAY_SAMPLE",param2,param1.objectId,_loc3_,param1.sampleId,param1.pitch));
                  break;
               case "ROPSPE_CHANGE_PITCH":
                  _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_CHANGE_PITCH",param2,param1.objectId,_loc3_,param1.sampleId,param1.pitch));
            }
         }
      }
      
      private function handleRoomObjectHSLColorEnableEvent(param1:RoomObjectHSLColorEnableEvent, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            var _loc3_:* = param1.type;
            if("ROHSLCEE_ROOM_BACKGROUND_COLOR" === _loc3_)
            {
               _roomEngine.events.dispatchEvent(new RoomEngineHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR",param2,param1.enable,param1.hue,param1.saturation,param1.lightness));
            }
         }
      }
      
      private function handleRoomObjectDataRequestEvent(param1:RoomObjectEvent, param2:int) : void
      {
         if(_roomEngine == null || param1 == null || param1.object == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModelController = param1.object.getModel() as IRoomObjectModelController;
         switch(param1.type)
         {
            case "RODRE_CURRENT_USER_ID":
               _loc3_.setNumber("session_current_user_id",_roomEngine.sessionDataManager.userId);
               break;
            case "RODRE_URL_PREFIX":
               _loc3_.setString("session_url_prefix",_roomEngine.configuration.getProperty("url.prefix"));
         }
      }
      
      private function handleSelectedObjectMove(param1:RoomObjectEvent, param2:int) : void
      {
         var _loc3_:IVector3d = null;
         var _loc8_:RoomObjectUpdateMessage = null;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc7_:int = param1.objectId;
         var _loc9_:String = param1.objectType;
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc9_);
         var _loc4_:IRoomObjectController = _roomEngine.getRoomObject(param2,_loc7_,_loc6_) as IRoomObjectController;
         var _loc5_:IRoomObjectController = _roomEngine.getSelectionArrow(param2);
         if(_loc4_ != null && _loc5_ != null && _loc5_.getEventHandler() != null)
         {
            _loc3_ = _loc4_.getLocation();
            _loc8_ = new RoomObjectUpdateMessage(_loc3_,null);
            _loc5_.getEventHandler().processUpdateMessage(_loc8_);
         }
      }
      
      private function handleSelectedObjectRemove(param1:RoomObjectEvent, param2:int) : void
      {
         setSelectedAvatar(param2,0,false);
      }
      
      private function handleObjectSlide(param1:RoomObjectEvent, param2:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.getRoomObjectCategory(param1.objectType);
         if(_loc3_ == 20)
         {
            _roomEngine.updateObjectRoomWindow(param2,param1.objectId);
         }
      }
      
      private function handleFurnitureMove(param1:IRoomObjectController, param2:class_1925, param3:int, param4:int, param5:class_1934) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc6_:Vector3d = new Vector3d();
         _loc6_.assign(param1.getDirection());
         param1.setDirection(param2.dir);
         var _loc8_:Vector3d = new Vector3d(param3,param4,0);
         var _loc7_:Vector3d = new Vector3d();
         _loc7_.assign(param1.getDirection());
         var _loc9_:Vector3d = validateFurnitureLocation(param1,_loc8_,param2.loc,param2.dir,param5);
         if(_loc9_ == null)
         {
            _loc7_.x = getValidRoomObjectDirection(param1,true);
            param1.setDirection(_loc7_);
            _loc9_ = validateFurnitureLocation(param1,_loc8_,param2.loc,param2.dir,param5);
         }
         if(_loc9_ == null)
         {
            param1.setDirection(_loc6_);
            return false;
         }
         param1.setLocation(_loc9_);
         if(_loc7_)
         {
            param1.setDirection(_loc7_);
         }
         return true;
      }
      
      private function handleWallItemMove(param1:IRoomObjectController, param2:class_1925, param3:IVector3d, param4:IVector3d, param5:IVector3d, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc9_:Vector3d = new Vector3d(param8);
         var _loc10_:Vector3d = validateWallItemLocation(param1,param3,param4,param5,param6,param7,param2);
         if(_loc10_ == null)
         {
            return false;
         }
         param1.setLocation(_loc10_);
         param1.setDirection(_loc9_);
         return true;
      }
      
      private function handleUserPlace(param1:IRoomObjectController, param2:int, param3:int, param4:class_1821) : Boolean
      {
         if(!param4.isRoomTile(param2,param3))
         {
            return false;
         }
         param1.setLocation(new Vector3d(param2,param3,param4.getTileHeight(param2,param3)));
         return true;
      }
      
      private function validateFurnitureDirection(param1:IRoomObject, param2:IVector3d, param3:class_1934) : Boolean
      {
         var _loc11_:* = false;
         if(param1 == null || param1.getModel() == null || param2 == null)
         {
            return false;
         }
         var _loc7_:IVector3d = param1.getDirection();
         var _loc4_:IVector3d = param1.getLocation();
         if(_loc7_ == null || _loc4_ == null)
         {
            return false;
         }
         if(_loc7_.x % 180 == param2.x % 180)
         {
            return true;
         }
         var _loc10_:int = param1.getModel().getNumber("furniture_size_x");
         var _loc8_:int = param1.getModel().getNumber("furniture_size_y");
         if(_loc10_ < 1)
         {
            _loc10_ = 1;
         }
         if(_loc8_ < 1)
         {
            _loc8_ = 1;
         }
         var _loc12_:int = _loc10_;
         var _loc9_:int = _loc8_;
         var _loc5_:int = 0;
         var _loc6_:int = (int(param2.x + 45)) % 360 / 90;
         if(_loc6_ == 1 || _loc6_ == 3)
         {
            _loc5_ = _loc10_;
            _loc10_ = _loc8_;
            _loc8_ = _loc5_;
         }
         _loc6_ = (int(_loc7_.x + 45)) % 360 / 90;
         if(_loc6_ == 1 || _loc6_ == 3)
         {
            _loc5_ = _loc12_;
            _loc12_ = _loc9_;
            _loc9_ = _loc5_;
         }
         if(param3 != null && _loc4_ != null)
         {
            _loc11_ = param1.getModel().getNumber("furniture_always_stackable") == 1;
            if(param3.validateLocation(_loc4_.x,_loc4_.y,_loc10_,_loc8_,_loc4_.x,_loc4_.y,_loc12_,_loc9_,_loc11_,_loc4_.z))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function validateFurnitureLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:class_1934) : Vector3d
      {
         var _loc16_:Vector3d = null;
         var _loc12_:* = false;
         if(param1 == null || param1.getModel() == null || param2 == null)
         {
            return null;
         }
         var _loc8_:IVector3d = param1.getDirection();
         if(_loc8_ == null)
         {
            return null;
         }
         if(param3 == null || param4 == null)
         {
            return null;
         }
         if(param2.x == param3.x && param2.y == param3.y)
         {
            if(_loc8_.x == param4.x)
            {
               _loc16_ = new Vector3d();
               _loc16_.assign(param3);
               return _loc16_;
            }
         }
         var _loc11_:int = param1.getModel().getNumber("furniture_size_x");
         var _loc9_:int = param1.getModel().getNumber("furniture_size_y");
         if(_loc11_ < 1)
         {
            _loc11_ = 1;
         }
         if(_loc9_ < 1)
         {
            _loc9_ = 1;
         }
         var _loc6_:int = param3.x;
         var _loc7_:int = param3.y;
         var _loc13_:int = _loc11_;
         var _loc10_:int = _loc9_;
         var _loc14_:int = 0;
         var _loc15_:int = (int(_loc8_.x + 45)) % 360 / 90;
         if(_loc15_ == 1 || _loc15_ == 3)
         {
            _loc14_ = _loc11_;
            _loc11_ = _loc9_;
            _loc9_ = _loc14_;
         }
         _loc15_ = (int(param4.x + 45)) % 360 / 90;
         if(_loc15_ == 1 || _loc15_ == 3)
         {
            _loc14_ = _loc13_;
            _loc13_ = _loc10_;
            _loc10_ = _loc14_;
         }
         if(param5 != null && param2 != null)
         {
            _loc12_ = param1.getModel().getNumber("furniture_always_stackable") == 1;
            if(param5.validateLocation(param2.x,param2.y,_loc11_,_loc9_,_loc6_,_loc7_,_loc13_,_loc10_,_loc12_))
            {
               return new Vector3d(param2.x,param2.y,param5.getTileHeight(param2.x,param2.y));
            }
            return null;
         }
         return null;
      }
      
      private function validateWallItemLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Number, param6:Number, param7:class_1925) : Vector3d
      {
         if(param1 == null || param1.getModel() == null || param2 == null || param3 == null || param4 == null || param7 == null)
         {
            return null;
         }
         var _loc11_:Number = param1.getModel().getNumber("furniture_size_x");
         var _loc10_:Number = param1.getModel().getNumber("furniture_size_z");
         var _loc8_:Number = param1.getModel().getNumber("furniture_center_z");
         if(param5 < _loc11_ / 2 || param5 > param3.length - _loc11_ / 2 || param6 < _loc8_ || param6 > param4.length - (_loc10_ - _loc8_))
         {
            if(param5 < _loc11_ / 2 && param5 <= param3.length - _loc11_ / 2)
            {
               param5 = _loc11_ / 2;
            }
            else if(param5 >= _loc11_ / 2 && param5 > param3.length - _loc11_ / 2)
            {
               param5 = param3.length - _loc11_ / 2;
            }
            if(param6 < _loc8_ && param6 <= param4.length - (_loc10_ - _loc8_))
            {
               param6 = _loc8_;
            }
            else if(param6 >= _loc8_ && param6 > param4.length - (_loc10_ - _loc8_))
            {
               param6 = param4.length - (_loc10_ - _loc8_);
            }
         }
         if(param5 < _loc11_ / 2 || param5 > param3.length - _loc11_ / 2 || param6 < _loc8_ || param6 > param4.length - (_loc10_ - _loc8_))
         {
            return null;
         }
         var _loc9_:Vector3d = Vector3d.sum(Vector3d.product(param3,param5 / param3.length),Vector3d.product(param4,param6 / param4.length));
         return Vector3d.sum(param2,_loc9_);
      }
      
      private function setObjectAlphaMultiplier(param1:IRoomObjectController, param2:Number) : void
      {
         if(param1 != null && param1.getModelController() != null)
         {
            param1.getModelController().setNumber("furniture_alpha_multiplier",param2);
         }
      }
      
      public function setSelectedAvatar(param1:int, param2:int, param3:Boolean) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc7_:IRoomObjectController = _roomEngine.getRoomObject(param1,var_2203,100) as IRoomObjectController;
         if(_loc7_ != null && _loc7_.getEventHandler() != null)
         {
            _loc7_.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(false));
            var_2203 = -1;
         }
         var _loc4_:Boolean = false;
         if(param3)
         {
            _loc7_ = _roomEngine.getRoomObject(param1,param2,100) as IRoomObjectController;
            if(_loc7_ != null && _loc7_.getEventHandler() != null)
            {
               _loc7_.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(true));
               _loc4_ = true;
               var_2203 = param2;
               if(!_roomEngine.roomEvents.hasClickUserWired())
               {
                  try
                  {
                     _roomEngine.connection.send(new class_3037(_loc7_.getLocation().x,_loc7_.getLocation().y));
                  }
                  catch(e:Error)
                  {
                  }
               }
            }
         }
         var _loc5_:IRoomObjectController = _roomEngine.getSelectionArrow(param1);
         if(_loc5_ != null && _loc5_.getEventHandler() != null)
         {
            if(_loc4_ && !_roomEngine.getActiveRoomIsPlayingGame())
            {
               _loc5_.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage("ROVUM_ENABLED"));
            }
            else
            {
               _loc5_.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage("ROVUM_DISABLED"));
            }
         }
      }
      
      public function getSelectedAvatarId() : int
      {
         return var_2203;
      }
      
      private function getValidRoomObjectDirection(param1:IRoomObjectController, param2:Boolean) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null || param1.getModel() == null)
         {
            return 0;
         }
         var _loc3_:Array = null;
         var _loc6_:String = param1.getType();
         if(param1.getModel() != null)
         {
            if(_loc6_ == "monsterplant")
            {
               _loc3_ = param1.getModel().getNumberArray("pet_allowed_directions");
            }
            else
            {
               _loc3_ = param1.getModel().getNumberArray("furniture_allowed_directions");
            }
         }
         var _loc7_:int = int(param1.getDirection().x);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc4_ = int(_loc3_.indexOf(_loc7_));
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc7_ <= _loc3_[_loc5_])
                  {
                     break;
                  }
                  _loc4_++;
                  _loc5_++;
               }
               _loc4_ %= _loc3_.length;
            }
            if(param2)
            {
               _loc4_ = (_loc4_ + 1) % _loc3_.length;
            }
            else
            {
               _loc4_ = (_loc4_ - 1 + _loc3_.length) % _loc3_.length;
            }
            _loc7_ = int(_loc3_[_loc4_]);
         }
         return _loc7_;
      }
      
      public function modifyRoomObjectData(param1:int, param2:int, param3:int, param4:String, param5:class_55) : Boolean
      {
         if(_roomEngine == null)
         {
            return false;
         }
         var _loc6_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,param3) as IRoomObjectController;
         if(_loc6_ == null)
         {
            return false;
         }
         var _loc7_:String = param4;
         if("OBJECT_SAVE_STUFF_DATA" !== _loc7_)
         {
            class_21.log("could not modify room object data, unknown operation " + param4);
         }
         else if(_roomEngine.connection)
         {
            _roomEngine.connection.send(new class_3044(param2,param5));
         }
         return true;
      }
      
      public function modifyRoomObject(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         if(_roomEngine == null)
         {
            return false;
         }
         var _loc13_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,param3) as IRoomObjectController;
         if(_loc13_ == null)
         {
            return false;
         }
         var _loc15_:IRoomSession = _roomEngine.roomSessionManager.getSession(param1);
         if(_loc15_ != null && _loc15_.playTestMode)
         {
            return false;
         }
         switch(param4)
         {
            case "OBJECT_ROTATE_POSITIVE":
            case "OBJECT_ROTATE_NEGATIVE":
               if(_roomEngine.connection)
               {
                  if(param4 == "OBJECT_ROTATE_NEGATIVE")
                  {
                     var _loc14_:int = getValidRoomObjectDirection(_loc13_,false);
                  }
                  else
                  {
                     _loc14_ = getValidRoomObjectDirection(_loc13_,true);
                  }
                  var _loc8_:int = int(_loc13_.getLocation().x);
                  var _loc10_:int = int(_loc13_.getLocation().y);
                  if(validateFurnitureDirection(_loc13_,new Vector3d(0),_roomEngine.getFurniStackingHeightMap(param1)))
                  {
                     _loc14_ = 0 / 45;
                     if(_loc13_.getType() == "monsterplant")
                     {
                        if(_loc15_ != null)
                        {
                           var _loc5_:class_2146 = _loc15_.userDataManager.getUserDataByIndex(param2);
                           if(_loc5_ != null)
                           {
                              _roomEngine.connection.send(new class_2766(null.webID,0,0,0));
                           }
                        }
                        break;
                     }
                     _roomEngine.connection.send(new class_2986(param2,0,0,0));
                  }
               }
               break;
            case "OBJECT_EJECT":
            case "OBJECT_PICKUP":
               if(_roomEngine.connection)
               {
                  _roomEngine.connection.send(new class_2426(param2,param3));
               }
               break;
            case "OBJECT_PICKUP_PET":
               if(_roomEngine.connection)
               {
                  if(_loc15_ != null)
                  {
                     _loc5_ = _loc15_.userDataManager.getUserDataByIndex(param2);
                     _loc15_.pickUpPet(null.webID);
                  }
               }
               break;
            case "OBJECT_PICKUP_BOT":
               if(_roomEngine.connection)
               {
                  if(_loc15_ != null)
                  {
                     _loc5_ = _loc15_.userDataManager.getUserDataByIndex(param2);
                     if(_loc5_ != null)
                     {
                        _roomEngine.connection.send(new class_2536(null.webID));
                     }
                  }
               }
               break;
            case "OBJECT_MOVE":
               var _loc11_:Boolean = false;
               setObjectAlphaMultiplier(_loc13_,0.5);
               setSelectedObjectData(param1,_loc13_.getId(),param3,_loc13_.getLocation(),_loc13_.getDirection(),param4);
               _roomEngine.setObjectMoverIconSprite(_loc13_.getId(),param3,true);
               _roomEngine.setObjectMoverIconSpriteVisible(false);
               break;
            case "OBJECT_MOVE_TO":
               var _loc6_:class_1925 = getSelectedObjectData(param1);
               updateSelectedObjectData(param1,null.id,null.category,null.loc,null.dir,"OBJECT_MOVE_TO",null.typeId,null.instanceData,null.stuffData,null.state,null.animFrame,null.posture);
               setObjectAlphaMultiplier(_loc13_,1);
               _roomEngine.removeObjectMoverIconSprite();
               if(_roomEngine.connection)
               {
                  if(param3 == 10)
                  {
                     _loc14_ = int(_loc13_.getDirection().x) % 360;
                     _loc8_ = int(_loc13_.getLocation().x);
                     _loc10_ = int(_loc13_.getLocation().y);
                     _loc14_ = 0 / 45;
                     if(_loc15_ != null)
                     {
                        _loc15_.trackEventLogOncePerSession("Tutorial","interaction","furniture.move");
                     }
                     _roomEngine.connection.send(new class_2986(param2,0,0,0));
                     break;
                  }
                  if(param3 == 100)
                  {
                     _loc14_ = int(_loc13_.getDirection().x) % 360;
                     _loc8_ = int(_loc13_.getLocation().x);
                     _loc10_ = int(_loc13_.getLocation().y);
                     _loc14_ = 0 / 45;
                     var _loc7_:int = parseInt(_loc13_.getModel().getString("race"));
                     if(_loc15_ != null)
                     {
                        _loc5_ = _loc15_.userDataManager.getUserDataByIndex(param2);
                        if(_loc5_ != null)
                        {
                           _roomEngine.connection.send(new class_2766(null.webID,0,0,0));
                        }
                     }
                     break;
                  }
                  if(param3 == 20)
                  {
                     _loc14_ = int(_loc13_.getDirection().x) % 360;
                     var _loc12_:class_1821 = _roomEngine.getLegacyGeometry(param1);
                     if(_roomEngine.connection && null)
                     {
                        var _loc9_:String = null.getOldLocationString(_loc13_.getLocation(),0);
                        if(_loc9_ != null)
                        {
                           if(_loc15_ != null)
                           {
                              _loc15_.trackEventLogOncePerSession("Tutorial","interaction","furniture.move");
                           }
                           _roomEngine.connection.send(new class_3221(param2,20,null));
                        }
                     }
                  }
               }
         }
         resetSelectedObjectData(param1);
         return true;
      }
      
      private function placeObjectOnUser(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:class_1925 = getSelectedObjectData(param1);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,param3) as IRoomObjectController;
         if(_loc5_ == null)
         {
            return;
         }
         if(_roomEngine && _roomEngine.events)
         {
            _roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedOnUserEvent("REOE_PLACED_ON_USER",param1,param2,param3,_loc4_.id,_loc4_.category));
         }
      }
      
      private function placeObject(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc6_:IRoomObjectController = null;
         var _loc4_:IVector3d = null;
         var _loc16_:class_1821 = null;
         var _loc9_:Boolean = false;
         var _loc5_:class_1925 = getSelectedObjectData(param1);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc14_:int = _loc5_.id;
         var _loc15_:int = _loc5_.category;
         var _loc11_:String = "";
         var _loc10_:Number = 0;
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc7_:int = 0;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            _loc6_ = _roomEngine.getRoomObject(param1,_loc14_,_loc15_) as IRoomObjectController;
            if(_loc6_ != null)
            {
               _loc7_ = int(_loc6_.getDirection().x);
               _loc4_ = _loc6_.getLocation();
               if(_loc15_ == 10 || _loc15_ == 100)
               {
                  _loc10_ = _loc4_.x;
                  _loc12_ = _loc4_.y;
                  _loc13_ = _loc4_.z;
               }
               else if(_loc15_ == 20)
               {
                  _loc10_ = _loc4_.x;
                  _loc12_ = _loc4_.y;
                  _loc13_ = _loc4_.z;
                  _loc16_ = _roomEngine.getLegacyGeometry(param1);
                  if(_loc16_ != null)
                  {
                     _loc11_ = _loc16_.getOldLocationString(_loc4_,_loc7_);
                  }
               }
               _loc7_ = (_loc7_ / 45 % 8 + 8) % 8;
               if(_loc6_.getType() == "free_placement_room" && roomEngine.getRoom(param1).getObjectCountForType("free_placement_room",10) > 1)
               {
                  roomEngine.windowManager.alert("One free placement furni already in room!","There can be only one free_placement_room furni in a room. See intraweb for instructions on how to use it.",0,null);
                  return;
               }
               if(_loc14_ < 0 && _loc15_ == 100)
               {
                  _loc14_ *= -1;
               }
               if(var_3789 == "inventory")
               {
                  if(_loc15_ == 100 && _loc5_.typeId == 2)
                  {
                     _roomEngine.connection.send(new class_3179(_loc14_,int(_loc10_),int(_loc12_)));
                  }
                  else if(_loc15_ == 100 && _loc5_.typeId == 4)
                  {
                     _roomEngine.connection.send(new class_3639(_loc14_,int(_loc10_),int(_loc12_)));
                  }
                  else if(_loc6_.getModelController().getString("furniture_is_stickie") != null)
                  {
                     _roomEngine.connection.send(new class_3139(_loc14_,_loc11_));
                  }
                  else
                  {
                     _roomEngine.connection.send(new class_2048(_loc14_,_loc15_,_loc11_,int(_loc10_),int(_loc12_),_loc7_));
                  }
               }
            }
         }
         var _loc8_:class_1925 = new class_1925(_loc5_.id,_loc5_.category,null,null,null);
         _roomEngine.setPlacedObjectData(param1,_loc8_);
         resetSelectedObjectData(param1);
         if(_roomEngine && _roomEngine.events)
         {
            _loc9_ = _loc6_ && _loc6_.getId() == _loc5_.id;
            _roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedEvent("REOE_PLACED",param1,_loc14_,_loc15_,_loc11_,_loc10_,_loc12_,_loc13_,_loc7_,_loc9_,param2,param3,_loc5_.instanceData,var_3789));
         }
      }
      
      private function changeObjectState(param1:int, param2:int, param3:String, param4:int, param5:Boolean) : void
      {
         var _loc6_:int = _roomEngine.getRoomObjectCategory(param3);
         changeRoomObjectState(param1,param2,_loc6_,param4,param5);
      }
      
      private function changeRoomObjectState(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : Boolean
      {
         var _loc8_:IRoomSession = null;
         var _loc6_:IRoomObject = null;
         var _loc7_:class_1925 = null;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            _loc8_ = _roomEngine.roomSessionManager.getSession(param1);
            if(_loc8_ != null && _loc8_.playTestMode)
            {
               _loc6_ = _roomEngine.getRoomObject(param1,param2,param3);
               if(_loc6_.getModel().getNumber("furniture_usage_policy") < 2)
               {
                  return false;
               }
            }
            _loc7_ = getSelectedObjectData(param1);
            if(_loc7_ == null || _loc7_.operation != "OBJECT_PLACE")
            {
               if(param3 == 10)
               {
                  if(!param5)
                  {
                     _roomEngine.connection.send(new class_2945(param2,param4));
                  }
                  else
                  {
                     _roomEngine.connection.send(new class_3097(param2,param4));
                  }
               }
               else if(param3 == 20)
               {
                  _roomEngine.connection.send(new class_3295(param2,param4));
               }
            }
            if(_loc8_ != null)
            {
               _loc8_.trackEventLogOncePerSession("Achievements","interaction","furniture.use");
            }
         }
         return true;
      }
      
      private function useObject(param1:int, param2:int, param3:String, param4:String) : void
      {
         var confirm:*;
         var roomId:int = param1;
         var objectId:int = param2;
         var objectType:String = param3;
         var useType:String = param4;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(useType)
            {
               case "ROFCAE_DICE_ACTIVATE":
                  _roomEngine.connection.send(new class_3588(objectId));
                  break;
               case "ROFCAE_DICE_OFF":
                  _roomEngine.connection.send(new class_2698(objectId));
                  break;
               case "ROFCAE_USE_HABBOWHEEL":
                  _roomEngine.connection.send(new class_2726(objectId));
                  break;
               case "ROFCAE_STICKIE":
                  _roomEngine.connection.send(new class_2449(objectId));
                  break;
               case "ROFCAE_ENTER_ONEWAYDOOR":
                  _roomEngine.connection.send(new class_2415(objectId));
                  break;
               case "ROFCAE_NFT_REWARD_BOX":
                  confirm = function(param1:class_2001, param2:class_1758):void
                  {
                     param1.dispose();
                     if(param2.type == "WE_OK")
                     {
                        _roomEngine.connection.send(new class_2618(objectId));
                     }
                  };
                  _roomEngine.windowManager.confirm("${collectibles.reward_box.confirm_title}","${collectibles.reward_box.confirm_description}",0,confirm);
            }
         }
      }
      
      public function modifyWallItemData(param1:int, param2:int, param3:String, param4:String) : Boolean
      {
         if(_roomEngine == null || _roomEngine.connection == null)
         {
            return false;
         }
         _roomEngine.connection.send(new class_2364(param2,param3,param4));
         return true;
      }
      
      public function deleteWallItem(param1:int, param2:int) : Boolean
      {
         if(_roomEngine == null || _roomEngine.connection == null)
         {
            return false;
         }
         _roomEngine.connection.send(new class_3530(param2));
         return true;
      }
      
      private function handleClickOnTile(param1:int, param2:RoomObjectTileMouseEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(_roomEngine.isDecorateMode)
         {
            return;
         }
         if(!_roomEngine.roomSessionManager)
         {
            return;
         }
         var _loc3_:IRoomSession = _roomEngine.roomSessionManager.getSession(param1);
         if(_loc3_ != null && _loc3_.isSpectatorMode)
         {
            return;
         }
         if(_roomEngine.isGameMode)
         {
            if(_roomEngine.playerUnderCursor >= 0)
            {
               _roomEngine.gameEngine.handleClickOnHuman(_roomEngine.playerUnderCursor,param2.altKey,param2.shiftKey);
            }
            else
            {
               _roomEngine.gameEngine.handleClickOnTile(param2);
            }
         }
         else
         {
            if(_loc3_)
            {
               _loc3_.trackEventLogOncePerSession("Tutorial","interaction","avatar.move");
            }
            if(!roomEngine.isMoveBlocked())
            {
               walkTo(param2.tileXAsInt,param2.tileYAsInt);
            }
         }
      }
      
      private function walkTo(param1:int, param2:int) : void
      {
         if(_roomEngine.connection)
         {
            _roomEngine.connection.send(new class_2430(param1,param2));
         }
      }
      
      private function handleClickOnAvatar(param1:int, param2:RoomObjectMouseEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(roomEngine.isDecorateMode)
         {
            return;
         }
         if(_roomEngine.isGameMode)
         {
            _roomEngine.gameEngine.handleClickOnHuman(param1,param2.altKey,param2.shiftKey);
         }
      }
      
      private function handleMouseEnterAvatar(param1:int, param2:RoomObjectMouseEvent, param3:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(roomEngine.isDecorateMode)
         {
            return;
         }
         if(_roomEngine.isGameMode)
         {
            var _loc8_:IRoomObjectController = _roomEngine.getTileCursor(param3);
            if(_loc8_ != null && null.getEventHandler() != null)
            {
               var _loc10_:IRoomObjectController = _roomEngine.getRoomObject(param3,param1,100) as IRoomObjectController;
               var _loc9_:RoomObjectUpdateMessage = null;
            }
            _roomEngine.gameEngine.handleMouseOverOnHuman(param1,param2.altKey,param2.shiftKey);
         }
      }
      
      private function isWhereYouClickWhereYouGo() : Boolean
      {
         return roomEngine.isWhereYouClickWhereYouGo();
      }
   }
}

