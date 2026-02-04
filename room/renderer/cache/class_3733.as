package com.sulake.room.renderer.cache
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_3733
   {
      
      private var var_4127:String = "";
      
      private var var_2795:int = -1;
      
      private var var_5051:int = -1;
      
      private var var_2663:Vector3d = new Vector3d();
      
      private var var_756:Vector3d = null;
      
      private var var_1146:Vector3d = null;
      
      private var var_4544:Boolean = false;
      
      public function class_3733(param1:String)
      {
         super();
         var_4127 = param1;
         var_756 = new Vector3d();
         var_1146 = new Vector3d();
      }
      
      public function get locationChanged() : Boolean
      {
         return var_4544;
      }
      
      public function dispose() : void
      {
         var_756 = null;
         var_1146 = null;
      }
      
      public function getScreenLocation(param1:IRoomObject, param2:IRoomGeometry) : IVector3d
      {
         var _loc3_:Number = NaN;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc6_:IVector3d = param1.getLocation();
         if(param2.updateId != var_2795 || param1.getUpdateID() != var_5051)
         {
            var_5051 = param1.getUpdateID();
            if(param2.updateId != var_2795 || _loc6_.x != var_2663.x || _loc6_.y != var_2663.y || _loc6_.z != var_2663.z)
            {
               var_2795 = param2.updateId;
               var_2663.assign(_loc6_);
               var _loc4_:Boolean = true;
            }
         }
         var_4544 = false;
         return var_756;
      }
   }
}

