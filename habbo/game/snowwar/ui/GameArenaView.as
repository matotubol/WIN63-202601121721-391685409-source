package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.avatar.class_1900;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   import com.sulake.habbo.game.snowwar.KeyboardControl;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
   import com.sulake.habbo.game.snowwar.class_2694;
   import com.sulake.habbo.game.snowwar.class_3118;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_30;
   import com.sulake.habbo.room.class_32;
   import com.sulake.habbo.room.class_34;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class GameArenaView implements class_13
   {
      
      private static const GAME_ROOM_ID:int = 1;
      
      private static const TILE_CURSOR_STATE_TEAM_1:int = 3;
      
      private static const TILE_CURSOR_STATE_TEAM_2:int = 2;
      
      private static const TILE_CURSOR_STATE_TEAM_3:int = 4;
      
      private static const TILE_CURSOR_STATE_TEAM_4:int = 5;
      
      private static const EFFECT_RED_TEAM:int = 95;
      
      private static const EFFECT_BLUE_TEAM:int = 96;
      
      private static const EFFECT_CROSSHAIR:int = 98;
      
      private static const SPLASH_LIFE_SPAN_TIME:int = 500;
      
      private var var_49:SnowWarEngine;
      
      private var var_1670:Array = [];
      
      private var var_1617:Array = [];
      
      private var var_2657:Array = [];
      
      private var var_2501:KeyboardControl;
      
      private var var_1134:Boolean = false;
      
      private var var_166:SnowWarUI;
      
      private var var_2484:Boolean;
      
      private var var_360:Stage;
      
      private var var_5265:Boolean;
      
      public function GameArenaView(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
         var_49.roomEngine.addObjectUpdateCategory(202);
      }
      
      public function dispose() : void
      {
         var_49.roomEngine.disposeRoom(1);
         var_49.roomEngine.removeObjectUpdateCategory(202);
         if(var_2501)
         {
            var_2501.dispose();
            var_2501 = null;
         }
         if(var_360 != null)
         {
            var_360.removeEventListener("mouseMove",onMouseMove);
            var_360 = null;
         }
         var_49 = null;
         var_1670 = null;
         var_1617 = null;
         if(var_166)
         {
            var_166.dispose();
            var_166 = null;
         }
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function init() : void
      {
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:Number = NaN;
         var _loc1_:Vector3d = null;
         var _loc5_:Vector3d = null;
         var _loc13_:int = 0;
         var _loc9_:IStuffData = null;
         var _loc14_:int = 0;
         var _loc6_:Number = NaN;
         var_49.roomEngine.isGameMode = true;
         var _loc7_:class_2694 = var_49.gameArena.getCurrentStage() as class_2694;
         var _loc2_:GameLevelData = _loc7_.gameLevelData;
         var _loc8_:Array = _loc7_.getTiles();
         var _loc3_:RoomPlaneParser = new RoomPlaneParser();
         _loc3_.initializeTileMap(_loc2_.width,_loc2_.height);
         _loc11_ = 0;
         while(_loc11_ < _loc2_.height)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc2_.width)
            {
               _loc3_.setTileHeight(_loc10_,_loc11_,_loc8_[_loc11_][_loc10_] == null ? -100 : 0);
               _loc10_++;
            }
            _loc11_++;
         }
         _loc3_.initializeFromTileData();
         var_49.roomEngine.initializeRoom(1,_loc3_.getXML());
         (var_49.roomEngine as class_30).updateObjectRoomVisibilities(1,false);
         _loc3_.dispose();
         for each(var _loc4_ in _loc7_.gameLevelData.fuseObjects)
         {
            _loc12_ = _loc4_.altitude / Tile.TILE_HALFWIDTH;
            _loc1_ = new Vector3d(_loc4_.x,_loc4_.y,_loc12_);
            _loc5_ = new Vector3d(_loc4_.direction * 45);
            _loc13_ = var_49.roomEngine.getFurnitureTypeId(_loc4_.name);
            _loc9_ = _loc4_.stuffData;
            _loc14_ = 0;
            _loc6_ = parseInt(_loc9_.getLegacyString());
            if(!isNaN(_loc6_))
            {
               _loc14_ = _loc6_;
            }
            var_49.roomEngine.addObjectFurniture(1,_loc4_.id,_loc13_,_loc1_,_loc5_,_loc14_,_loc9_);
         }
         var_49.roomUI.visible = false;
         var_360 = var_49.context.displayObjectContainer.stage;
         var_360.addEventListener("mouseMove",onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var_5265 = param1.altKey || param1.shiftKey;
      }
      
      public function initGameUI(param1:int) : void
      {
         var_166 = new SnowWarUI(var_49);
         var_166.init();
         initCountDown();
      }
      
      public function removeGameUI() : void
      {
         if(var_166)
         {
            var_166.dispose();
            var_166 = null;
         }
      }
      
      public function update(param1:uint, param2:Boolean = false) : void
      {
         var _loc11_:Direction8 = null;
         var _loc25_:HumanGameObject = null;
         var _loc16_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:int = 0;
         var _loc18_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:IRoomObject = null;
         var _loc22_:IVector3d = null;
         var _loc21_:int = 0;
         var _loc26_:* = undefined;
         var _loc7_:HumanGameObject = null;
         var _loc4_:* = false;
         var _loc19_:int = 0;
         var _loc24_:SnowBallGameObject = null;
         var _loc6_:SnowballMachineGameObject = null;
         var _loc8_:SnowballPileGameObject = null;
         var _loc20_:TreeGameObject = null;
         if(param2 && var_2501)
         {
            _loc11_ = var_2501.direction;
            if(_loc11_)
            {
               _loc25_ = var_49.gameArena.getCurrentStage().getGameObject(var_49.ownId) as HumanGameObject;
               _loc16_ = _loc25_.currentLocation.x / 3200;
               _loc13_ = _loc25_.currentLocation.y / 3200;
               _loc16_ += _loc11_.getUnitVectorXcomponent() * 2;
               _loc13_ += _loc11_.getUnitVectorYcomponent() * 2;
               var_49.moveOwnAvatarTo(_loc16_,_loc13_);
            }
         }
         var _loc23_:int = getTimer();
         for each(var _loc12_ in var_49.gameArena.getCurrentStage().resetRemovedGameObjects())
         {
            _loc9_ = _loc12_.gameObjectId;
            _loc18_ = int(var_1670.indexOf(_loc9_));
            if(_loc18_ > -1)
            {
               var_49.roomEngine.disposeObjectUser(1,_loc9_);
               var_1670.splice(_loc18_,1);
            }
            _loc5_ = int(var_1617.indexOf(_loc9_));
            if(_loc5_ > -1)
            {
               _loc17_ = var_49.roomEngine.getRoomObject(1,_loc9_,201);
               _loc22_ = _loc17_.getLocation();
               var_49.roomEngine.disposeObjectSnowWar(1,_loc9_,201);
               var_1617.splice(_loc5_,1);
               if(!ISynchronizedGameObject(_loc12_).isActive)
               {
                  var_49.roomEngine.addObjectSnowWar(1,_loc9_,_loc22_,202);
                  var_2657.push({
                     "id":_loc9_,
                     "time":_loc23_,
                     "category":202
                  });
               }
            }
         }
         _loc21_ = var_2657.length - 1;
         while(_loc21_ > -1)
         {
            _loc26_ = var_2657[_loc21_];
            if(_loc23_ - _loc26_.time >= 500)
            {
               var_49.roomEngine.disposeObjectSnowWar(1,_loc26_.id,_loc26_.category);
               var_2657.splice(_loc21_,1);
            }
            _loc21_--;
         }
         var _loc10_:Array = var_49.gameArena.getCurrentStage().getGameObjects();
         var _loc15_:Boolean = false;
         for each(var _loc3_ in _loc10_)
         {
            _loc7_ = _loc3_ as HumanGameObject;
            if(_loc7_)
            {
               _loc4_ = _loc7_.posture == "swrun";
               _loc15_ ||= _loc4_;
               updateHumanGameObject(_loc7_);
               if(_loc7_.gameObjectId == var_49.ownId)
               {
                  _loc19_ = (var_49.gameArena.getExtension() as class_3118).getPulseInterval();
                  var_166.timer = var_49.stageLength - var_49.currentSubTurn * _loc19_ / 1000;
                  var_166.ownScore = _loc7_.score;
                  var_166.snowballs = _loc7_.snowballs;
                  var_166.hitPoints = _loc7_.hitPoints;
               }
            }
            _loc24_ = _loc3_ as SnowBallGameObject;
            if(_loc24_)
            {
               updateSnowballGameObject(_loc24_);
            }
            _loc6_ = _loc3_ as SnowballMachineGameObject;
            if(_loc6_)
            {
               updateSnowballMachineGameObject(_loc6_);
            }
            _loc8_ = _loc3_ as SnowballPileGameObject;
            if(_loc8_)
            {
               updateSnowballPileGameObject(_loc8_);
            }
            _loc20_ = _loc3_ as TreeGameObject;
            if(_loc20_)
            {
               updateTreeGameObject(_loc20_);
            }
         }
         if(var_166)
         {
            var_166.update(param1);
         }
         if(_loc15_ && !var_2484)
         {
            var_2484 = true;
            SnowWarEngine.playSound("HBSTG_snowwar_walk",2147483647);
         }
         else if(!_loc15_ && var_2484)
         {
            var_2484 = false;
            SnowWarEngine.stopSound("HBSTG_snowwar_walk");
         }
         var _loc14_:HumanGameObject = var_49.getCurrentPlayer();
         var_49.roomEngine.updateObjectUserEffect(1,_loc14_.gameObjectId,_loc14_.team == 1 ? 96 : 95);
      }
      
      private function updateHumanGameObject(param1:HumanGameObject) : void
      {
         var _loc9_:Boolean = false;
         var _loc12_:IRoomObjectSpriteVisualization = null;
         var _loc6_:* = false;
         var _loc7_:Number = param1.currentLocation.x / 3200;
         var _loc4_:Number = param1.currentLocation.y / 3200;
         var _loc5_:int = param1.gameObjectId;
         var _loc10_:int = param1.getBodyDirection();
         var _loc8_:int = Direction360.direction8ToDirection360Value(Direction8.getDirection8(_loc10_));
         var _loc2_:IVector3d = new Vector3d(_loc8_,0,0);
         if(var_1670.indexOf(_loc5_) == -1)
         {
            var _loc3_:class_1900 = var_49.avatarManager.createFigureContainer(param1.figure);
            switch(param1.team - 1)
            {
               case 0:
                  null.updatePart("ch",20000,[1]);
                  break;
               case 1:
                  null.updatePart("ch",20001,[1]);
                  break;
               default:
                  null.updatePart("ch",20000,[1]);
            }
            null.removePart("cc");
            var_49.roomEngine.addObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),_loc2_,_loc8_,1,null.getFigureString());
            var_49.roomEngine.updateObjectUserPosture(1,_loc5_,"std");
            var_49.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",1);
            var_1670.push(_loc5_);
            switch(param1.visualizationMode - 1)
            {
               case 0:
                  visualizeAsGhost(getRoomUserObject(_loc5_));
                  break;
               case 1:
                  hideVisualization(getRoomUserObject(_loc5_));
            }
         }
         else
         {
            var_49.roomEngine.updateObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),new Vector3d(_loc7_,_loc4_,0),false,0,_loc2_,_loc8_);
            var_49.roomEngine.updateObjectUserPosture(1,_loc5_,param1.posture);
            _loc9_ = param1.posture != "swdieback" && param1.posture != "swdiefront";
            var_49.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",int(_loc9_));
         }
         var _loc11_:IRoomObject = getRoomUserObject(_loc5_);
         if(_loc11_ != null)
         {
            _loc12_ = _loc11_.getVisualization() as IRoomObjectSpriteVisualization;
            _loc12_.getSprite(0).alpha = param1.invincible ? 100 : 255;
            _loc6_ = param1.team != var_49.getCurrentPlayer().team;
            if(_loc6_)
            {
               if((var_49.roomEngine as class_32).playerUnderCursor == _loc5_ && !param1.invincible && !param1.isStunned())
               {
                  var_49.roomEngine.updateObjectUserEffect(1,_loc5_,98);
               }
               else
               {
                  var_49.roomEngine.updateObjectUserEffect(1,_loc5_,0);
               }
            }
         }
      }
      
      private function updateSnowballGameObject(param1:SnowBallGameObject) : void
      {
         var _loc5_:Number = param1.location3D.x / 3200;
         var _loc3_:Number = param1.location3D.y / 3200;
         var _loc4_:Number = param1.location3D.z / Tile.TILE_HALFWIDTH;
         var _loc2_:Vector3d = new Vector3d(_loc5_,_loc3_,_loc4_);
         var _loc6_:int = param1.gameObjectId;
         if(var_1617.indexOf(_loc6_) == -1)
         {
            var_49.roomEngine.addObjectSnowWar(1,_loc6_,_loc2_,201);
            var_1617.push(_loc6_);
         }
         else
         {
            var_49.roomEngine.updateObjectSnowWar(1,_loc6_,_loc2_,201);
         }
      }
      
      private function updateSnowballMachineGameObject(param1:SnowballMachineGameObject) : void
      {
         var _loc3_:class_34 = var_49.roomEngine as class_34;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_.getState(0) != param1.snowballCount)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.snowballCount,null);
            _loc2_.setState(param1.snowballCount,0);
         }
      }
      
      private function updateSnowballPileGameObject(param1:SnowballPileGameObject) : void
      {
         var _loc3_:class_34 = var_49.roomEngine as class_34;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         var _loc4_:int = param1.maxSnowballs - param1.snowballCount;
         if(_loc2_ && _loc2_.getState(0) != _loc4_)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,_loc4_,null);
            _loc2_.setState(_loc4_,0);
         }
      }
      
      private function updateTreeGameObject(param1:TreeGameObject) : void
      {
         var _loc3_:class_34 = var_49.roomEngine as class_34;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_ && _loc2_.getState(0) != param1.hits)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.hits,null);
            _loc2_.setState(param1.hits,0);
         }
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return var_49.roomEngine.getRoomObject(1,param1,100);
      }
      
      private function visualizeAsGhost(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.blendMode = "hardlight";
               _loc4_++;
            }
         }
      }
      
      private function hideVisualization(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.visible = false;
               _loc4_++;
            }
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         var_166.showChecksumError(param1);
      }
      
      private function initCountDown() : void
      {
         var_166.initCounter();
         var_166.update(1000);
      }
      
      public function updateTileCursor(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 3;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 4;
               break;
            case 3:
               _loc2_ = 5;
               break;
            default:
               _loc2_ = 0;
         }
         var_49.roomEngine.setTileCursorState(1,_loc2_);
      }
      
      public function stopWaitingForSnowball() : void
      {
         if(var_166)
         {
            var_166.stopWaitingForSnowball();
         }
      }
      
      public function startWaitingForSnowball() : void
      {
         if(var_166)
         {
            var_166.startWaitingForSnowball();
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         if(var_166)
         {
            var_166.flashOwnScore(param1);
         }
      }
   }
}

