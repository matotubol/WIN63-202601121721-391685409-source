package com.sulake.habbo.room.object
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomPlaneBitmapMaskData
   {
      
      public static const MASK_CATEGORY_WINDOW:String = "window";
      
      public static const MASK_CATEGORY_HOLE:String = "hole";
      
      private var var_190:Vector3d = null;
      
      private var var_230:String = null;
      
      private var var_191:String = null;
      
      public function RoomPlaneBitmapMaskData(param1:String, param2:IVector3d, param3:String)
      {
         super();
         this.type = param1;
         this.loc = param2;
         this.category = param3;
      }
      
      public function get loc() : IVector3d
      {
         return var_190;
      }
      
      public function set loc(param1:IVector3d) : void
      {
         if(var_190 == null)
         {
            var_190 = new Vector3d();
         }
         var_190.assign(param1);
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function set type(param1:String) : void
      {
         var_230 = param1;
      }
      
      public function get category() : String
      {
         return var_191;
      }
      
      public function set category(param1:String) : void
      {
         var_191 = param1;
      }
      
      public function dispose() : void
      {
         var_190 = null;
      }
   }
}

