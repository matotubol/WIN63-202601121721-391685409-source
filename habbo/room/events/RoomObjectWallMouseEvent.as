package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent
   {
      
      private var var_25:Number;
      
      private var var_26:Number;
      
      private var var_81:Number;
      
      private var var_3705:Vector3d = null;
      
      private var var_3676:Vector3d = null;
      
      private var var_3742:Vector3d = null;
      
      public function RoomObjectWallMouseEvent(param1:String, param2:IRoomObject, param3:String, param4:IVector3d, param5:IVector3d, param6:IVector3d, param7:Number, param8:Number, param9:Number, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false)
      {
         super(param1,param2,param3,param10,param11,param12,param13,param14,param15);
         var_3705 = new Vector3d();
         var_3705.assign(param4);
         var_3676 = new Vector3d();
         var_3676.assign(param5);
         var_3742 = new Vector3d();
         var_3742.assign(param6);
         var_25 = param7;
         var_26 = param8;
         var_81 = param9;
      }
      
      public function get wallLocation() : IVector3d
      {
         return var_3705;
      }
      
      public function get wallWidth() : IVector3d
      {
         return var_3676;
      }
      
      public function get wallHeight() : IVector3d
      {
         return var_3742;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get direction() : Number
      {
         return var_81;
      }
   }
}

