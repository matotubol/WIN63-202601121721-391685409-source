package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.utils.Dictionary;
   
   public class FurnitureFireworksVisualization extends AnimatedFurnitureVisualization
   {
      
      private var _particleSystems:Dictionary;
      
      private var var_316:FurnitureParticleSystem;
      
      public function FurnitureFireworksVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_316 = null;
         if(_particleSystems)
         {
            for each(var _loc1_ in _particleSystems)
            {
               _loc1_.dispose();
            }
            _particleSystems = null;
         }
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:FurnitureParticleSystem = null;
         if(super.updateObject(param1,param2))
         {
            _loc3_ = false;
            if(!_particleSystems)
            {
               readDefinition();
               if(_particleSystems)
               {
                  var_316 = _particleSystems[param1];
                  _loc3_ = true;
               }
               else
               {
                  class_21.log("ERROR Particle systems could not be read! " + this.object.getType());
               }
            }
            else if(param1 != var_199 || _particleSystems[param1] != var_316)
            {
               _loc4_ = _particleSystems[param1];
               _loc4_.copyStateFrom(var_316);
               if(var_316)
               {
                  var_316.reset();
               }
               var_316 = _loc4_;
               _loc3_ = true;
            }
            return true;
         }
         return false;
      }
      
      override protected function updateSprites(param1:int, param2:Boolean, param3:int) : void
      {
         super.updateSprites(param1,param2,param3);
         if(var_316)
         {
            var_316.updateSprites();
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(var_316)
         {
            var_316.updateAnimation();
         }
         return super.updateAnimation(param1);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(var_316)
         {
            var_316.setAnimation(param1);
         }
         super.setAnimation(param1);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(var_316 && var_316.controlsSprite(param3))
         {
            return var_316.getSpriteYOffset(param1,param2,param3);
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
      
      private function readDefinition() : Boolean
      {
         var _loc5_:IRoomObject = object;
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc7_:IRoomObjectModel = _loc5_.getModel();
         if(_loc7_ == null)
         {
            return false;
         }
         var _loc6_:String = _loc7_.getString("furniture_fireworks_data");
         if(!_loc6_ || _loc6_.length == 0)
         {
            class_21.log("No Particle System Data Found.");
            return false;
         }
         var _loc3_:XML = XML(_loc6_);
         _particleSystems = new Dictionary();
         for each(var _loc2_ in _loc3_.particlesystem)
         {
            if(!_loc2_.hasOwnProperty("@size"))
            {
               class_21.log("Particle System does not have size property!");
            }
            else
            {
               var _loc4_:int = int(_loc2_.@size);
               var _loc1_:FurnitureParticleSystem = new FurnitureParticleSystem(this);
               null.parseData(_loc2_);
               _particleSystems[0] = null;
            }
         }
         return true;
      }
   }
}

