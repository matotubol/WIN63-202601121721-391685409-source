package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public class class_2004
   {
      
      private var var_1951:int;
      
      private var var_24:XML;
      
      private var var_2808:String = null;
      
      private var var_2865:String = null;
      
      private var var_2981:String = null;
      
      private var var_4979:IVector3d;
      
      public function class_2004(param1:int, param2:XML)
      {
         super();
         var_1951 = param1;
         var_24 = param2;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get data() : XML
      {
         return var_24;
      }
      
      public function get floorType() : String
      {
         return var_2808;
      }
      
      public function set floorType(param1:String) : void
      {
         var_2808 = param1;
      }
      
      public function get wallType() : String
      {
         return var_2865;
      }
      
      public function set wallType(param1:String) : void
      {
         var_2865 = param1;
      }
      
      public function get landscapeType() : String
      {
         return var_2981;
      }
      
      public function set landscapeType(param1:String) : void
      {
         var_2981 = param1;
      }
      
      public function get cameraInitPosition() : IVector3d
      {
         return var_4979;
      }
      
      public function set cameraInitPosition(param1:IVector3d) : void
      {
         var_4979 = param1;
      }
   }
}

