package com.sulake.room
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.renderer.IRoomRendererBase;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class RoomInstance implements IRoomInstance
   {
      
      private var var_890:Dictionary;
      
      private var var_961:Dictionary;
      
      private var var_2393:Array;
      
      private var var_2597:Array;
      
      private var _managers:class_55;
      
      private var var_1124:Array;
      
      private var var_303:IRoomRendererBase;
      
      private var _container:IRoomInstanceContainer;
      
      private var var_197:String;
      
      public function RoomInstance(param1:String, param2:IRoomInstanceContainer)
      {
         super();
         _managers = new class_55();
         var_1124 = [];
         _container = param2;
         var_197 = param1;
         var_890 = new Dictionary();
         var_961 = new Dictionary();
         var_2393 = [];
         var_2597 = [];
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectManager = null;
         if(_managers != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _managers.length)
            {
               _loc1_ = _managers.getWithIndex(_loc2_) as IRoomObjectManager;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _managers.dispose();
            _managers = null;
         }
         if(var_303 != null)
         {
            var_303.dispose();
            var_303 = null;
         }
         _container = null;
         var_1124 = null;
         if(var_890 != null)
         {
            for(var _loc3_ in var_890)
            {
               delete var_890[null];
            }
            var_890 = null;
         }
         if(var_961 != null)
         {
            for(_loc3_ in var_961)
            {
               delete var_961[null];
            }
            var_961 = null;
         }
         var_2597 = [];
         var_2393 = [];
      }
      
      public function hasValueForName(param1:String) : Boolean
      {
         return param1 in var_890;
      }
      
      public function getNumber(param1:String) : Number
      {
         return var_890[param1];
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(var_2393.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2393.push(param1);
         }
         if(var_890[param1] != param2)
         {
            var_890[param1] = param2;
         }
      }
      
      public function getString(param1:String) : String
      {
         return var_961[param1];
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(var_2597.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2597.push(param1);
         }
         if(var_961[param1] != param2)
         {
            var_961[param1] = param2;
         }
      }
      
      public function addObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = int(var_1124.indexOf(param1));
         if(_loc2_ >= 0)
         {
            return;
         }
         var_1124.push(param1);
      }
      
      public function removeObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = int(var_1124.indexOf(param1));
         if(_loc2_ >= 0)
         {
            var_1124.splice(_loc2_,1);
         }
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:IRoomObjectManager = null;
         var _loc4_:int = 0;
         var _loc7_:IRoomObjectController = null;
         var _loc5_:IRoomObjectEventHandler = null;
         var _loc1_:int = getTimer();
         _loc3_ = var_1124.length - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = int(var_1124[_loc3_]);
            _loc2_ = getObjectManager(_loc6_);
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.getObjectCount() - 1;
               while(_loc4_ >= 0)
               {
                  _loc7_ = _loc2_.getObjectWithIndex(_loc4_);
                  if(_loc7_ != null)
                  {
                     _loc5_ = _loc7_.getEventHandler();
                     if(_loc5_ != null)
                     {
                        _loc5_.update(_loc1_);
                     }
                  }
                  _loc4_--;
               }
            }
            _loc3_--;
         }
      }
      
      public function createRoomObject(param1:int, param2:String, param3:int) : IRoomObject
      {
         if(_container != null)
         {
            return _container.createRoomObject(var_197,param1,param2,param3);
         }
         return null;
      }
      
      public function createObjectInternal(param1:int, param2:int, param3:String, param4:int) : IRoomObject
      {
         var _loc5_:IRoomObjectManager = createObjectManager(param4);
         if(_loc5_ != null)
         {
            var _loc6_:IRoomObjectController = _loc5_.createObject(param1,param2,param3);
            if(var_303 != null)
            {
               var_303.feedRoomObject(null);
            }
            return null;
         }
         return null;
      }
      
      public function getObject(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObject(param1);
         }
         return null;
      }
      
      public function getObjects(param1:int) : Array
      {
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         return _loc2_ ? _loc2_.getObjects() : [];
      }
      
      public function getObjectWithIndex(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObjectWithIndex(param1);
         }
         return null;
      }
      
      public function getObjectCount(param1:int) : int
      {
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         if(_loc2_ != null)
         {
            return _loc2_.getObjectCount();
         }
         return 0;
      }
      
      public function getObjectWithIndexAndType(param1:int, param2:String, param3:int) : IRoomObject
      {
         var _loc4_:IRoomObjectManager = getObjectManager(param3);
         if(_loc4_ != null)
         {
            return _loc4_.getObjectWithIndexAndType(param1,param2);
         }
         return null;
      }
      
      public function getObjectCountForType(param1:String, param2:int) : int
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObjectCountForType(param1);
         }
         return 0;
      }
      
      public function disposeObject(param1:int, param2:int) : Boolean
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            var _loc4_:IRoomObject = _loc3_.getObject(param1);
            if(_loc4_ != null)
            {
               null.tearDown();
               if(var_303)
               {
                  var_303.removeRoomObject(null);
               }
               return _loc3_.disposeObject(param1);
            }
         }
         return false;
      }
      
      public function disposeObjects(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:IRoomObjectController = null;
         var _loc3_:int = 0;
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getObjectCount();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc2_.getObjectWithIndex(_loc4_) as IRoomObjectController;
               if(_loc5_ != null)
               {
                  if(var_303)
                  {
                     var_303.removeRoomObject(_loc5_);
                  }
                  _loc5_.dispose();
               }
               _loc4_++;
            }
            _loc2_.reset();
         }
         return _loc3_;
      }
      
      public function setRenderer(param1:IRoomRendererBase) : void
      {
         if(param1 == var_303)
         {
            return;
         }
         if(var_303 != null)
         {
            var_303.dispose();
         }
         var_303 = param1;
         if(var_303 == null)
         {
            return;
         }
         var_303.reset();
         var _loc5_:Array = getObjectManagerIds();
         var _loc3_:int = _loc5_.length - 1;
         var _loc6_:int = int(_loc5_[0]);
         var _loc2_:int = getObjectCount(0);
         var _loc4_:int = 0 - 1;
         while(true)
         {
            var _loc7_:IRoomObjectController = getObjectWithIndex(0,0) as IRoomObjectController;
            if(_loc7_ != null)
            {
               var_303.feedRoomObject(null);
            }
            _loc4_--;
         }
      }
      
      public function getRenderer() : IRoomRendererBase
      {
         return var_303;
      }
      
      public function getObjectManagerIds() : Array
      {
         return _managers.getKeys();
      }
      
      protected function createObjectManager(param1:int) : IRoomObjectManager
      {
         var _loc3_:String = String(param1);
         if(_managers.getValue(_loc3_) != null)
         {
            return _managers.getValue(_loc3_) as IRoomObjectManager;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc2_:IRoomObjectManager = _container.createRoomObjectManager();
         if(_loc2_ != null)
         {
            _managers.add(_loc3_,_loc2_);
         }
         return _loc2_;
      }
      
      protected function getObjectManager(param1:int) : IRoomObjectManager
      {
         return _managers.getValue(String(param1)) as IRoomObjectManager;
      }
      
      protected function disposeObjectManager(param1:int) : Boolean
      {
         var _loc3_:String = String(param1);
         disposeObjects(param1);
         if(_managers.getValue(_loc3_) != null)
         {
            var _loc2_:IRoomObjectManager = _managers.remove(_loc3_) as IRoomObjectManager;
            return true;
         }
         return false;
      }
      
      public function hasUninitializedObjects() : Boolean
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc2_ in _managers)
         {
            _loc1_ = _loc2_.getObjectCount();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(!_loc2_.getObjectWithIndex(_loc3_).isInitialized())
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
   }
}

