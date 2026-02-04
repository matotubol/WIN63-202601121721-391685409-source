package com.sulake.habbo.room.utils
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_2197
   {
      
      private var var_197:int = 0;
      
      private var var_3814:int = 0;
      
      private var var_230:String = null;
      
      private var var_190:Vector3d = new Vector3d();
      
      private var var_772:Vector3d = new Vector3d();
      
      private var var_61:int = 0;
      
      private var var_24:IStuffData = null;
      
      private var var_3221:Number = NaN;
      
      private var _expiryTime:int = -1;
      
      private var var_4056:int = 0;
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4963:Boolean = true;
      
      private var _realRoomObject:Boolean = true;
      
      private var var_2640:Number;
      
      public function class_2197(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1)
      {
         super();
         var_197 = param1;
         var_3814 = param2;
         var_230 = param3;
         var_190.assign(param4);
         var_772.assign(param5);
         var_61 = param6;
         var_24 = param7;
         var_3221 = param8;
         _expiryTime = param9;
         var_4056 = param10;
         var_1820 = param11;
         _ownerName = param12;
         var_4963 = param13;
         _realRoomObject = param14;
         var_2640 = param15;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get typeId() : int
      {
         return var_3814;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get loc() : IVector3d
      {
         return var_190;
      }
      
      public function get dir() : IVector3d
      {
         return var_772;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get data() : IStuffData
      {
         return var_24;
      }
      
      public function get extra() : Number
      {
         return var_3221;
      }
      
      public function get expiryTime() : int
      {
         return _expiryTime;
      }
      
      public function get usagePolicy() : int
      {
         return var_4056;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get synchronized() : Boolean
      {
         return var_4963;
      }
      
      public function get realRoomObject() : Boolean
      {
         return _realRoomObject;
      }
      
      public function get sizeZ() : Number
      {
         return var_2640;
      }
   }
}

