package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.geom.Vector3D;
   
   public class FurnitureParticleSystemParticle
   {
      
      private var var_25:Number;
      
      private var var_26:Number;
      
      private var var_176:Number;
      
      private var var_1555:Number;
      
      private var var_1687:Number;
      
      private var var_1494:Number;
      
      private var var_935:Boolean = false;
      
      private var var_81:Vector3D;
      
      private var var_622:int = 0;
      
      private var _lifeTime:int;
      
      private var var_2456:Boolean = false;
      
      private var var_2157:Boolean = false;
      
      private var _fadeTime:Number;
      
      private var var_1756:Number = 1;
      
      private var var_353:Array;
      
      public function FurnitureParticleSystemParticle()
      {
         super();
      }
      
      public function get fade() : Boolean
      {
         return var_2157;
      }
      
      public function get alphaMultiplier() : Number
      {
         return var_1756;
      }
      
      public function get direction() : Vector3D
      {
         return var_81;
      }
      
      public function get age() : int
      {
         return var_622;
      }
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Vector3D, param5:Number, param6:Number, param7:int, param8:Boolean = false, param9:Array = null, param10:Boolean = false) : void
      {
         var_25 = param1;
         var_26 = param2;
         var_176 = param3;
         var_81 = new Vector3D(param4.x,param4.y,param4.z);
         var_81.scaleBy(param5);
         var_1555 = var_25 - var_81.x * param6;
         var_1687 = var_26 - var_81.y * param6;
         var_1494 = var_176 - var_81.z * param6;
         var_622 = 0;
         var_935 = false;
         _lifeTime = param7;
         var_2456 = param8;
         var_353 = param9;
         var_2157 = param10;
         var_1756 = 1;
         _fadeTime = 0.5 + Math.random() * 0.5;
      }
      
      public function update() : void
      {
         var_622 = var_622 + 1;
         if(var_622 == _lifeTime)
         {
            ignite();
         }
         if(var_2157)
         {
            if(var_622 / _lifeTime > _fadeTime)
            {
               var_1756 = (_lifeTime - var_622) / (_lifeTime * (1 - _fadeTime));
            }
         }
      }
      
      public function getAsset() : IGraphicAsset
      {
         if(var_353 && var_353.length > 0)
         {
            return var_353[var_622 % var_353.length];
         }
         return null;
      }
      
      protected function ignite() : void
      {
      }
      
      public function get isEmitter() : Boolean
      {
         return var_2456;
      }
      
      public function get isAlive() : Boolean
      {
         return var_622 <= _lifeTime;
      }
      
      public function dispose() : void
      {
         var_81 = null;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set x(param1:Number) : void
      {
         var_25 = param1;
      }
      
      public function set y(param1:Number) : void
      {
         var_26 = param1;
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
      }
      
      public function get lastX() : Number
      {
         return var_1555;
      }
      
      public function set lastX(param1:Number) : void
      {
         var_935 = true;
         var_1555 = param1;
      }
      
      public function get lastY() : Number
      {
         return var_1687;
      }
      
      public function set lastY(param1:Number) : void
      {
         var_935 = true;
         var_1687 = param1;
      }
      
      public function get lastZ() : Number
      {
         return var_1494;
      }
      
      public function set lastZ(param1:Number) : void
      {
         var_935 = true;
         var_1494 = param1;
      }
      
      public function get hasMoved() : Boolean
      {
         return var_935;
      }
      
      public function toString() : String
      {
         return [var_25,var_26,var_176].toString();
      }
      
      public function copy(param1:FurnitureParticleSystemParticle, param2:Number) : void
      {
         var_25 = param1.var_25 * param2;
         var_26 = param1.var_26 * param2;
         var_176 = param1.var_176 * param2;
         var_1555 = param1.var_1555 * param2;
         var_1687 = param1.var_1687 * param2;
         var_1494 = param1.var_1494 * param2;
         var_935 = param1.hasMoved;
         var_81 = param1.var_81;
         var_622 = param1.var_622;
         _lifeTime = param1._lifeTime;
         var_2456 = param1.var_2456;
         var_2157 = param1.var_2157;
         _fadeTime = param1._fadeTime;
         var_1756 = param1.var_1756;
      }
   }
}

