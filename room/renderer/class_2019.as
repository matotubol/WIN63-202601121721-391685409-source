package com.sulake.room.renderer
{
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.RoomGeometry;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_2019 implements IRoomRenderer, class_2018
   {
      
      private var var_411:class_55;
      
      private var var_291:class_55;
      
      private var var_59:class_17;
      
      private var _disposed:Boolean = false;
      
      private var var_4127:String = null;
      
      public function class_2019(param1:class_17)
      {
         super();
         var_411 = new class_55();
         var_291 = new class_55();
         if(param1 != null)
         {
            var_59 = param1;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get roomObjectVariableAccurateZ() : String
      {
         return var_4127;
      }
      
      public function set roomObjectVariableAccurateZ(param1:String) : void
      {
         var_4127 = param1;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_3523 = null;
         if(disposed)
         {
            return;
         }
         if(var_291 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_291.length)
            {
               _loc1_ = var_291.getWithIndex(_loc2_) as class_3523;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_291.dispose();
            var_291 = null;
         }
         if(var_411 != null)
         {
            var_411.dispose();
            var_411 = null;
         }
         if(var_59 != null)
         {
            var_59 = null;
         }
         _disposed = true;
      }
      
      public function reset() : void
      {
         var_411.reset();
      }
      
      public function getRoomObjectIdentifier(param1:IRoomObject) : String
      {
         if(param1 != null)
         {
            return String(param1.getInstanceId());
         }
         return null;
      }
      
      public function feedRoomObject(param1:IRoomObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_411.add(getRoomObjectIdentifier(param1),param1);
      }
      
      public function removeRoomObject(param1:IRoomObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3523 = null;
         var _loc4_:String = getRoomObjectIdentifier(param1);
         var_411.remove(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < var_291.length)
         {
            _loc2_ = var_291.getWithIndex(_loc3_) as class_3523;
            if(_loc2_ != null)
            {
               _loc2_.roomObjectRemoved(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function getRoomObject(param1:String) : IRoomObject
      {
         return var_411.getValue(param1) as IRoomObject;
      }
      
      public function getRoomObjectWithIndex(param1:int) : IRoomObject
      {
         return var_411.getWithIndex(param1) as IRoomObject;
      }
      
      public function getRoomObjectIdWithIndex(param1:int) : String
      {
         return var_411.getKey(param1) as String;
      }
      
      public function getRoomObjectCount() : int
      {
         return var_411.length;
      }
      
      public function render() : void
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomRenderingCanvas = null;
         var _loc1_:int = getTimer();
         ErrorReportStorage.addDebugData("Canvas count",String(var_291.length));
         _loc3_ = var_291.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_291.getWithIndex(_loc3_) as IRoomRenderingCanvas;
            if(_loc2_ != null)
            {
               _loc2_.render(_loc1_);
            }
            _loc3_--;
         }
      }
      
      public function createCanvas(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         var _loc5_:IRoomRenderingCanvas = var_291.getValue(String(param1)) as IRoomRenderingCanvas;
         if(_loc5_ != null)
         {
            _loc5_.initialize(param2,param3);
            var _loc6_:RoomGeometry = _loc5_.geometry as RoomGeometry;
            if(_loc6_)
            {
               null.scale = param4;
            }
            return _loc5_;
         }
         _loc5_ = createCanvasInstance(param1,param2,param3,param4);
         var_291.add(String(param1),_loc5_);
         return _loc5_;
      }
      
      protected function createCanvasInstance(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         return new class_3609(this,param1,param2,param3,param4);
      }
      
      public function getCanvas(param1:int) : IRoomRenderingCanvas
      {
         return var_291.getValue(String(param1)) as IRoomRenderingCanvas;
      }
      
      public function disposeCanvas(param1:int) : Boolean
      {
         var _loc2_:class_3523 = var_291.remove(String(param1)) as class_3523;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3523 = null;
         render();
         _loc3_ = var_291.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_291.getWithIndex(_loc3_) as class_3523;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc3_--;
         }
      }
   }
}

