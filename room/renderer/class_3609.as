package com.sulake.room.renderer
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.RoomRotatingEffect;
   import com.sulake.room.utils.RoomShakingEffect;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   [SecureSWF(rename="true")]
   public class class_3609 extends class_3523
   {
      
      private var _tools:Sprite;
      
      private var var_1737:Boolean = false;
      
      private var var_207:Number = 0;
      
      private var _rotationOrigin:Vector3d = null;
      
      private var _rotationRodLength:Number = 0;
      
      private var var_486:Array = [];
      
      private var var_646:Array = [];
      
      private var var_585:Vector3d;
      
      private var var_2113:Vector3d;
      
      private var var_493:int = 0;
      
      public function class_3609(param1:class_2018, param2:int, param3:int, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _tools = null;
         var_486 = [];
         var_646 = [];
      }
      
      override public function initialize(param1:int, param2:int) : void
      {
         super.initialize(param1,param2);
      }
      
      override public function render(param1:int, param2:Boolean = false) : void
      {
         doMagic();
         super.render(param1,param2);
      }
      
      override public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         var _loc8_:Boolean = super.handleMouseEvent(param1,param2,param3,param4,param5,param6,param7);
         if(param3 == "click")
         {
            checkButtonHits(param1 + screenOffsetX,param2 + screenOffsetY);
         }
         return _loc8_;
      }
      
      private function getGeometry() : RoomGeometry
      {
         return geometry as RoomGeometry;
      }
      
      private function doMagic() : void
      {
         var _loc2_:IVector3d = null;
         var _loc3_:Vector3d = null;
         if(var_207 != 0)
         {
            _loc2_ = var_585;
            getGeometry().direction = new Vector3d(_loc2_.x + var_207,_loc2_.y,_loc2_.z);
            _loc2_ = getGeometry().direction;
            getGeometry().setDepthVector(new Vector3d(_loc2_.x,_loc2_.y,5));
            _loc3_ = new Vector3d();
            _loc3_.assign(_rotationOrigin);
            _loc3_.x += _rotationRodLength * Math.cos((_loc2_.x + 180) / 180 * 3.141592653589793) * Math.cos(_loc2_.y / 180 * 3.141592653589793);
            _loc3_.y += _rotationRodLength * Math.sin((_loc2_.x + 180) / 180 * 3.141592653589793) * Math.cos(_loc2_.y / 180 * 3.141592653589793);
            _loc3_.z += _rotationRodLength * Math.sin(_loc2_.y / 180 * 3.141592653589793);
            getGeometry().location = _loc3_;
            var_2113 = new Vector3d();
            var_2113.assign(_loc3_);
            var_585 = new Vector3d();
            var_585.assign(getGeometry().direction);
         }
         if(RoomShakingEffect.isVisualizationOn() && !var_1737)
         {
            changeShaking();
         }
         else if(!RoomShakingEffect.isVisualizationOn() && var_1737)
         {
            changeShaking();
         }
         if(RoomRotatingEffect.isVisualizationOn())
         {
            changeRotation();
         }
         if(var_1737)
         {
            var_493 = var_493 + 1;
            var _loc4_:IVector3d = var_585;
            var _loc1_:Vector3d = Vector3d.sum(null,new Vector3d(Math.sin(var_493 * 5 / 180 * 3.141592653589793) * 2,Math.sin(var_493 / 180 * 3.141592653589793) * 5,Math.sin(var_493 * 10 / 180 * 3.141592653589793) * 2));
            getGeometry().direction = null;
         }
         else
         {
            var_493 = 0;
            getGeometry().direction = var_585;
         }
      }
      
      private function createTestingTools() : void
      {
         if(_tools == null && displayObject is Sprite)
         {
            _tools = new Sprite();
            (displayObject as Sprite).addChild(_tools);
            var _loc4_:Array = [16776960,16711680,65280,11184810,11184810,11184810,11184810];
            var _loc1_:Rectangle = null;
            _loc1_ = new Rectangle(58,8,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(58,28,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(58,48,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(82,28,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(122,28,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(102,8,16,16);
            var_486.push(null);
            _loc1_ = new Rectangle(102,48,16,16);
            var_486.push(null);
            var _loc3_:int = 0;
            while(0 < var_486.length)
            {
               _loc1_ = var_486[0] as Rectangle;
               var _loc2_:int = 0;
               _tools.graphics.beginFill(0);
               _tools.graphics.drawRect(null.x - 1,null.y - 1,null.width + 2,null.height + 2);
               _tools.graphics.endFill();
               _loc2_ = int(null[0]);
               _tools.graphics.beginFill(0);
               _tools.graphics.drawRect(null.x,null.y,null.width,null.height);
               _tools.graphics.endFill();
               _loc3_++;
            }
            var_646.push(changeScale);
            var_646.push(changeShaking);
            var_646.push(changeRotation);
            var_646.push(moveLeft);
            var_646.push(moveRight);
            var_646.push(moveUp);
            var_646.push(moveDown);
         }
      }
      
      private function checkButtonHits(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Rectangle = null;
         _loc4_ = 0;
         while(_loc4_ < var_486.length)
         {
            _loc3_ = var_486[_loc4_] as Rectangle;
            if(param1 >= _loc3_.x && param1 <= _loc3_.x + _loc3_.width && param2 >= _loc3_.y && param2 <= _loc3_.y + _loc3_.height)
            {
               if(var_646.length > _loc4_)
               {
                  var_646[_loc4_]();
               }
            }
            _loc4_++;
         }
      }
      
      private function changeScale() : void
      {
         if(getGeometry().scale < 64)
         {
            getGeometry().scale = 64;
         }
         else
         {
            getGeometry().scale = 32;
         }
      }
      
      private function changeShaking() : void
      {
         var_1737 = !var_1737;
         if(var_1737)
         {
            var _loc1_:IVector3d = getGeometry().direction;
            var_585 = new Vector3d(null.x,null.y,null.z);
         }
      }
      
      private function changeRotation() : void
      {
         var _loc3_:IVector3d = null;
         var _loc1_:IVector3d = null;
         if(var_1737)
         {
            return;
         }
         if(var_207 == 0)
         {
            if(getGeometry() != null)
            {
               _loc3_ = getGeometry().location;
               _loc1_ = getGeometry().directionAxis;
               var_2113 = new Vector3d();
               var_2113.assign(_loc3_);
               var_585 = new Vector3d();
               var_585.assign(getGeometry().direction);
               var _loc2_:IVector3d = RoomGeometry.getIntersectionVector(_loc3_,_loc1_,new Vector3d(0,0,0),new Vector3d(0,0,1));
            }
         }
         else
         {
            var_207 = 0;
            if(getGeometry() != null)
            {
               getGeometry().location = var_2113;
               getGeometry().direction = var_585;
               getGeometry().setDepthVector(new Vector3d(var_585.x,var_585.y,5));
            }
         }
      }
      
      private function moveLeft() : void
      {
         var _loc1_:Number = NaN;
         if(var_207 != 0)
         {
            if(var_207 == 1)
            {
               var_207 = -1;
            }
            else
            {
               var_207 -= 1;
            }
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (getGeometry().direction.x - 90) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveRight() : void
      {
         var _loc1_:Number = NaN;
         if(var_207 != 0)
         {
            if(var_207 == -1)
            {
               var_207 = 1;
            }
            else
            {
               var_207 += 1;
            }
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (getGeometry().direction.x + 90) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveUp() : void
      {
         var _loc1_:Number = NaN;
         if(var_207 != 0)
         {
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = getGeometry().direction.x / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveDown() : void
      {
         var _loc1_:Number = NaN;
         if(var_207 != 0)
         {
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (geometry.direction.x + 180) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
   }
}

