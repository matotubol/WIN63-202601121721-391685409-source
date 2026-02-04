package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class FurnitureParticleSystem
   {
      
      private var _emitters:class_55;
      
      private var _visualization:AnimatedFurnitureVisualization;
      
      private var var_2844:int;
      
      private var var_3401:int;
      
      private var _offsetY:int;
      
      private var var_151:FurnitureParticleSystemEmitter;
      
      private var var_110:BitmapData;
      
      private var var_389:IRoomObjectSprite;
      
      private var var_1346:Boolean = false;
      
      private var var_3875:int = 0;
      
      private var var_4107:int = 0;
      
      private var var_2608:Number = 1;
      
      private var var_1158:BitmapData;
      
      private var var_1461:ColorTransform;
      
      private var var_2617:ColorTransform;
      
      private var var_3385:Matrix;
      
      private var var_1922:Matrix;
      
      private var var_916:Number = 1;
      
      private var _bgColor:uint = 4278190080;
      
      public function FurnitureParticleSystem(param1:AnimatedFurnitureVisualization)
      {
         super();
         _emitters = new class_55();
         _visualization = param1;
         var_1461 = new ColorTransform();
         var_1461.alphaMultiplier = 1;
         var_2617 = new ColorTransform();
         var_3385 = new Matrix();
         var_1922 = new Matrix();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _emitters)
         {
            _loc1_.dispose();
         }
         _emitters = null;
         if(var_110)
         {
            var_110.dispose();
            var_110 = null;
         }
         if(var_1158)
         {
            var_1158.dispose();
            var_1158 = null;
         }
         var_1461 = null;
         var_2617 = null;
         var_3385 = null;
         var_1922 = null;
      }
      
      public function reset() : void
      {
         if(var_151)
         {
            var_151.reset();
         }
         var_151 = null;
         var_1346 = false;
         updateCanvas();
      }
      
      public function setAnimation(param1:int) : void
      {
         if(var_151)
         {
            var_151.reset();
         }
         var_151 = _emitters[param1];
         var_1346 = false;
         updateCanvas();
      }
      
      private function updateCanvas() : void
      {
         if(!var_151)
         {
            return;
         }
         if(var_3401 >= 0)
         {
            var_389 = _visualization.getSprite(var_3401);
            if(var_389 && var_389.asset)
            {
               if(var_389.width <= 1 || var_389.height <= 1)
               {
                  return;
               }
               if(var_110 && (var_110.width != var_389.width || var_110.height != var_389.height))
               {
                  var_110 = null;
               }
               if(var_110 == null)
               {
                  var_110 = var_389.asset.clone();
                  if(var_1461.alphaMultiplier != 1)
                  {
                     var_1158 = new BitmapData(var_110.width,var_110.height,true,_bgColor);
                  }
               }
               var_3875 = -var_389.offsetX;
               var_4107 = -var_389.offsetY;
               var_389.asset = var_110;
            }
            if(var_110)
            {
               var_110.fillRect(var_110.rect,_bgColor);
            }
            if(var_1158)
            {
               var_1158.fillRect(var_1158.rect,_bgColor);
            }
         }
      }
      
      public function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(var_151 && var_151.roomObjectSpriteId == param3)
         {
            return var_151.y * var_2608;
         }
         return 0;
      }
      
      public function controlsSprite(param1:int) : Boolean
      {
         if(var_151)
         {
            return var_151.roomObjectSpriteId == param1;
         }
         return false;
      }
      
      public function updateSprites() : void
      {
         if(!var_151 || !var_389)
         {
            return;
         }
         if(var_110 && var_389.asset != var_110)
         {
            var_389.asset = var_110;
            var_389.asset.width;
         }
         if(var_1346)
         {
            if(var_151.roomObjectSpriteId >= 0)
            {
               _visualization.getSprite(var_151.roomObjectSpriteId).visible = false;
            }
         }
      }
      
      public function updateAnimation() : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc1_:Rectangle = null;
         var _loc11_:IGraphicAsset = null;
         var _loc3_:BitmapData = null;
         var _loc8_:Point = null;
         if(!var_151 || !var_389)
         {
            return;
         }
         var _loc4_:Number = 0;
         var _loc2_:int = 0;
         if(!var_1346 && var_151.hasIgnited)
         {
            var_1346 = true;
         }
         _loc2_ = _offsetY * var_2608;
         var_151.update();
         if(var_1346)
         {
            if(var_151.roomObjectSpriteId >= 0)
            {
               _visualization.getSprite(var_151.roomObjectSpriteId).visible = false;
            }
            if(!var_110)
            {
               updateCanvas();
            }
            var_110.lock();
            if(var_1461.alphaMultiplier == 1)
            {
               var_110.fillRect(var_110.rect,_bgColor);
            }
            else
            {
               var_110.draw(var_1158,var_3385,var_1461,"normal",null,false);
            }
            for each(var _loc7_ in var_151.particles)
            {
               _loc4_ = _loc7_.y;
               _loc9_ = var_3875 + (_loc7_.x - _loc7_.z) * 10 / 10 * var_2608;
               _loc10_ = var_4107 - _loc2_ + (_loc4_ + (_loc7_.x + _loc7_.z) / 2) * 10 / 10 * var_2608;
               _loc11_ = _loc7_.getAsset();
               if(_loc11_)
               {
                  _loc3_ = _loc11_.asset.content as BitmapData;
                  if(_loc7_.fade && _loc7_.alphaMultiplier < 1)
                  {
                     var_1922.identity();
                     var_1922.translate(_loc9_ + _loc11_.offsetX,_loc10_ + _loc11_.offsetY);
                     var_2617.alphaMultiplier = _loc7_.alphaMultiplier;
                     var_110.draw(_loc3_,var_1922,var_2617,"normal",null,false);
                  }
                  else
                  {
                     _loc8_ = new Point(_loc9_ + _loc11_.offsetX,_loc10_ + _loc11_.offsetY);
                     var_110.copyPixels(_loc3_,_loc3_.rect,_loc8_,null,null,true);
                  }
               }
               else
               {
                  _loc1_ = new Rectangle(_loc9_ - 1,_loc10_ - 1,2,2);
                  var_110.fillRect(_loc1_,4294967295);
               }
            }
            var_110.unlock();
         }
      }
      
      public function parseData(param1:XML) : void
      {
         var _loc22_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc12_:Number = NaN;
         var_2844 = parseInt(param1.@size);
         var_3401 = param1.hasOwnProperty("@canvas_id") ? parseInt(param1.@canvas_id) : -1;
         _offsetY = param1.hasOwnProperty("@offset_y") ? parseInt(param1.@offset_y) : 10;
         var_2608 = var_2844 / 64;
         var_916 = param1.hasOwnProperty("@blend") ? Number(param1.@blend) : 1;
         var_916 = Math.min(var_916,1);
         var_1461.alphaMultiplier = var_916;
         var _loc8_:String = param1.hasOwnProperty("@bgcolor") ? String(param1.@bgcolor) : "0";
         _bgColor = param1.hasOwnProperty("@bgcolor") ? parseInt(_loc8_,16) : 4278190080;
         for each(var _loc6_ in param1.emitter)
         {
            var _loc9_:int = parseInt(_loc6_.@id);
            var _loc21_:String = _loc6_.@name;
            var _loc4_:int = parseInt(_loc6_.@sprite_id);
            var _loc24_:FurnitureParticleSystemEmitter = new FurnitureParticleSystemEmitter(null,0);
            _emitters[0] = null;
            var _loc19_:int = parseInt(_loc6_.@max_num_particles);
            var _loc14_:int = parseInt(_loc6_.@particles_per_frame);
            var _loc25_:int = _loc6_.hasOwnProperty("@burst_pulse") ? parseInt(_loc6_.@burst_pulse) : 1;
            var _loc18_:int = parseInt(_loc6_.@fuse_time);
            _loc22_ = Number(_loc6_.simulation.@force);
            _loc11_ = Number(_loc6_.simulation.@direction);
            _loc20_ = Number(_loc6_.simulation.@gravity);
            _loc3_ = Number(_loc6_.simulation.@airfriction);
            var _loc15_:String = _loc6_.simulation.@shape;
            _loc12_ = Number(_loc6_.simulation.@energy);
            for each(var _loc17_ in _loc6_.particles.particle)
            {
               var _loc10_:int = parseInt(_loc17_.@lifetime);
               var _loc13_:Boolean = _loc17_.@is_emitter == "false" ? false : true;
               var _loc5_:Boolean = _loc17_.hasOwnProperty("@fade") && _loc17_.@fade == "true" ? true : false;
               var _loc16_:Array = [];
               for each(var _loc2_ in _loc17_.frame)
               {
                  var _loc23_:IGraphicAsset = _visualization.assetCollection.getAsset(_loc2_.@name);
                  null.push(null);
               }
               null.configureParticle(0,false,null,false);
            }
            null.setup(0,0,_loc22_,new Vector3D(0,_loc11_,0),_loc20_,_loc3_,null,_loc12_,0,0);
         }
      }
      
      public function copyStateFrom(param1:FurnitureParticleSystem) : void
      {
         var _loc2_:int = 0;
         if(param1._emitters && param1.var_151)
         {
            _loc2_ = param1._emitters.getKey(param1._emitters.getValues().indexOf(param1.var_151));
         }
         setAnimation(_loc2_);
         if(var_151)
         {
            var_151.copyStateFrom(param1.var_151,param1.var_2844 / var_2844);
         }
         var_110 = null;
      }
   }
}

