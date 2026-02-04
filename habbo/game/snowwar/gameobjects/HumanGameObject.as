package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.class_2694;
   import com.sulake.habbo.game.snowwar.class_3118;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.class_3895;
   import package_38.HumanGameObjectData;
   
   public class HumanGameObject extends SnowWarGameObject
   {
      
      public static const const_1000:int = 534;
      
      public static const INITIAL_SNOWBALL_COUNT:int = 5;
      
      public static const MAXIMUM_SNOWBALL_COUNT:int = 5;
      
      public static const INITIAL_HIT_POINTS:int = 5;
      
      public static const SNOWBALL_CREATE_TIME:int = 20;
      
      public static const STUN_TIME:int = 100;
      
      public static const INVINCIBLE_AFTER_STUN_TIME:int = 60;
      
      public static const ACTIVITY_STATE_NORMAL:int = 0;
      
      public static const ACTIVITY_STATE_MAKING_SNOWBALL:int = 1;
      
      public static const ACTIVITY_STATE_STUNNED:int = 2;
      
      public static const ACTIVITY_STATE_INVINCIBLE_AFTER_STUN:int = 3;
      
      public static const SNOWBALL_THROW_INTERVAL:int = 5;
      
      public static const PLAYER_HEIGHT:int = 5000;
      
      private static const SCORE_ON_KNOCK_DOWN:int = 5;
      
      private static const SCORE_ON_HIT:int = 1;
      
      public static const BOUNDING_DATA:Array = [1600];
      
      private var var_116:Tile;
      
      private var var_46:Tile;
      
      private var var_407:Boolean;
      
      private var var_138:Location3D = new Location3D(0,0,0);
      
      private var var_288:Location3D = new Location3D(0,0,0);
      
      private var var_586:Direction8 = Direction8.SE;
      
      private var _hitPoints:int;
      
      private var var_220:int;
      
      protected var var_3793:int;
      
      private var var_305:int;
      
      private var var_97:int;
      
      private var var_808:int;
      
      private var var_1242:int;
      
      private var var_1185:int;
      
      private var _name:String;
      
      private var var_3081:String;
      
      private var var_975:String;
      
      private var var_1309:String;
      
      private var var_1270:int;
      
      private var var_4182:int = 0;
      
      private var var_49:SnowWarEngine;
      
      private var var_2150:class_55;
      
      public function HumanGameObject(param1:class_2694, param2:HumanGameObjectData, param3:Boolean, param4:SnowWarEngine)
      {
         super(param2.id,param3);
         var_1309 = param2.sex;
         _name = param2.name;
         var_3081 = param2.mission;
         var_975 = param2.figure;
         var_1242 = param2.team;
         var_1270 = param2.userId;
         var_97 = param2.activityState;
         var_305 = param2.activityTimer;
         var_138.change2DLocation(param2.currentLocationX,param2.currentLocationY);
         var_586 = Direction8.getDirection8(param2.bodyDirection);
         _hitPoints = param2.hitPoints;
         var_288.change2DLocation(param2.moveTargetX,param2.moveTargetY);
         var_220 = param2.snowBallCount;
         var_808 = param2.score;
         var_116 = param1.getTileAt(param2.currentTileX,param2.currentTileY);
         var_116.addGameObject(this);
         var _loc5_:Tile = param1.getTileAt(param2.nextTileX,param2.nextTileY);
         if(_loc5_ != var_116)
         {
            var_46 = _loc5_;
            var_46.addGameObject(this);
            var_116.removeOccupyingHuman();
            var_407 = true;
         }
         var_49 = param4;
         var_2150 = new class_55();
      }
      
      public function get visualizationMode() : int
      {
         return var_4182;
      }
      
      public function set visualizationMode(param1:int) : void
      {
         var_4182 = param1;
      }
      
      public function get invincible() : Boolean
      {
         return var_97 == 3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1309 = "";
         _name = "";
         var_3081 = "";
         var_975 = "";
         var_1242 = 0;
         var_1270 = 0;
         var_138 = null;
         var_586 = null;
         var_288 = null;
         var_220 = 0;
         var_808 = 0;
         var_407 = false;
         var_49 = null;
         var_2150 = null;
      }
      
      override public function get numberOfVariables() : int
      {
         return 19;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 5;
            case 1:
               return var_611;
            case 2:
               return var_138.x;
            case 3:
               return var_138.y;
            case 4:
               return var_116.fuseLocation[0];
            case 5:
               return var_116.fuseLocation[1];
            case 6:
               return var_586.intValue();
            case 7:
               return _hitPoints;
            case 8:
               return var_220;
            case 9:
               return var_3793;
            case 10:
               return var_305;
            case 11:
               return var_97;
            case 12:
               return var_46 != null ? var_46.fuseLocation[0] : var_116.fuseLocation[0];
            case 13:
               return var_46 != null ? var_46.fuseLocation[1] : var_116.fuseLocation[1];
            case 14:
               return var_288.x;
            case 15:
               return var_288.y;
            case 16:
               return var_808;
            case 17:
               return var_1242;
            case 18:
               return var_1270;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      public function reinitGhost(param1:HumanGameObject) : void
      {
         var_138.change2DLocation(param1.var_138.x,param1.var_138.y);
         var_116 = param1.var_116;
         var_586 = param1.var_586;
         _hitPoints = param1._hitPoints;
         var_220 = param1.var_220;
         var_3793 = param1.var_3793;
         var_305 = param1.var_305;
         var_97 = param1.var_97;
         var_46 = param1.var_46;
         var_288.change2DLocation(param1.var_288.x,param1.var_288.y);
         var_808 = param1.var_808;
         var_1242 = param1.var_1242;
         var_1270 = param1.var_1270;
      }
      
      public function isInGhostDistance(param1:int, param2:Location3D) : Boolean
      {
         var _loc3_:Location3D = var_2150[param1];
         if(_loc3_)
         {
            return _loc3_.isInDistance(param2,Tile.TILE_ONEANDHALFWIDTH);
         }
         return false;
      }
      
      public function addGhostLocation(param1:int) : void
      {
         var _loc2_:Location3D = new Location3D(0,0,0);
         _loc2_.change2DLocation(var_138.x,var_138.y);
         var_2150[param1] = _loc2_;
      }
      
      public function removeGhostLocation(param1:int) : void
      {
         var_2150.remove(param1);
      }
      
      public function setBodyDirection(param1:Direction8) : void
      {
         var_586 = param1;
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function get boundingData() : Array
      {
         return BOUNDING_DATA;
      }
      
      override public function get location3D() : Location3D
      {
         return var_138;
      }
      
      override public function get direction360() : Direction360
      {
         return null;
      }
      
      override public function onRemove() : void
      {
         if(var_116 && var_116.occupyingHuman == this)
         {
            var_116.removeOccupyingHuman();
         }
         if(var_46 && var_46.occupyingHuman == this)
         {
            var_46.removeOccupyingHuman();
         }
         var_407 = false;
      }
      
      public function activityTimerTriggered() : void
      {
         if(var_97 == 2)
         {
            _hitPoints = 5;
            var_97 = 3;
            var_305 = 60;
            return;
         }
         if(var_97 == 1)
         {
            var_220 = var_220 + 1;
         }
         var_97 = 0;
         var_49.stopWaitingForSnowball(gameObjectId);
      }
      
      override public function subturn(param1:class_2693) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Direction8 = null;
         var _loc4_:class_2694 = param1 as class_2694;
         if(var_305 > 0)
         {
            if(var_305 == 1)
            {
               activityTimerTriggered();
            }
            var_305 = var_305 - 1;
         }
         if(var_1185 > 0)
         {
            var_1185 = var_1185 - 1;
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " currentTile:" + var_116 + " nextTile:" + var_46);
         }
         if(canMove() && var_116 != null)
         {
            if(var_46 != null)
            {
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Moving towards next tile:" + var_46 + " _currentLocation:" + var_138);
               }
               moveTowardsNextTile();
            }
            else if(!var_116.locationIsInTileRange(var_288))
            {
               _loc2_ = Direction360.getAngleFromComponents(var_288.x - var_116.location.x,var_288.y - var_116.location.y);
               _loc3_ = Direction360.direction360ValueToDirection8(_loc2_);
               var_46 = var_116.getTileInDirection(_loc3_);
               if(var_46 == null || !var_46.canMoveTo(this))
               {
                  if(var_46 != null && !var_46.canMoveTo(this))
                  {
                     if(var_288.equals(var_46.location))
                     {
                        var_46 = null;
                        stopMovement();
                        return;
                     }
                  }
                  _loc3_ = _loc3_.rotateDirection(-1);
                  var_46 = var_116.getTileInDirection(_loc3_);
                  if(var_46 == null || !var_46.canMoveTo(this))
                  {
                     _loc3_ = _loc3_.rotateDirection(2);
                     var_46 = var_116.getTileInDirection(_loc3_);
                     if(var_46 != null && !var_46.canMoveTo(this))
                     {
                        var_46 = null;
                     }
                  }
               }
               if(var_46 != null)
               {
                  if(!isGhost)
                  {
                     var_116.removeOccupyingHuman();
                     var_46.addGameObject(this);
                  }
                  setBodyDirection(_loc3_);
                  moveTowardsNextTile();
               }
               else
               {
                  var_407 = false;
               }
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Starting to move to next tile in direction360:" + _loc2_ + ", nextTile is now " + var_46 + "_currentLocationn:" + var_138 + ", moveTarget:" + var_288);
               }
            }
            else
            {
               var_407 = false;
            }
         }
         else
         {
            var_407 = false;
         }
      }
      
      private function moveTowardsNextTile() : void
      {
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], currentX: " + var_138.x + " currentY: " + var_138.y);
         }
         var _loc5_:int = var_46.location.x;
         var _loc1_:int = var_138.x;
         var _loc2_:int = _loc1_ - _loc5_;
         if(_loc2_ != 0)
         {
            if(_loc2_ < 0)
            {
               if(_loc2_ > -534)
               {
                  _loc1_ = _loc5_;
               }
               else
               {
                  _loc1_ += 534;
               }
            }
            else if(_loc2_ < 534)
            {
               _loc1_ = _loc5_;
            }
            else
            {
               _loc1_ -= 534;
            }
         }
         var _loc3_:int = var_46.location.y;
         var _loc6_:int = var_138.y;
         var _loc4_:int = _loc6_ - _loc3_;
         if(_loc4_ != 0)
         {
            if(_loc4_ < 0)
            {
               if(_loc4_ > -534)
               {
                  _loc6_ = _loc3_;
               }
               else
               {
                  _loc6_ += 534;
               }
            }
            else if(_loc4_ < 534)
            {
               _loc6_ = _loc3_;
            }
            else
            {
               _loc6_ -= 534;
            }
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], nextX: " + _loc1_ + " nextY: " + _loc6_);
         }
         var_138.change2DLocation(_loc1_,_loc6_);
         if(var_138.distanceTo(var_46.location) < class_3895.javaDiv(534 / 2))
         {
            var_116 = var_46;
            var_46 = null;
         }
         var_407 = true;
      }
      
      public function changeMoveTarget(param1:int, param2:int) : void
      {
         if(var_97 == 1)
         {
            var_97 = 0;
            var_305 = 0;
            var_49.stopWaitingForSnowball(gameObjectId);
         }
         if(var_97 == 0 || var_97 == 3)
         {
            var_288.change2DLocation(param1,param2);
         }
      }
      
      public function get currentLocation() : Location3D
      {
         return var_138;
      }
      
      public function playerIsHitBySnowball(param1:class_2694, param2:HumanGameObject, param3:int) : void
      {
         if(var_2886)
         {
            return;
         }
         if(var_1242 == param2.team)
         {
            return;
         }
         if(_hitPoints > 0)
         {
            if(_hitPoints == 1)
            {
               playerFallsDown(param3);
               param2.onKnockDownHuman(param1,this);
               SnowWarEngine.playSound("HBSTG_snowwar_hit3");
            }
            _hitPoints = _hitPoints - 1;
            var_49.registerHit(this,param2);
         }
      }
      
      public function onHitHuman(param1:class_2694, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(class_3118(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,1);
         }
      }
      
      public function onKnockDownHuman(param1:class_2694, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(class_3118(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,5);
         }
      }
      
      public function addScore(param1:SynchronizedGameArena, param2:int) : void
      {
         var_808 += param2;
         param1.addTeamScore(team,param2);
      }
      
      public function playerFallsDown(param1:int) : void
      {
         var_97 = 2;
         var_305 = 100;
         setBodyDirection(Direction360.direction360ValueToDirection8(param1).oppositeDirection());
         stopMovement();
         var_49.stopWaitingForSnowball(gameObjectId);
      }
      
      public function stopMovement() : void
      {
         if(var_46 == null)
         {
            var_288.changeLocationToLocation(var_116.location);
            var_138.changeLocationToLocation(var_116.location);
         }
         else
         {
            var_116 = var_46;
            var_138.changeLocationToLocation(var_46.location);
            var_288.changeLocationToLocation(var_46.location);
            var_46 = null;
         }
         var_407 = false;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Stopped. dir:" + var_586 + "_currentTilee:" + var_116 + "_nextTilee:" + var_46 + "_currentLocationn:" + var_138 + "_moveTargett:" + var_288);
         }
      }
      
      public function getBodyDirection() : int
      {
         return var_586.intValue();
      }
      
      public function canThrowSnowballs() : Boolean
      {
         return var_220 > 0 && var_1185 < 1 && (var_97 == 0 || var_97 == 3);
      }
      
      public function startThrowTimer() : void
      {
         var_1185 = 5;
      }
      
      public function throwSnowball(param1:int, param2:int) : Boolean
      {
         if(var_220 < 1)
         {
            return false;
         }
         stopMovement();
         var _loc4_:int = Direction360.getAngleFromComponents(param1 - var_138.x,param2 - var_138.y);
         var _loc3_:int = Direction360.direction360ValueToDirection8(_loc4_).intValue();
         setBodyDirection(Direction8.getDirection8(_loc3_));
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turning to:" + _loc3_ + " 360 value:" + _loc4_ + " target:" + param1 + "," + param2 + " location:" + var_138.x + "," + var_138.y);
         }
         var_220 = var_220 - 1;
         return true;
      }
      
      public function canMove() : Boolean
      {
         return var_97 == 0 || var_97 == 3;
      }
      
      public function canMakeSnowballs() : Boolean
      {
         return (var_97 == 0 || var_97 == 3) && (var_220 < 5 || isGhost);
      }
      
      public function startMakingSnowball() : void
      {
         if(canMakeSnowballs())
         {
            var_97 = 1;
            var_305 = 20;
            stopMovement();
         }
      }
      
      public function getRemainingSnowballCapacity() : int
      {
         return 5 - var_220;
      }
      
      public function addSnowballs(param1:int) : void
      {
         var_220 += param1;
      }
      
      public function isStunned() : Boolean
      {
         return var_97 == 2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get mission() : String
      {
         return var_3081;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get sex() : String
      {
         return var_1309;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get team() : int
      {
         return var_1242;
      }
      
      public function get snowballs() : int
      {
         return var_220;
      }
      
      public function get hitPoints() : int
      {
         return _hitPoints;
      }
      
      public function get posture() : String
      {
         if(var_1185 > 0)
         {
            return "swthrow";
         }
         switch(var_97 - 1)
         {
            case 0:
               return "swpick";
            case 1:
               return "swdieback";
            default:
               if(var_407)
               {
                  return "swrun";
               }
               return "std";
         }
      }
      
      public function get action() : String
      {
         switch(var_97 - 3)
         {
            case 0:
               return "figure_dance";
            default:
               return "figure_dance";
         }
      }
      
      public function get parameter() : int
      {
         if(var_1185 > 1)
         {
            return 1;
         }
         if(var_1185 == 1)
         {
            return 0;
         }
         switch(var_97 - 3)
         {
            case 0:
               return 1;
            default:
               return 0;
         }
      }
      
      override public function testSnowBallCollision(param1:SnowBallGameObject) : Boolean
      {
         if(!var_2886 && var_97 != 2 && var_97 != 3 && param1.throwingHuman != this && super.testSnowBallCollision(param1))
         {
            return true;
         }
         return false;
      }
      
      override public function onSnowBallHit(param1:class_2694, param2:SnowBallGameObject) : void
      {
         var _loc3_:HumanGameObject = param2.throwingHuman;
         playerIsHitBySnowball(param1,_loc3_,param2.direction360.intValue());
         _loc3_.onHitHuman(param1,this);
         SnowWarEngine.playSound("HBSTG_snowwar_hit1");
      }
      
      override public function get collisionHeight() : int
      {
         return 5000;
      }
      
      public function toString() : String
      {
         return " ref:" + var_611 + "_name:" + _name;
      }
   }
}

