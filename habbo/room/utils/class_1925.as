package com.sulake.habbo.room.utils
{
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_1925 implements ISelectedRoomObjectData
   {
      
      private var var_197:int = 0;
      
      private var var_191:int = 0;
      
      private var var_3823:String = "";
      
      private var var_190:Vector3d = null;
      
      private var var_772:Vector3d = null;
      
      private var var_3814:int = 0;
      
      private var var_4264:String = null;
      
      private var var_1966:IStuffData = null;
      
      private var var_61:int = -1;
      
      private var _animFrame:int = -1;
      
      private var var_359:String = null;
      
      public function class_1925(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int = 0, param7:String = null, param8:IStuffData = null, param9:int = -1, param10:int = -1, param11:String = null)
      {
         super();
         var_197 = param1;
         var_191 = param2;
         var_3823 = param3;
         var_190 = new Vector3d();
         var_190.assign(param4);
         var_772 = new Vector3d();
         var_772.assign(param5);
         var_3814 = param6;
         var_4264 = param7;
         var_1966 = param8;
         var_61 = param9;
         _animFrame = param10;
         var_359 = param11;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get operation() : String
      {
         return var_3823;
      }
      
      public function get loc() : Vector3d
      {
         return var_190;
      }
      
      public function get dir() : Vector3d
      {
         return var_772;
      }
      
      public function get typeId() : int
      {
         return var_3814;
      }
      
      public function get instanceData() : String
      {
         return var_4264;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get animFrame() : int
      {
         return _animFrame;
      }
      
      public function get posture() : String
      {
         return var_359;
      }
      
      public function dispose() : void
      {
         var_190 = null;
         var_772 = null;
      }
   }
}

