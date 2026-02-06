package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_2979
   {
      
      public static const const_1251:String = "mv";
      
      public static const const_1194:String = "sld";
      
      private var var_197:int = 0;
      
      private var var_190:Vector3d;
      
      private var var_202:Vector3d;
      
      private var var_3284:String;
      
      private var var_136:Boolean = false;
      
      public function class_2979(param1:int, param2:Vector3d, param3:Vector3d, param4:String = null)
      {
         super();
         var_197 = param1;
         var_190 = param2;
         var_202 = param3;
         var_3284 = param4;
      }
      
      public function setReadOnly() : void
      {
         var_136 = true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get loc() : Vector3d
      {
         return var_190;
      }
      
      public function set loc(param1:Vector3d) : void
      {
         if(!var_136)
         {
            var_190 = param1;
         }
      }
      
      public function get target() : Vector3d
      {
         return var_202;
      }
      
      public function set target(param1:Vector3d) : void
      {
         if(!var_136)
         {
            var_202 = param1;
         }
      }
      
      public function get moveType() : String
      {
         return var_3284;
      }
      
      public function set moveType(param1:String) : void
      {
         if(!var_136)
         {
            var_3284 = param1;
         }
      }
   }
}

