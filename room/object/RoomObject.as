package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.*;
   
   public class RoomObject implements IRoomObjectController
   {
      
      private static var var_4721:int = 0;
      
      private var var_197:int;
      
      private var var_230:String = "";
      
      private var var_190:Vector3d;
      
      private var var_772:Vector3d;
      
      private var var_3665:Vector3d;
      
      private var var_3716:Vector3d;
      
      private var var_1244:Array;
      
      private var var_36:RoomObjectModel;
      
      private var _visualization:IRoomObjectVisualization;
      
      private var var_678:IRoomObjectEventHandler;
      
      private var var_50:int;
      
      private var _avatarLibraryAssetName:String;
      
      private var var_3637:int = 0;
      
      private var var_265:Boolean = false;
      
      public function RoomObject(param1:int, param2:int, param3:String)
      {
         var _loc4_:Number = NaN;
         super();
         var_197 = param1;
         var_190 = new Vector3d();
         var_772 = new Vector3d();
         var_3665 = new Vector3d();
         var_3716 = new Vector3d();
         var_1244 = new Array(param2);
         _loc4_ = param2 - 1;
         while(_loc4_ >= 0)
         {
            var_1244[_loc4_] = 0;
            _loc4_--;
         }
         var_230 = param3;
         var_36 = new RoomObjectModel();
         _visualization = null;
         var_678 = null;
         var_50 = 0;
         var_3637 = var_4721++;
      }
      
      public function dispose() : void
      {
         var_190 = null;
         var_772 = null;
         var_1244 = null;
         _avatarLibraryAssetName = null;
         setVisualization(null);
         setEventHandler(null);
         if(var_36 != null)
         {
            var_36.dispose();
            var_36 = null;
         }
      }
      
      public function setInitialized(param1:Boolean) : void
      {
         var_265 = param1;
      }
      
      public function isInitialized() : Boolean
      {
         return var_265;
      }
      
      public function getId() : int
      {
         return var_197;
      }
      
      public function getInstanceId() : int
      {
         return var_3637;
      }
      
      public function getType() : String
      {
         return var_230;
      }
      
      public function getLocation() : IVector3d
      {
         var_3665.assign(var_190);
         return var_3665;
      }
      
      public function getDirection() : IVector3d
      {
         var_3716.assign(var_772);
         return var_3716;
      }
      
      public function getModel() : IRoomObjectModel
      {
         return var_36;
      }
      
      public function getModelController() : IRoomObjectModelController
      {
         return var_36;
      }
      
      public function getState(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_1244.length)
         {
            return var_1244[param1];
         }
         return -1;
      }
      
      public function getVisualization() : IRoomObjectVisualization
      {
         return _visualization;
      }
      
      public function setLocation(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_190.x != param1.x || var_190.y != param1.y || var_190.z != param1.z)
         {
            var_190.x = param1.x;
            var_190.y = param1.y;
            var_190.z = param1.z;
            var_50 = var_50 + 1;
         }
      }
      
      public function setDirection(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_772.x != param1.x || var_772.y != param1.y || var_772.z != param1.z)
         {
            var_772.x = (param1.x % 360 + 360) % 360;
            var_772.y = (param1.y % 360 + 360) % 360;
            var_772.z = (param1.z % 360 + 360) % 360;
            var_50 = var_50 + 1;
         }
      }
      
      public function setState(param1:int, param2:int) : Boolean
      {
         if(param2 >= 0 && param2 < var_1244.length)
         {
            if(var_1244[param2] != param1)
            {
               var_1244[param2] = param1;
               var_50 = var_50 + 1;
            }
            return true;
         }
         return false;
      }
      
      public function setVisualization(param1:IRoomObjectVisualization) : void
      {
         if(param1 != _visualization)
         {
            if(_visualization != null)
            {
               _visualization.dispose();
            }
            _visualization = param1;
            if(_visualization != null)
            {
               _visualization.object = this;
            }
         }
      }
      
      public function setEventHandler(param1:IRoomObjectEventHandler) : void
      {
         if(param1 == var_678)
         {
            return;
         }
         var _loc2_:IRoomObjectEventHandler = var_678;
         if(_loc2_ != null)
         {
            var_678 = null;
            _loc2_.object = null;
         }
         var_678 = param1;
         if(var_678 != null)
         {
            var_678.object = this;
         }
      }
      
      public function getEventHandler() : IRoomObjectEventHandler
      {
         return var_678;
      }
      
      public function getUpdateID() : int
      {
         return var_50;
      }
      
      public function getMouseHandler() : IRoomObjectMouseHandler
      {
         return getEventHandler();
      }
      
      public function getAvatarLibraryAssetName() : String
      {
         if(!_avatarLibraryAssetName)
         {
            _avatarLibraryAssetName = "avatar_" + getId();
         }
         return _avatarLibraryAssetName;
      }
      
      public function tearDown() : void
      {
         if(var_678)
         {
            var_678.tearDown();
         }
      }
   }
}

