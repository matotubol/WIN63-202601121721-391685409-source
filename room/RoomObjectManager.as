package com.sulake.room
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.RoomObject;
   
   public class RoomObjectManager implements IRoomObjectManager
   {
      
      private var var_411:class_55;
      
      private var var_844:class_55;
      
      public function RoomObjectManager()
      {
         super();
         var_411 = new class_55();
         var_844 = new class_55();
      }
      
      public function dispose() : void
      {
         reset();
         if(var_411 != null)
         {
            var_411.dispose();
            var_411 = null;
         }
         if(var_844 != null)
         {
            var_844.dispose();
            var_844 = null;
         }
      }
      
      public function createObject(param1:int, param2:uint, param3:String) : IRoomObjectController
      {
         var _loc4_:RoomObject = new RoomObject(param1,param2,param3);
         return addObject(String(param1),param3,_loc4_);
      }
      
      private function addObject(param1:String, param2:String, param3:IRoomObjectController) : IRoomObjectController
      {
         if(var_411.getValue(param1) != null)
         {
            param3.dispose();
            return null;
         }
         var_411.add(param1,param3);
         var _loc4_:class_55 = getObjectsForType(param2);
         _loc4_.add(param1,param3);
         return param3;
      }
      
      private function getObjectsForType(param1:String, param2:Boolean = true) : class_55
      {
         var _loc3_:class_55 = var_844.getValue(param1);
         if(_loc3_ == null && param2)
         {
            _loc3_ = new class_55();
            var_844.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getObject(param1:int) : IRoomObjectController
      {
         return var_411.getValue(String(param1)) as IRoomObjectController;
      }
      
      public function getObjects() : Array
      {
         return var_411.getValues();
      }
      
      public function getObjectWithIndex(param1:int) : IRoomObjectController
      {
         return var_411.getWithIndex(param1) as IRoomObjectController;
      }
      
      public function getObjectCount() : int
      {
         return var_411.length;
      }
      
      public function getObjectCountForType(param1:String) : int
      {
         var _loc2_:class_55 = getObjectsForType(param1,false);
         if(_loc2_ != null)
         {
            return _loc2_.length;
         }
         return 0;
      }
      
      public function getObjectWithIndexAndType(param1:int, param2:String) : IRoomObjectController
      {
         var _loc3_:class_55 = getObjectsForType(param2,false);
         if(_loc3_ != null)
         {
            return _loc3_.getWithIndex(param1) as IRoomObjectController;
         }
         return null;
      }
      
      public function disposeObject(param1:int) : Boolean
      {
         var _loc4_:String = null;
         var _loc2_:class_55 = null;
         var _loc3_:String = String(param1);
         var _loc5_:RoomObject = var_411.remove(_loc3_) as RoomObject;
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.getType();
            _loc2_ = getObjectsForType(_loc4_,false);
            if(_loc2_ != null)
            {
               _loc2_.remove(_loc3_);
            }
            _loc5_.dispose();
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         var _loc2_:int = 0;
         var _loc4_:IRoomObjectController = null;
         var _loc3_:int = 0;
         var _loc1_:class_55 = null;
         if(var_411 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_411.length)
            {
               _loc4_ = var_411.getWithIndex(_loc2_) as IRoomObjectController;
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc2_++;
            }
            var_411.reset();
         }
         if(var_844 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < var_844.length)
            {
               _loc1_ = var_844.getWithIndex(_loc3_) as class_55;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            var_844.reset();
         }
      }
   }
}

