package com.sulake.habbo.room.utils
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public class class_2247
   {
      
      private var var_1351:Vector.<Vector.<IRoomObject>>;
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      public function class_2247(param1:int, param2:int)
      {
         super();
         var_1351 = new Vector.<Vector.<IRoomObject>>(param2,true);
         var _loc3_:int = 0;
         while(0 < param2)
         {
            var_1351[0] = new Vector.<IRoomObject>(param1,true);
            _loc3_++;
         }
         _width = param1;
         var_385 = param2;
      }
      
      public function clear() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_1351)
         {
            _loc2_ = 0;
            while(_loc2_ < _width)
            {
               _loc1_[_loc2_] = null;
               _loc2_++;
            }
         }
      }
      
      public function populate(param1:Array) : void
      {
         clear();
         for each(var _loc2_ in param1)
         {
            addRoomObject(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var_1351 = null;
         _width = 0;
         var_385 = 0;
      }
      
      public function getObjectIntTile(param1:int, param2:int) : IRoomObject
      {
         if(param1 >= 0 && param1 < _width && param2 >= 0 && param2 < var_385)
         {
            return var_1351[param2][param1];
         }
         return null;
      }
      
      public function setObjectInTile(param1:int, param2:int, param3:IRoomObject) : void
      {
         if(!param3.isInitialized())
         {
            class_21.log("Assigning non initialized object to tile object map!");
            return;
         }
         if(param1 >= 0 && param1 < _width && param2 >= 0 && param2 < var_385)
         {
            var_1351[param2][param1] = param3;
         }
      }
      
      public function addRoomObject(param1:IRoomObject) : void
      {
         var _loc4_:IRoomObject = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null || param1.getModel() == null || !param1.isInitialized())
         {
            return;
         }
         var _loc2_:IVector3d = param1.getLocation();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc9_:IVector3d = param1.getDirection();
         if(_loc9_ == null)
         {
            return;
         }
         var _loc5_:int = param1.getModel().getNumber("furniture_size_x");
         var _loc10_:int = param1.getModel().getNumber("furniture_size_y");
         if(_loc5_ < 1)
         {
            _loc5_ = 1;
         }
         if(_loc10_ < 1)
         {
            _loc10_ = 1;
         }
         var _loc3_:int = 0;
         var _loc7_:int = (int(_loc9_.x + 45)) % 360 / 90;
         if(_loc7_ == 1 || _loc7_ == 3)
         {
            _loc3_ = _loc5_;
            _loc5_ = _loc10_;
            _loc10_ = _loc3_;
         }
         _loc8_ = _loc2_.y;
         while(_loc8_ < _loc2_.y + _loc10_)
         {
            _loc6_ = _loc2_.x;
            while(_loc6_ < _loc2_.x + _loc5_)
            {
               _loc4_ = getObjectIntTile(_loc6_,_loc8_);
               if(!_loc4_ || _loc4_ != param1 && _loc4_.getLocation().z <= _loc2_.z)
               {
                  setObjectInTile(_loc6_,_loc8_,param1);
               }
               _loc6_++;
            }
            _loc8_++;
         }
      }
      
      public function toString() : String
      {
         var _loc4_:IRoomObject = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < var_385)
         {
            _loc2_ = 0;
            while(_loc2_ < _width)
            {
               _loc4_ = var_1351[_loc3_][_loc2_];
               _loc1_ += (_loc4_ ? _loc4_.getId() : "x") + "\t";
               _loc2_++;
            }
            _loc1_ += "\n";
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

